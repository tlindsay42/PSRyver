function Set-PSRyverConfig {
    <#
    .SYNOPSIS
        Sets parameters in the PSRyver module configuration.

    .DESCRIPTION
        Sets parameters in the PSRyver module configuration, which are stored in the
        $Script:PSRyver variable.

    .INPUTS
        System.Management.Automation.PSCustomObject

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Set-PSRyverConfig https://example.ryver.com/api/1/odata.svc ( Get-Credential )
        Uses positional parameters to set the $Script:PSRyver.RestApiBaseUri value
        storing the default REST API URI and the $Script:PSRyver.Authorization value
        storing the basic authentication authorization header to use for all requests.

        The values of all other settings are left intact.

    .EXAMPLE
        Set-PSRyverConfig -IncomingWebhookUri https://example.ryver.com/application/webhook/4z-_G76nj7Fic-M
        Sets the $Script:PSRyver.IncomingWebhookUri value storing the default
        incoming webhook URI to use for all requests.

        The values of all other settings are left intact.

    .EXAMPLE
        [PSCustomObject] @{ Proxy = 'https://192.168.1.1/'; MapUser = $true; ForceVerbose = $true } | Set-PSRyverConfig
        Configures the default proxy, enables user mapping, and prevents sensitive
        values from being redacted.

        The values of all other settings are left intact.

    .LINK
        https://tlindsay42.github.io/PSRyver/Public/Set-PSRyverConfig/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Set-PSRyverConfig.ps1

    .LINK
        Get-PSRyverConfig

    .LINK
        Export-PSRyverConfig

    .LINK
        Remove-PSRyverConfig

    .LINK
        Initialize-PSRyverConfig

    .LINK
        Import-PSRyverConfig

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Public/Set-PSRyverConfig/',
        SupportsShouldProcess = $true,
        ConfirmImpact = 'High'
    )]
    [OutputType( [Void] )]
    param (
        # Specifies the REST API URI.  Only serialized to disk on Windows via DPAPI.
        [Parameter(
            Position = 0,
            ValueFromPipelineByPropertyName = $true
        )]
        [AllowEmptyString()]
        [ValidatePattern( '^(?:|https://\w+.ryver.com(?::443)?/api/1/odata.svc)$' )]
        [String]
        $RestApiBaseUri,

        <#
        Specify the Credentials to use for basic authentication.

        Only serialized to disk as the base64 encoded authorization header value on
        Windows via DPAPI.
        #>
        [Parameter(
            Position = 1,
            ValueFromPipelineByPropertyName = $true
        )]
        [AllowNull()]
        [PSCredential]
        $Credential,

        # Specifies the incoming webhook URI.  Only serialized to disk on Windows via DPAPI.
        [Parameter(
            Position = 2,
            ValueFromPipelineByPropertyName = $true
        )]
        [AllowEmptyString()]
        [ValidatePattern( '^(?:|https://\w+.ryver.com(?::443)?/application/webhook/\S+)$' )]
        [String]
        $IncomingWebhookUri,

        # Proxy to use.
        [Parameter(
            Position = 3,
            ValueFromPipelineByPropertyName = $true
        )]
        [AllowEmptyString()]
        [ValidatePattern( '^(?:$|https?://\S+)' )]
        [String]
        $Proxy,

        <#
        Whether to generate a map of Ryver user ID to name on module load, for use in
        Ryver File commands
        #>
        [Parameter(
            Position = 4,
            ValueFromPipelineByPropertyName = $true
        )]
        [Switch]
        $MapUser,

        <#
        If set to true, we allow verbose output that may include sensitive data

        *** WARNING ***
        If you set this to true, your Ryver token will be visible as plain text in
        verbose output.
        #>
        [Parameter(
            Position = 5,
            ValueFromPipelineByPropertyName = $true
        )]
        [Switch]
        $ForceVerbose,

        # Maximum number of results per query.
        [Parameter(
            Position = 6,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateRange( 25, 50 )]
        [UInt16]
        $MaxPageSize = 25
    )

    begin {
        $function = $MyInvocation.MyCommand.Name
        $proceed = $true
        $prompt = 'Overwrite the existing PSRyver config'

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData -ForceVerbose:$ForceVerbose | Format-Table -Autosize | Out-String )
        )
    }

    process {
        if ( -not $Script:PSRyver ) {
            $splat = @{
                Message     = (
                    "Module configuration variable, '`$Script:PSRyver' not found.  " +
                    "Please run either 'Import-PSRyverConfig' or 'Initialize-PSRyverConfig' to recreate it and then try again."
                )
                ErrorAction = 'Stop'
            }
            Write-Error @splat
        }

        switch ( $PSBoundParameters.Keys ) {
            'Credential' {
                if ( $null -eq $Credential ) {
                    [String] $Script:PSRyver.Authorization = ''
                }
                else {
                    $proceed = $true
                    if ( $Script:PSRyver.Authorization -match '^Basic \S+$' ) {
                        $proceed = $PSCmdlet.ShouldProcess( '$Script:PSRyver.Authorization', $prompt )
                    }

                    if ( $proceed ) {
                        [String] $Script:PSRyver.Authorization = ConvertTo-Authorization -Credential $Credential -ErrorAction 'Stop'
                    }
                    $Credential = $null
                }
                Remove-Variable -Name 'Credential' -Force
            }

            'ForceVerbose' {
                $proceed = $true
                if ( $Script:PSRyver.ForceVerbose -ne $ForceVerbose ) {
                    $proceed = $PSCmdlet.ShouldProcess( '$Script:PSRyver.ForceVerbose', $prompt )
                }

                if ( $proceed ) {
                    [Boolean] $Script:PSRyver.ForceVerbose = $ForceVerbose
                }
            }

            'IncomingWebhookUri' {
                $proceed = $true
                if ( $Script:PSRyver.IncomingWebhookUri ) {
                    $proceed = $PSCmdlet.ShouldProcess( '$Script:PSRyver.IncomingWebhookUri', $prompt )
                }

                if ( $proceed ) {
                    [Uri] $Script:PSRyver.IncomingWebhookUri = $IncomingWebhookUri
                }
            }

            'MapUser' {
                $proceed = $true
                if ( $Script:PSRyver.MapUser -ne $MapUser ) {
                    $proceed = $PSCmdlet.ShouldProcess( '$Script:PSRyver.MapUser', $prompt )
                }

                if ( $proceed ) {
                    [Boolean] $Script:PSRyver.MapUser = $MapUser
                }
            }

            'MaxPageSize' {
                $proceed = $true
                if ( $Script:PSRyver.MaxPageSize -ne $MaxPageSize ) {
                    $proceed = $PSCmdlet.ShouldProcess( '$Script:PSRyver.MaxPageSize', $prompt )
                }

                if ( $proceed ) {
                    [UInt16] $Script:PSRyver.MaxPageSize = $MaxPageSize
                }
            }

            'Proxy' {
                $proceed = $true
                if ( $Script:PSRyver.Proxy ) {
                    $proceed = $PSCmdlet.ShouldProcess( '$Script:PSRyver.Proxy', $prompt )
                }

                if ( $proceed ) {
                    [Uri] $Script:PSRyver.Proxy = $Proxy
                }
            }

            'RestApiBaseUri' {
                $proceed = $true
                if ( $Script:PSRyver.RestApiBaseUri ) {
                    $proceed = $PSCmdlet.ShouldProcess( '$Script:PSRyver.RestApiBaseUri', $prompt )
                }

                if ( $proceed ) {
                    [Uri] $Script:PSRyver.RestApiBaseUri = $RestApiBaseUri
                }
            }
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
