function Remove-SensitiveData {
    <#
    .SYNOPSIS
        Redact sensitive property values.

    .DESCRIPTION
        Redact sensitive property values prior to printing to the console.

    .INPUTS
        System.Object[]

    .INPUTS
        System.Object

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Remove-SensitiveData -InputObject [PSCustomObject] @{ IncomingWebhookUri = $incomingWebhookUri }
        Returns the input object with the value of the IncomingWebhookUri key set to
        '[REDACTED]', unless the $Script:PSRyver.ForceVerbose PSRyver module
        configuration parameter is set to $true, in which case the value would not be
        masked.

    .EXAMPLE
        [PSCustomObject] @{ PlainText = 'do not display' } | Remove-SensitiveData -SensitiveProperties 'PlainText'
        Returns the object input via the pipeline with the value of the 'PlainText' key
        set to '[REDACTED]', because the SensitiveProperties parameter specified this
        key as sensitive.

    .EXAMPLE
        Remove-SensitiveData -InputObject [PSCustomObject] @{ Authorization = $authorization } -ForceVerbose
        Returns the input object with the value of the Authorization key intact
        regardless of whether or not the $Script:PSRyver.ForceVerbose PSRyver module
        configuration parameter is set to $true, because the ForceVerbose parameter
        mandated this.

    .EXAMPLE
        Remove-SensitiveData [PSCustomObject] @{ Authorization = $authorization }
        Uses a positional parameter Returns the hashtable with the Uri value set to '[REDACTED]'.

    .LINK
        https://tlindsay42.github.io/PSRyver/Private/Remove-SensitiveData/

    .LINK
        https://github.com/PSRyver/blob/master/PSRyver/Private/Remove-SensitiveData.ps1

    .FUNCTIONALITY
        PowerShell Language
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Private/Remove-SensitiveData/'
    )]
    [OutputType( [Object[]] )]
    [OutputType( [Object] )]
    param (
        # Specifies the objects to evaluate for sensitive property keys.
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
        )]
        [ValidateNotNull()]
        [Object[]]
        $InputObject,

        # Specifies the properties that should be redacted.
        [Parameter( Position = 1 )]
        [ValidateNotNullOrEmpty()]
        [String[]]
        $SensitiveProperties = @(
            'Credential',
            'Authorization',
            'IncomingWebhookUri',
            'Token'
        ),

        <#
        Prevents sensitive property values from being redacted for troubleshooting
        purposes.

        *** WARNING ***
        This will expose your sensitive property values.
        #>
        [Parameter( Position = 2 )]
        [Switch]
        $ForceVerbose = $false
    )

    begin {
        $function = $MyInvocation.MyCommand.Name

        if ( $PSBoundParameters.ContainsKey( 'ForceVerbose' ) -eq $false -and $Script:PSRyver.ForceVerbose -in $true, $false ) {
            $ForceVerbose = $Script:PSRyver.ForceVerbose
        }

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Format-Table -AutoSize | Out-String )
        )
    }

    process {
        if ( $ForceVerbose -eq $true ) {
            $InputObject
        }
        else {
            if (
                $InputObject -is [Hashtable] -or
                ( $InputObject.Keys.Count -gt 0 -and $InputObject.Values.Count -gt 0 )
            ) {
                $return = [Hashtable] $( $InputObject.PSObject.Copy() )
                foreach ( $sensitiveProperty in $SensitiveProperties ) {
                    if ( $InputObject.ContainsKey( $sensitiveProperty ) ) {
                        $return[$sensitiveProperty] = '[REDACTED]'
                    }
                }
                $return
            }
            else {
                $InputObject |
                    Select-Object -Property '*' -ExcludeProperty $SensitiveProperties
            }
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
