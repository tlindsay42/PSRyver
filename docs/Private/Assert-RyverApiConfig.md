# Assert-RyverApiConfig

## SYNOPSIS
Validates the PSRyver REST API configuration.

## SYNTAX

```
Assert-RyverApiConfig [<CommonParameters>]
```

## DESCRIPTION
Validates that the $Script:PSPRyver.RestApiBaseUri and
$Script:PSPRyver.Authorization values are set to valid
specifications, and throws terminating errors if not.

## EXAMPLES

### EXAMPLE 1
```
Assert-RyverApiConfig
```

Validates that the $Script:PSPRyver.RestApiBaseUri and
$Script:PSPRyver.Authorization values are set to valid
specifications, and throws terminating errors if not.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
###     You cannot pipe input to this cmdlet.
## OUTPUTS

### System.Void
## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Private/Assert-RyverApiConfig/](https://tlindsay42.github.io/PSRyver/Private/Assert-RyverApiConfig/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Assert-RyverApiConfig.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Assert-RyverApiConfig.ps1)

