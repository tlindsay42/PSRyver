function Assert-RyverApiConfig {
    <#
    .SYNOPSIS
        Validates the Ryver REST API configuration.

    .DESCRIPTION
        Validates that the $Script:PSPRyver.RestApiBaseUri and
        $Script:PSPRyver.Authorization values are set to valid
        specifications, and throws terminating errors if not.

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Assert-RyverApiConfig
        Validates that the $Script:PSPRyver.RestApiBaseUri and
        $Script:PSPRyver.Authorization values are set to valid
        specifications, and throws terminating errors if not.

    .LINK
        https://tlindsay42.github.io/PSRyver/Private/Assert-RyverApiConfig/

    .LINK
        https://github.com/PSRyver/blob/master/PSRyver/Private/Assert-RyverApiConfig.ps1

    .FUNCTIONALITY
        Ryver
    #>

    [CmdletBinding()]
    [OutputType( [Boolean] )]
    param ()

    begin {
        $function = $MyInvocation.MyCommand.Name

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )
    }

    process {
        if ( $Script:PSRyver.RestApiBaseUri -notmatch '^https://\w+.ryver.com(?::443)?/api/1/odata.svc$' ) {
            throw "Invalid PSRyver RestApiBaseUri config value: '$( $Script:PSRyver.RestApiBaseUri )'.  Please run 'Set-PSRyverConfig -RestApiBaseUri `$uri'."
        }

        if ( $Script:PSRyver.Authorization -notmatch '^Basic \S+$' ) {
            throw "Invalid PSRyver Authorization config value: '$( $Script:PSRyver.Authorization )'.  Please run 'Set-PSRyverConfig -Credential ( Get-Credential )'."
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
