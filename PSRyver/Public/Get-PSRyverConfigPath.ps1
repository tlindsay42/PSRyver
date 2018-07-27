function Get-PSRyverConfigPath {
    <#
    .SYNOPSIS
        Retrieves the PSRyver config file path.

    .DESCRIPTION
        Retrieves the PSRyver config file path.

    .INPUTS
        None
            You cannot pipe input to this cmdlet.

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Get-PSRyverConfigPath
        Retrieves the PSRyver config file path.

    .LINK
        https://tlindsay42.github.io/PSRyver/Public/Get-PSRyverConfigPath/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Get-PSRyverConfigPath.ps1

    .LINK
        Set-PSRyverConfigPath

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Public/Get-PSRyverConfigPath/'
    )]
    [OutputType( [System.IO.FileInfo] )]
    param ()

    begin {
        $function = $MyInvocation.MyCommand.Name

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )
    }

    process {
        if ( -not $Script:PSRyverConfigFilePath ) {
            [System.IO.FileInfo] $Script:PSRyverConfigFilePath = Resolve-Path -Path '~' -ErrorAction 'Stop' |
                Join-Path -ChildPath '.psryver.xml'

            if ( ( Test-Path -Path $Script:PSRyverConfigFilePath ) -eq $true ) {
                [System.IO.FileInfo] $Script:PSRyverConfigFilePath = Get-Item -Path $Script:PSRyverConfigFilePath -ErrorAction 'Stop'
            }
        }

        $Script:PSRyverConfigFilePath
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
