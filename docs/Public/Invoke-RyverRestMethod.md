# Invoke-RyverRestMethod

## SYNOPSIS
Send a message to the Ryver API endpoint.

## SYNTAX

```
Invoke-RyverRestMethod [-Path] <String> [[-Method] <String>] [[-Body] <String>] [[-Credential] <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
Send a message to the Ryver API endpoint.

This function is used by other PSRyver functions.
It's a simple wrapper you could use for calls to the Ryver API

## EXAMPLES

### EXAMPLE 1
```
Invoke-RyverRestMethod -Path '/forums' -Credential ( Get-Credential )
```

Updates the $Script:PSRyver.Authorization value storing the basic
authentication authorization header to use for all requests and then queries
for all public forum channels.

### EXAMPLE 2
```
[PSCustomObject] @{ Path = '/workrooms'; Method = 'Get' } | Invoke-RyverRestMethod
```

Queries for all private team channels via the pipeline by property name.

### EXAMPLE 3
```
Invoke-RyverRestMethod '/forums' 'Get'
```

Queries for all public forum channels via positional parameters.

## PARAMETERS

### -Body
Specifies the body of the request.

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

### -Credential
Credentials to use for the Ryver API.

Default value is the value set by Set-PSRyverConfig.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Method
Specifies the method used for the web request.

The acceptable values for this parameter were gathered from the response
header: 'Access-Control-Allow-Methods'.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Get
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
Specifies the Ryver API path to call.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSCustomObject
## OUTPUTS

### System.String
## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Public/Invoke-RyverRestMethod/](https://tlindsay42.github.io/PSRyver/Public/Invoke-RyverRestMethod/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Invoke-RyverRestMethod.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Invoke-RyverRestMethod.ps1)

