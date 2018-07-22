function Remove-PSRyverConfig {
    <#
    .SYNOPSIS
        Remove the PSRyver module configuration.

    .DESCRIPTION
        Remove the PSRyver module configuration by removing the $Script:PSRyver
        variable.  Run 'Import-PSRyverConfig' or 'Initialize-PSRyverConfig' to
        recreate it.

    .INPUTS
        None
            You cannot pipe input to this cmdlet.

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Remove-PSRyverConfig
        Remove the PSRyver module configuration by removing the $Script:PSRyver
        variable.

    .LINK
        https://tlindsay42.github.io/PSRyver/Public/Remove-PSRyverConfig/

    .LINK
        https://github.com/PSRyver/blob/master/PSRyver/Public/Remove-PSRyverConfig.ps1

    .LINK
        Get-PSRyverConfig

    .LINK
        Initialize-PSRyverConfig

    .LINK
        Export-PSRyverConfig

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Public/Remove-PSRyverConfig/',
        SupportsShouldProcess = $true,
        ConfirmImpact = 'High'
    )]
    [OutputType( [Void] )]
    param ()

    begin {
        $function = $MyInvocation.MyCommand.Name

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )
    }

    process {
        if ( $PSCmdlet.ShouldProcess( '$Script:PSRyver', 'Remove the PSRyver config' ) ) {
            $Script:PSRyver = $null
            Remove-Variable -Name 'PSRyver' -Scope 'Script' -Force
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
