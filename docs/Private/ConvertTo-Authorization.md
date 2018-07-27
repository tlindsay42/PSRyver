# ConvertTo-Authorization

## SYNOPSIS
Convert credential objects to basic authorization headers.

## SYNTAX

```
ConvertTo-Authorization [-Credential] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
Convert credential objects to basic authorization headers.

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-Authorization -Credential ( Get-Credential )
```

Converts the credential to a base64 encoded basic authentication authorization
header value.

### EXAMPLE 2
```
( Get-Credential ) | ConvertTo-Authorization
```

Converts the credential set via the pipeline to a base64 encoded basic
authentication authorization header value.

### EXAMPLE 3
```
ConvertTo-Authorization ( Get-Credential )
```

Converts the credential set via positional parameter to a base64 encoded basic
authentication authorization header value.

## PARAMETERS

### -Credential
Specifies the credential to convert to a base64 encoded basic authentication
authorization header value.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSCredential

## OUTPUTS

### System.String

## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Private/ConvertTo-Authorization/](https://tlindsay42.github.io/PSRyver/Private/ConvertTo-Authorization/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/ConvertTo-Authorization.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/ConvertTo-Authorization.ps1)

