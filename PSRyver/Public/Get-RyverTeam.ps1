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

        .LINK
        https://tlindsay42.github.io/PSRyver/Public/Get-RyverTeam/

        .LINK
        https://github.com/PSRyver/blob/master/PSRyver/Public/Get-RyverTeam.ps1

        .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Public/Get-RyverTeam/'
    )]
    [OutputType( [PSCustomObject] )]
    param (
        # Private team channel name.  Case insensitive.
        [Parameter(
            Position = 0,
            ValueFromPipeline = $true
        )]
        [SupportsWildcards()]
        [String]
        $Name,

        # Specifies whether to retrieve additional details about each object.
        [Parameter( Position = 1 )]
        [Switch]
        $Detailed,

        # Specifies that objects should not be formatted.
        [Parameter( Position = 2 )]
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
        #endregion

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize -Wrap | Out-String )
        )

        if ( $PSBoundParameters.ContainsKey( 'Credential' ) ) {
            $Script:PSRyver.Authorization = ConvertTo-Authorization -Credential $Credential
            Remove-Variable -Name 'Credential'
        }

        Assert-RyverApiConfig
    }

    process {
        #region init
        $skip = 0
        $urlEncodedName = [System.Web.HttpUtility]::UrlEncodeUnicode( $Name )
        $objects = @()
        #endregion

        #region Build the URI path
        $path = '/workrooms?'

        if ( $Name ) {
            $path += "`$search=$urlEncodedName"
        }

        $path += '&$select=*'

        if ( $Detailed -eq $true ) {
            $path += ",${detailedPropertiesSelect}" + "&`$expand=${detailedPropertiesExpand}"
        }

        $path += "&`$top=${Script:MaxPageSize}" + "&`$skip=${skip}" + '&$orderby=name+asc' + '&$inlinecount=allpages'
        #endregion

        $splat = @{
            Method      = 'Get'
            Path        = $path
            ErrorAction = 'Stop'
        }

        do {
            $response = Send-RyverApi @splat

            Write-Verbose -Message "Found '$( $response.D.__Count )' objects."
            Write-Verbose -Message "Queried for objects '${skip}-$( $skip + $Script:MaxPageSize )'."

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
            Write-Verbose -Message "Gathered '$( ( $objects | Measure-Object ).Count )' objects."

            $skip += $Script:MaxPageSize
            $splat.Path = $path -replace '\$skip=\d+', "`$skip=${skip}"
        }
        while ( $skip -lt $response.D.__Count )

        if ( $Raw -eq $true ) {
            $objects
        }
        else {
            $objects |
                Format-RyverV1ChannelObject
        }

        Write-Verbose -Message "Returned '$( ( $objects | Measure-Object ).Count )' objects."
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}