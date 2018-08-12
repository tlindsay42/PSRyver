function Test-IsWindows {
    <#
    .SYNOPSIS
        Is this running on a Windows system?

    .DESCRIPTION
        Is this running on a Windows system?

    .INPUTS
        None
            You cannot pipe input to this cmdlet.

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Test-IsWindows
        Returns $true if called from a Windows system and $false if not.

    .LINK
        https://tlindsay42.github.io/PSRyver/Private/Test-IsWindows/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Test-IsWindows.ps1

    .FUNCTIONALITY
        PowerShell Language
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Private/Test-IsWindows/'
    )]
    [OutputType( [Boolean] )]
    param ()

    begin {
        $function = $MyInvocation.MyCommand.Name
        Write-Verbose -Message "Beginning: '${function}'."
    }

    process {
        Write-Verbose -Message (
            "Processing: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )

        -not ( Test-Path -Path 'Variable:\IsWindows' ) -or $IsWindows
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
