# Initialize-PSRyverConfig

## SYNOPSIS
Initialize the PSRyver module configuration parameters.

## SYNTAX

```
Initialize-PSRyverConfig [[-RestApiBaseUri] <String>] [[-Credential] <PSCredential>]
 [[-IncomingWebhookUri] <String>] [[-Proxy] <String>] [-MapUser] [-ForceVerbose] [[-MaxPageSize] <UInt16>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Initialize the PSRyver module configuration parameters stored in the
$Script:PSRyver variable.

## EXAMPLES

### EXAMPLE 1
```
Initialize-PSRyverConfig
```

Initializes the $Script:PSRyver variable with all module configuration settings
set to their default values.

### EXAMPLE 2
```
Initialize-PSRyverConfig https://example.ryver.com/api/1/odata.svc ( Get-Credential )
```

Uses positional parameters to set the $Script:PSRyver.RestApiBaseUri value
storing the default REST API URI and the $Script:PSRyver.Authorization value
storing the basic authentication authorization header to use for all requests.

The values of all other settings initialized with their default values.

### EXAMPLE 3
```
Initialize-PSRyverConfig -IncomingWebhookUri https://example.ryver.com/application/webhook/4z-_G76nj7Fic-M
```

Sets the $Script:PSRyver.IncomingWebhookUri value storing the default
incoming webhook URI to use for all requests.

The values of all other settings initialized with their default values.

### EXAMPLE 4
```
[PSCustomObject] @{ Proxy = 'https://192.168.1.1/'; MapUser = $true; ForceVerbose = $true } | Initialize-PSRyverConfig
```

Configures the default proxy, enables user mapping, and prevents sensitive
values from being redacted.

The values of all other settings initialized with their default values.

## PARAMETERS

### -Credential
Specify the Credentials to use for basic authentication.

Only serialized to disk as the base64 encoded authorization header value on
Windows via DPAPI.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ForceVerbose
Prevents sensitive property values from being redacted for troubleshooting
purposes.

*** WARNING ***
This will expose your sensitive property values.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncomingWebhookUri
Specifies the incoming webhook URI. 
Only serialized to disk on Windows via DPAPI.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MapUser
Specifies whether to generate a map of Ryver user ID to name on module load,
for use in Ryver File commands.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MaxPageSize
Maximum number of results per query.

```yaml
Type: UInt16
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 25
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Proxy
Proxy to use with Invoke-RestMethod

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RestApiBaseUri
Specifies the REST API URI. 
Only serialized to disk on Windows via DPAPI.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSCustomObject
## OUTPUTS

### System.Void
## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Public/Initialize-PSRyverConfig/](https://tlindsay42.github.io/PSRyver/Public/Initialize-PSRyverConfig/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Initialize-PSRyverConfig.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Initialize-PSRyverConfig.ps1)

[Get-PSRyverConfig]()

[Set-PSRyverConfig]()

[Remove-PSRyverConfig]()

[Export-PSRyverConfig]()

[Import-PSRyverConfig]()

