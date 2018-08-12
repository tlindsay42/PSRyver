function Get-RyverTeam {
    <#
    .SYNOPSIS
        Query for Ryver private team channels.

    .DESCRIPTION
        Query for Ryver private team channels.

    .INPUTS
        System.String

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Get-RyverTeam -ID 12345678
        Queries for the private team channel with ID 12345678.

    .EXAMPLE
        12345678 | Get-RyverTeam
        Queries for the private team channel with ID 12345678 via pipeline value.

    .EXAMPLE
        Get-RyverTeam 12345678
        Queries for the private team channel with ID 12345678 via positional parameter.

    .EXAMPLE
        Get-RyverTeam -Name 'Members Only!'
        Queries for the 'Members Only!' private team channel.

    .EXAMPLE
        Get-RyverTeam -Name '*Only*' -Credential ( Get-Credential )
        Updates the $Script:PSRyver.Authorization value storing the basic
        authentication authorization header to use for all requests and then queries
        for all private team channels containing the string 'Only', such as
        'Members Only!' and 'Ninjas only'.

    .EXAMPLE
        'Members Only!' | Get-RyverTeam -Raw
        Queries for the 'Members Only!' private team channel via the pipeline and
        returns the raw, unformatted output.

    .EXAMPLE
        '*Member*' | Get-RyverTeam -Detailed
        Queries for detailed information about all private team channels containing the
        string 'Member', such as 'Members Only!' and 'Illuminati Membership Committee'.

    .EXAMPLE
        Get-RyverTeam 'Members Only!' $true $true
        Queries for detailed information about the 'Members Only!' private team channel
        via positional parameters and returns the raw, unformatted output.

    .EXAMPLE
        [PSCustomObject] @{ ID = [UInt64] 12345678 } | Get-RyverTeam
        Queries for the private team channel with ID 12345678 via pipeline parameter
        name.

    .EXAMPLE
        [PSCustomObject] @{ Name = 'Members Only!' } | Get-RyverTeam
        Queries for the 'Members Only!' private team channel via pipeline parameter
        name.

    .LINK
        https://tlindsay42.github.io/PSRyver/Public/Get-RyverTeam/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Get-RyverTeam.ps1

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Public/Get-RyverTeam/',
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

        # Private team channel name.  Case insensitive.
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
        $function = $MyInvocation.MyCommand.Name
        Write-Verbose -Message "Beginning: '${function}'."

        #region init
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
        $skip = 0
        $count = [UInt64]::MaxValue
        $objects = @()
        #endregion

        #region Build the URI path
        if ( $ID ) {
            $path = "/workrooms(${ID})?"
        }
        else {
            $path = '/workrooms?'

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
