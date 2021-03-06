function Import-PSRyverConfig {
    <#
    .SYNOPSIS
        Import a PSRyver module configuration from file.

    .DESCRIPTION
        Import a PSRyver module configuration from file and set the $Script:PSRyver
        module configuration variable.

    .INPUTS
        System.IO.FileInfo

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Import-PSRyverConfig
        Loads the PSRyver module configuration to $Script:PSRyver from the default file
        path stored in $Script:PSRyverConfigFilePath. which can be accessed via
        Get-PSRyverConfigPath and set via Set-PSRyverConfigPath.

        The default location is '~/.psryver.xml'

    .EXAMPLE
        Import-PSRyverConfig -Path '~/.psryver.xml'
        Loads the PSRyver module configuration from '~/.psryver.xml' to
        $Script:PSRyver.

    .EXAMPLE
        '~/.psryver.xml' | Export-PSRyverConfig
        Loads the PSRyver module configuration from '~/.psryver.xml', specified via the
        pipeline, to $Script:PSRyver.

    .EXAMPLE
        Import-PSRyverConfig '~/.psryver.xml'
        Loads the PSRyver module configuration from '~/.psryver.xml', specified via
        positional parameter, to $Script:PSRyver.

    .LINK
        https://tlindsay42.github.io/PSRyver/Public/Import-PSRyverConfig/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Import-PSRyverConfig.ps1

    .LINK
        Export-PSRyverConfig

    .LINK
        Read-PSRyverConfig

    .LINK
        Get-PSRyverConfig

    .LINK
        Set-PSRyverConfig

    .LINK
        Get-PSRyverConfigPath

    .LINK
        Set-PSRyverConfigPath

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Public/Import-PSRyverConfig/',
        SupportsShouldProcess = $true,
        ConfirmImpact = 'High'
    )]
    [OutputType( [Void] )]
    param (
        # Specifies the PSRyver config file to import.
        [Parameter(
            Position = 0,
            ValueFromPipeline = $true
        )]
        [ValidateScript( { Test-Path -Path $_ } )]
        [System.IO.FileInfo]
        $Path = $Script:PSRyverConfigFilePath
    )

    begin {
        $function = $MyInvocation.MyCommand.Name
        Write-Verbose -Message "Beginning: '${function}'."
    }

    process {
        Write-Verbose -Message (
            "Processing: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )

        $proceed = $true
        if ( $Script:PSRyver ) {
            $proceed = $PSCmdlet.ShouldProcess( '$Script:PSRyver', 'Overwrite the existing PSRyver config' )
        }

        if ( $proceed ) {
            $Script:PSRyver = Read-PSRyverConfig -Path $Path -ErrorAction 'Stop'
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
