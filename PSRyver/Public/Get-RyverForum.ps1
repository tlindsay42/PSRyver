function Get-RyverForum {
    <#
    .SYNOPSIS
        Query for Ryver public forum channels.

    .DESCRIPTION
        Query for Ryver public forum channels.

    .INPUTS
        System.String

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Get-RyverForum -ID 12345678
        Queries for the public forum channel with ID 12345678.

    .EXAMPLE
        12345678 | Get-RyverForum
        Queries for the public forum channel with ID 12345678 via pipeline value.

    .EXAMPLE
        Get-RyverForum 12345678
        Queries for the public forum channel with ID 12345678 via positional parameter.

    .EXAMPLE
        Get-RyverForum -Name 'All Hands'
        Queries for the 'All Hands' public forum channel.

    .EXAMPLE
        Get-RyverForum -Name 'All Hand*' -Credential ( Get-Credential )
        Updates the $Script:PSRyver.Authorization value storing the basic
        authentication authorization header to use for all requests and then queries
        for all public forum channels starting with the string 'All Hand', such as
        'All Hands' and 'All handsome guys like that Troy fellow'. =D

    .EXAMPLE
        'All Hands' | Get-RyverForum -Detailed
        Queries for detailed information about the 'All Hands' public forum channel via
        the pipeline.

    .EXAMPLE
        '*and*' | Get-RyverForum -Raw
        Queries for all public forum channels containing the string 'and', such as
        'All Hands' and 'The Land of Magical Unicorns' and returns the raw, unformatted
        output.

    .EXAMPLE
        Get-RyverForum 'All Hands' $true $true
        Queries for detailed information about the 'All Hands' public forum channel via
        positional parameters and returns the raw, unformatted output.

    .EXAMPLE
        [PSCustomObject] @{ ID = [UInt64] 12345678 } | Get-RyverForum
        Queries for the public forum channel with ID 12345678 via pipeline parameter
        name.

    .EXAMPLE
        [PSCustomObject] @{ Name = 'All Hands' } | Get-RyverForum
        Queries for the 'All Hands' public forum channel via pipeline parameter name.

    .LINK
        https://tlindsay42.github.io/PSRyver/Public/Get-RyverForum/

    .LINK
        https://github.com/PSRyver/blob/master/PSRyver/Public/Get-RyverForum.ps1

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Public/Get-RyverForum/',
        DefaultParameterSetName = 'ID',
        SupportsPaging = $true
    )]
    [OutputType( [PSCustomObject[]] )]
    [OutputType( [PSCustomObject] )]
    param (
        # Specifies the public forum channel ID.
        [Parameter(
            ParameterSetName = 'ID',
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [UInt64]
        $ID,

        # Specifies the public forum channel name.  Case insensitive.
        [Parameter(
            ParameterSetName = 'Name',
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [SupportsWildcards()]
        [String]
        $Name,

        # Specifies whether to retrieve additional details about each object.
        [Parameter(
            Position = 1,
            ValueFromPipelineByPropertyName = $true
        )]
        [Switch]
        $Detailed,

        # Specifies that objects should not be formatted.
        [Parameter(
            Position = 2,
            ValueFromPipelineByPropertyName = $true
        )]
        [Switch]
        $Raw,

        <#
        Credentials to use for the Ryver API.

        Default value is the value set by Set-PSRyverConfig.
        #>
        [Parameter( Position = 3 )]
        [PSCredential]
        $Credential
    )

    begin {
        #region init
        $function = $MyInvocation.MyCommand.Name
        $return = @()
        $detailedProperties = @(
            'board/id',
            'createUser/*',
            'modifyUser/*',
            'securityGroup/*',
            'administratorsGroup/*',
            'moderatorsGroup/*',
            'members/*',
            'acl/id',
            'externalLinks/*'
        )
        $detailedPropertiesSelect = ( $detailedProperties | ForEach-Object -Process { [System.Web.HttpUtility]::UrlEncodeUnicode( $_ ) } ) -join ','
        $detailedPropertiesExpand = ( $detailedProperties | ForEach-Object -Process { $_.Split( '/' )[0] } ) -join ','
        $first = $PSCmdlet.PagingParameters.Skip
        $last = $first + $PSCmdlet.PagingParameters.First
        #endregion

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize -Wrap | Out-String )
        )

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
        #region init
        $skip = 0
        $count = [UInt64]::MaxValue
        $objects = @()
        #endregion

        #region Build the URI path
        if ( $ID ) {
            $path = "/forums(${ID})?"
        }
        else {
            $path = '/forums?'

            if ( $PSBoundParameters.ContainsKey( 'Name' ) ) {
                $path += "`$search=$( [System.Web.HttpUtility]::UrlEncodeUnicode( $Name ) )&"
            }
        }

        $path += '$select=*'

        if ( $Detailed -eq $true ) {
            $path += (
                ",${detailedPropertiesSelect}" +
                "&`$expand=${detailedPropertiesExpand}"
            )
        }

        $path += (
            "&`$top=$( $Script:PSRyver.MaxPageSize )" +
            "&`$skip=${skip}" +
            '&$orderby=name+asc' +
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
                    $_.__Descriptor -like $Name
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
                    $return = $return[$first..$last]

                    if ( $Raw -eq $true ) {
                        $return
                    }
                    else {
                        $return |
                            Format-RyverChannelObject
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
