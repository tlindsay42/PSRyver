# Set-PSRyverConfig

## SYNOPSIS
Sets parameters in the PSRyver module configuration.

## SYNTAX

```
Set-PSRyverConfig [[-RestApiBaseUri] <String>] [[-Credential] <PSCredential>] [[-IncomingWebhookUri] <String>]
 [[-Proxy] <String>] [-MapUser] [-ForceVerbose] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets parameters in the PSRyver module configuration, which are stored in the
$Script:PSRyver variable.

## EXAMPLES

### EXAMPLE 1
```
Set-PSRyverConfig https://example.ryver.com/api/1/odata.svc ( Get-Credential )
```

Uses positional parameters to set the $Script:PSRyver.RestApiBaseUri value
storing the default REST API URI and the $Script:PSRyver.Authorization value
storing the basic authentication authorization header to use for all requests.

The values of all other settings are left intact.

### EXAMPLE 2
```
Set-PSRyverConfig -IncomingWebhookUri https://example.ryver.com/application/webhook/4z-_G76nj7Fic-M
```

Sets the $Script:PSRyver.IncomingWebhookUri value storing the default
incoming webhook URI to use for all requests.

The values of all other settings are left intact.

### EXAMPLE 3
```
[PSCustomObject] @{ Proxy = 'https://192.168.1.1/'; MapUser = $true; ForceVerbose = $true } | Set-PSRyverConfig
```

Configures the default proxy, enables user mapping, and prevents sensitive
values from being redacted.

The values of all other settings are left intact.

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
If set to true, we allow verbose output that may include sensitive data

*** WARNING ***
If you set this to true, your Ryver token will be visible as plain text in
verbose output.

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
Whether to generate a map of Ryver user ID to name on module load, for use in
Ryver File commands

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

### -Proxy
Proxy to use.

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

[https://tlindsay42.github.io/PSRyver/Public/Set-PSRyverConfig/](https://tlindsay42.github.io/PSRyver/Public/Set-PSRyverConfig/)

[https://github.com/PSRyver/blob/master/PSRyver/Public/Set-PSRyverConfig.ps1](https://github.com/PSRyver/blob/master/PSRyver/Public/Set-PSRyverConfig.ps1)

[Get-PSRyverConfig]()

[Export-PSRyverConfig]()

[Remove-PSRyverConfig]()

[Initialize-PSRyverConfig]()

