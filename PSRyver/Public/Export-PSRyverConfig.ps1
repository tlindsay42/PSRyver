function Export-PSRyverConfig {
    <#
    .SYNOPSIS
        Save the PSRyver module configuration to file.

    .DESCRIPTION
        Save the PSRyver module configuration to file.

    .INPUTS
        System.IO.FileInfo

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Export-PSRyverConfig
        Saves the PSRyver module configuration stored in $Script:PSRyver to the default
        file path stored in $Script:PSRyverConfigFilePath, which can be accessed via
        Get-PSRyverConfigPath and set via Set-PSRyverConfigPath.  The default location
        is '~/.psryver.xml'

    .EXAMPLE
        Export-PSRyverConfig -Path '~/.psryver.xml'
        Saves the PSRyver module configuration stored in $Script:PSRyver to the
        specified path of '~/.psryver.xml'.

    .EXAMPLE
        '~/.psryver.xml' | Export-PSRyverConfig
        Saves the PSRyver module configuration stored in $Script:PSRyver to the
        specified path of '~/.psryver.xml', which is set via the pipeline.

    .EXAMPLE
        Export-PSRyverConfig '~/.psryver.xml'
        Saves the PSRyver module configuration stored in $Script:PSRyver to the
        specified path of '~/.psryver.xml' via positional parameter.

    .LINK
        https://tlindsay42.github.io/PSRyver/Public/Export-PSRyverConfig/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Export-PSRyverConfig.ps1

    .LINK
        Import-PSRyverConfig

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
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Public/Export-PSRyverConfig/',
        SupportsShouldProcess = $true,
        ConfirmImpact = 'High'
    )]
    [OutputType( [Void] )]
    param (
        # Specifies the PSRyver config file to export.
        [Parameter(
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateScript( { Test-Path -Path $_ -IsValid } )]
        [System.IO.FileInfo]
        $Path = $Script:PSRyverConfigFilePath
    )

    begin {
        $function = $MyInvocation.MyCommand.Name
        Write-Verbose -Message "Beginning: '${function}'."

        $isWindows = Test-IsWindows
        $messageTemplate = "Skipping writing the value of '{0}' to the config file because the Data Protection API (DPAPI) is not available for encrypting it on '$( $PSVersionTable.OS )'."
    }

    process {
        Write-Verbose -Message (
            "Processing: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )

        $proceed = $true
        if ( ( Test-Path -Path $Path ) -eq $true ) {
            $proceed = $PSCmdlet.ShouldProcess( $Path, 'Overwrite the existing PSRyver config file' )
        }

        if ( $proceed ) {
            $Script:PSRyver |
                Select-Object -Property @(
                @{
                    Name       = 'RestApiBaseUri'
                    Expression = {
                        if ( $isWindows -eq $true ) {
                            ConvertTo-SecureString -String $_.RestApiBaseUri -AsPlainText -Force -ErrorAction 'Stop'
                        }
                        else {
                            Write-Verbose -Message ( $messageTemplate -f 'RestApiBaseUri' )
                        }
                    }
                },
                @{
                    Name       = 'Authorization'
                    Expression = {
                        if ( $isWindows -eq $true ) {
                            ConvertTo-SecureString -String $_.Authorization -AsPlainText -Force -ErrorAction 'Stop'
                        }
                        else {
                            Write-Verbose -Message ( $messageTemplate -f 'Authorization' )
                        }
                    }
                },
                @{
                    Name       = 'IncomingWebhookUri'
                    Expression = {
                        if ( $isWindows -eq $true ) {
                            ConvertTo-SecureString -String $_.IncomingWebhookUri -AsPlainText -Force -ErrorAction 'Stop'
                        }
                        else {
                            Write-Verbose -Message ( $messageTemplate -f 'IncomingWebhookUri' )
                        }
                    }
                },
                'Proxy',
                'MapUser',
                'ForceVerbose',
                'MaxPageSize'
            ) |
                Export-Clixml -Path $Path -Force -ErrorAction 'Stop'
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
