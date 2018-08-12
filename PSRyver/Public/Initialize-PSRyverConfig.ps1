function Initialize-PSRyverConfig {
    <#
    .SYNOPSIS
        Initialize the PSRyver module configuration parameters.

    .DESCRIPTION
        Initialize the PSRyver module configuration parameters stored in the
        $Script:PSRyver variable.

    .INPUTS
        System.Management.Automation.PSCustomObject

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Initialize-PSRyverConfig
        Initializes the $Script:PSRyver variable with all module configuration settings
        set to their default values.

    .EXAMPLE
        Initialize-PSRyverConfig https://example.ryver.com/api/1/odata.svc ( Get-Credential )
        Uses positional parameters to set the $Script:PSRyver.RestApiBaseUri value
        storing the default REST API URI and the $Script:PSRyver.Authorization value
        storing the basic authentication authorization header to use for all requests.

        The values of all other settings initialized with their default values.

    .EXAMPLE
        Initialize-PSRyverConfig -IncomingWebhookUri https://example.ryver.com/application/webhook/4z-_G76nj7Fic-M
        Sets the $Script:PSRyver.IncomingWebhookUri value storing the default
        incoming webhook URI to use for all requests.

        The values of all other settings initialized with their default values.

    .EXAMPLE
        [PSCustomObject] @{ Proxy = 'https://192.168.1.1/'; MapUser = $true; ForceVerbose = $true } | Initialize-PSRyverConfig
        Configures the default proxy, enables user mapping, and prevents sensitive
        values from being redacted.

        The values of all other settings initialized with their default values.

    .LINK
        https://tlindsay42.github.io/PSRyver/Public/Initialize-PSRyverConfig/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Initialize-PSRyverConfig.ps1

    .LINK
        Get-PSRyverConfig

    .LINK
        Set-PSRyverConfig

    .LINK
        Remove-PSRyverConfig

    .LINK
        Export-PSRyverConfig

    .LINK
        Import-PSRyverConfig

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Public/Initialize-PSRyverConfig/',
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

        # Proxy to use with Invoke-RestMethod
        [Parameter(
            Position = 3,
            ValueFromPipelineByPropertyName = $true
        )]
        [AllowEmptyString()]
        [ValidatePattern( '^(?:$|https?://\S+)' )]
        [String]
        $Proxy,

        <#
        Specifies whether to generate a map of Ryver user ID to name on module load,
        for use in Ryver File commands.
        #>
        [Parameter(
            Position = 4,
            ValueFromPipelineByPropertyName = $true
        )]
        [Switch]
        $MapUser = $false,

        <#
        Prevents sensitive property values from being redacted for troubleshooting
        purposes.

        *** WARNING ***
        This will expose your sensitive property values.
        #>
        [Parameter(
            Position = 5,
            ValueFromPipelineByPropertyName = $true
        )]
        [Switch]
        $ForceVerbose = $false,

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
            $Script:PSRyver = [PSCustomObject] @{
                PSTypeName         = 'PSRyver.Config'
                RestApiBaseUri     = [Uri] $RestApiBaseUri
                Authorization      = [String] $null
                IncomingWebhookUri = [Uri] $IncomingWebhookUri
                Proxy              = [Uri] $Proxy
                MapUser            = [Boolean] $MapUser
                ForceVerbose       = [Boolean] $ForceVerbose
                MaxPageSize        = [UInt16] $MaxPageSize
            }

            if ( $PSBoundParameters.ContainsKey( 'Credential' ) ) {
                [String] $Script:PSRyver.Authorization = ConvertTo-Authorization -Credential $Credential -ErrorAction 'Stop'
                $Credential = $null
                Remove-Variable -Name 'Credential' -Force
            }
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
