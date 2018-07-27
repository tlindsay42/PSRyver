function Get-PSRyverConfig {
    <#
    .SYNOPSIS
        Get the PSRyver module configuration.

    .DESCRIPTION
        Get the PSRyver module configuration stored in the $Script:PSRyver variable.

    .INPUTS
        None
            You cannot pipe input to this cmdlet.

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Get-PSRyverConfig
        Returns the value of the $Script:PSRyver module configuration variable.

    .LINK
        https://tlindsay42.github.io/PSRyver/Public/Get-PSRyverConfig/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Get-PSRyverConfig.ps1

    .LINK
        Set-PSRyverConfig

    .LINK
        Initialize-PSRyverConfig

    .LINK
        Remove-PSRyverConfig

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Public/Get-PSRyverConfig/'
    )]
    [OutputType( [PSCustomObject] )]
    param ()

    begin {
        $function = $MyInvocation.MyCommand.Name

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )
    }

    process {
        $Script:PSRyver
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
