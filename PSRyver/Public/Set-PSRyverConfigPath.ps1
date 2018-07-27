function Set-PSRyverConfigPath {
    <#
    .SYNOPSIS
        Sets the PSRyver config file path.

    .DESCRIPTION
        Sets the PSRyver config file path.

    .INPUTS
        System.IO.FileInfo

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Set-PSRyverConfigPath -Path '~/.psryver.xml'
        Sets the PSRyver config file path.

    .EXAMPLE
        '~/.psryver.xml' | Set-PSRyverConfigPath
        Sets the PSRyver config file path via the pipeline.

    .EXAMPLE
        Set-PSRyverConfigPath '~/.psryver.xml'
        Sets the PSRyver config file path via positional parameter.

    .LINK
        https://tlindsay42.github.io/PSRyver/Public/Set-PSRyverConfigPath/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Set-PSRyverConfigPath.ps1

    .LINK
        Get-PSRyverConfigPath

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Public/Set-PSRyverConfigPath/',
        SupportsShouldProcess = $true,
        ConfirmImpact = 'High'
    )]
    [OutputType( [System.IO.FileInfo] )]
    param (
        # Specifies the PSRyver config file path that will be used as the default.
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
        )]
        [ValidateScript( { Test-Path -Path $_ -IsValid } )]
        [System.IO.FileInfo]
        $Path
    )

    begin {
        $function = $MyInvocation.MyCommand.Name

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )
    }

    process {
        $proceed = $true
        if ( $Script:PSRyverConfigFilePath -and $Script:PSRyverConfigFilePath.FullName -ne $Path.FullName ) {
            $proceed = $PSCmdlet.ShouldProcess( '$Script:PSRyverConfigFilePath', 'Set the default PSRyver config file path for this session' )
        }

        if ( $proceed ) {
            if ( ( Test-Path -Path $Path ) -eq $true ) {
                $Script:PSRyverConfigFilePath = Get-Item -Path $Path -ErrorAction 'Stop'
            }
            else {
                $Script:PSRyverConfigFilePath = $Path
            }
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
