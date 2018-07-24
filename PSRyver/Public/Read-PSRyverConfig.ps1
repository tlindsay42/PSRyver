function Read-PSRyverConfig {
    <#
    .SYNOPSIS
        Read a PSRyver module configuration file.

    .DESCRIPTION
        Read a PSRyver module configuration file and if the user has the correct key
        and run from a Windows system, decrypt the encrypted settings via the
        Data Protection API (DPAPI).

    .INPUTS
        System.IO.FileInfo

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Read-PSRyverConfig
        Reads the PSRyver module configuration stored in the file defined in
        '$Script:PSRyverConfigFilePath', which can be accessed via
        'Get-PSRyverConfigPath' and set via 'Set-PSRyverConfigPath'.  The encrypted
        values are decrypted if the user has the correct key and if run from a Windows
        system.

        The default location is '~/.psryver.xml'

    .EXAMPLE
        Read-PSRyverConfig -Path '~/.psryver.xml'
        Reads & decrypts the PSRyver module configuration stored in the specified path.

    .EXAMPLE
        '~/.psryver.xml' | Read-PSRyverConfig
        Reads & decrypts the PSRyver module configuration stored in the path specified
        via the pipeline.

    .EXAMPLE
        Read-PSRyverConfig '~/.psryver.xml'
        Reads & decrypts the PSRyver module configuration stored in the path specified
        via positional parameter.

    .LINK
        https://tlindsay42.github.io/PSRyver/Public/Read-PSRyverConfig/

    .LINK
        https://github.com/PSRyver/blob/master/PSRyver/Public/Read-PSRyverConfig.ps1

    .LINK
        Import-PSRyverConfig

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Public/Read-PSRyverConfig/'
    )]
    [OutputType( [Void] )]
    param (
        # Specifies the PSRyver config file.
        [Parameter(
            Position = 0,
            ValueFromPipeline = $true
        )]
        [ValidateScript( { Test-Path -Path $_ -PathType 'Leaf' } )]
        [System.IO.FileInfo]
        $Path = $Script:PSRyverConfigFilePath
    )

    begin {
        $function = $MyInvocation.MyCommand.Name

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )

        $isWindows = Test-IsWindows
        $messageTemplate = "Skipping reading the value of '{0}' to the config file because the Data Protection API (DPAPI) is not available for decrypting it on '$( $PSVersionTable.OS )'."

        function Unprotect-SecureString {
            param (
                [Parameter( Mandatory = $true )]
                [ValidateNotNullOrEmpty()]
                [System.Security.SecureString]
                $SecureString
            )

            [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
                [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR( $SecureString )
            )
        }
    }

    process {
        Import-Clixml -Path $Path -ErrorAction 'Stop' |
            Select-Object -Property @(
            @{
                Name       = 'RestApiBaseUri'
                Expression = {
                    if ( $isWindows -eq $true ) {
                        Unprotect-SecureString -SecureString $_.RestApiBaseUri
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
                        Unprotect-SecureString -SecureString $_.Authorization
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
                        Unprotect-SecureString -SecureString $_.IncomingWebhookUri
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
        )
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
