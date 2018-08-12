function Find-RyverTopic {
    <#
    .SYNOPSIS
        Find Ryver topics.

    .DESCRIPTION
        Queries for the specified search text in the topics in all public forums &
        private teams that the user is a member of, as well as all direct message
        topics that match the search text.

    .INPUTS
        System.String

    .INPUTS
        System.Management.Automation.PSCustomObject

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Find-RyverTopic -SearchText 'Hello world!' -Credential ( Get-Credential )
        Updates the $Script:PSRyver.Authorization value storing the basic
        authorization header to use for all requests and then queries all topics
        containing the text 'Hello world!' in all public forums & private teams that
        the user is a member of, as well as all direct messages.

    .EXAMPLE
        'Hello world!' | Find-RyverTopic -Raw
        Queries all topics containing the text 'Hello world!' via the pipeline in all
        public forums & private teams that the user is a member of, as well as all
        direct messages, and returns the raw, unformatted output.

    .EXAMPLE
        [PSCustomObject] @{ SearchText = 'Hello world!' } | Find-RyverTopic
        Queries all topics containing the text 'Hello world!' via the pipeline by
        parameter name in all public forums & private teams that the user is a member
        of, as well as all direct messages.

    .EXAMPLE
        Find-RyverTopic 'Hello world!'
        Queries for all topics containing the text 'Hello world!' via positional
        parameter.

    .LINK
        https://tlindsay42.github.io/PSRyver/Public/Find-RyverTopic/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Find-RyverTopic.ps1

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Public/Find-RyverTopic/',
        SupportsPaging = $true
    )]
    [OutputType( [PSCustomObject[]] )]
    [OutputType( [PSCustomObject] )]
    param (
        # Specifies the text to search for.
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [SupportsWildcards()]
        [String]
        $SearchText,

        # Specifies that objects should not be formatted.
        [Parameter( Position = 1 )]
        [Switch]
        $Raw,

        <#
        Credentials to use for the Ryver API.

        Default value is the value set by Set-PSRyverConfig.
        #>
        [Parameter( Position = 2 )]
        [PSCredential]
        $Credential
    )

    begin {
        $function = $MyInvocation.MyCommand.Name
        Write-Verbose -Message "Beginning: '${function}'."

        #region init
        $return = @()
        $first = $PSCmdlet.PagingParameters.Skip
        $last = $first + $PSCmdlet.PagingParameters.First
        #endregion

        Write-Verbose -Message "First index position: '${first}'."

        if ( $PSBoundParameters.ContainsKey( 'Credential' ) ) {
            $Script:PSRyver.Authorization = ConvertTo-Authorization -Credential $Credential
            Remove-Variable -Name 'Credential'
        }

        Assert-RyverApiConfig

        if ( $PSCmdlet.PagingParameters.First -eq 0 ) {
            Write-Verbose -Message "The 'First' parameter is set to accept zero results- terminating."
            break
        }
    }

    process {
        Write-Verbose -Message (
            "Processing: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize -Wrap | Out-String )
        )

        #region init
        $path = ''
        $skip = 0
        $count = [UInt64]::MaxValue
        $objects = @()
        #endregion

        #region Build the URI path
        $path += (
            '/Search.Global(' + (
                "query='$( [System.Web.HttpUtility]::UrlEncodeUnicode( $SearchText ) )'," +
                "type='Entity.Post'," +
                'highlight=false'
            ) + ')?' +
            "`$top=$( $Script:PSRyver.MaxPageSize )" +
            "&`$skip=${skip}" +
            '&$inlinecount=allpages'
        )
        #endregion

        $splat = @{
            Method      = 'Get'
            Path        = $path
            ErrorAction = 'Stop'
        }

        while ( $return.Count -lt $last -and $skip -lt $count ) {
            $response = Invoke-RyverRestMethod @splat
            [UInt64] $count = $response.D.__Count

            Write-Verbose -Message "Found '${count}' objects."
            Write-Verbose -Message "Queried for objects '${skip}-$( $skip + $Script:PSRyver.MaxPageSize )'."

            $tempObjects = $response |
                Select-Object -ExpandProperty 'D' |
                Select-Object -ExpandProperty 'Results'

            if ( $Name ) {
                Write-Verbose -Message "Received '$( ( $tempObjects | Measure-Object ).Count )' objects with server-side filtering."

                $tempObjects = $tempObjects |
                    Where-Object -FilterScript {
                    $_.Name -like $Name
                }

                Write-Verbose -Message "Filtered to '$( ( $tempObjects | Measure-Object ).Count )' objects after client-side filtering."
            }

            $objects += $tempObjects

            $skip += $Script:PSRyver.MaxPageSize
            $splat.Path = $path -replace '\$skip=\d+', "`$skip=${skip}"

            $return += $objects
        }

        Write-Verbose -Message "Added '$( ( $objects | Measure-Object ).Count )' objects in this Process cycle."
    }

    end {
        $count = ( $return | Measure-Object ).Count
        if ( $count -gt 0 ) {
            if ( $PSCmdlet.PagingParameters.Skip -ge $count ) {
                Write-Verbose -Message "Insufficient results: '${count}' to satisfy the 'Skip' parameter value: '${first}'."
                $return = $null
            }
            else {
                $last = $first + [Math]::Min( $PSCmdlet.PagingParameters.First, $count - $PSCmdlet.PagingParameters.Skip ) - 1
                Write-Verbose -Message "Last index position: '${last}'."

                if ( $first -le $last ) {
                    $return = $return[$first..$last] |
                        Sort-Object -Property 'when'

                    if ( $Raw -eq $true ) {
                        $return
                    }
                    else {
                        $return |
                            Format-RyverTopicObject
                    }
                }
                else {
                    $return = $null
                }
            }
        }

        $count = ( $return | Measure-Object ).Count
        Write-Verbose -Message "Returned '${count}' objects."
        if ( $PSCmdlet.PagingParameters.IncludeTotalCount ) {
            $PSCmdlet.PagingParameters.NewTotalCount( $count, 1.0 )
        }

        Write-Verbose -Message "Ending: '${function}'."
    }
}
