# Remove-SensitiveData

## SYNOPSIS
Redact sensitive property values.

## SYNTAX

```
Remove-SensitiveData [-InputObject] <Object[]> [[-SensitiveProperties] <String[]>] [-ForceVerbose]
 [<CommonParameters>]
```

## DESCRIPTION
Redact sensitive property values prior to printing to the console.

## EXAMPLES

### EXAMPLE 1
```
Remove-SensitiveData -InputObject [PSCustomObject] @{ IncomingWebhookUri = $incomingWebhookUri }
```

Returns the input object with the value of the IncomingWebhookUri key set to
'\[REDACTED\]', unless the $Script:PSRyver.ForceVerbose PSRyver module
configuration parameter is set to $true, in which case the value would not be
masked.

### EXAMPLE 2
```
[PSCustomObject] @{ PlainText = 'do not display' } | Remove-SensitiveData -SensitiveProperties 'PlainText'
```

Returns the object input via the pipeline with the value of the 'PlainText' key
set to '\[REDACTED\]', because the SensitiveProperties parameter specified this
key as sensitive.

### EXAMPLE 3
```
Remove-SensitiveData -InputObject [PSCustomObject] @{ Authorization = $authorization } -ForceVerbose
```

Returns the input object with the value of the Authorization key intact
regardless of whether or not the $Script:PSRyver.ForceVerbose PSRyver module
configuration parameter is set to $true, because the ForceVerbose parameter
mandated this.

### EXAMPLE 4
```
Remove-SensitiveData [PSCustomObject] @{ Authorization = $authorization }
```

Uses a positional parameter Returns the hashtable with the Uri value set to '\[REDACTED\]'.

## PARAMETERS

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
Position: 3
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the objects to evaluate for sensitive property keys.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -SensitiveProperties
Specifies the properties that should be redacted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: @(
            'Credential',
            'Authorization',
            'IncomingWebhookUri',
            'Token'
        )
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object[]
### System.Object
## OUTPUTS

### System.Object[]
### System.Object
## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Private/Remove-SensitiveData/](https://tlindsay42.github.io/PSRyver/Private/Remove-SensitiveData/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Remove-SensitiveData.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Remove-SensitiveData.ps1)

