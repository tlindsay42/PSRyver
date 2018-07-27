# Format-RyverMessageObject

## SYNOPSIS
Parse message objects.

## SYNTAX

```
Format-RyverMessageObject [-InputObject] <PSObject[]> [<CommonParameters>]
```

## DESCRIPTION
Parse message objects.

## EXAMPLES

### EXAMPLE 1
```
Format-RyverMessageObject -InputObject $objects
```

Parses the message objects.

### EXAMPLE 2
```
$objects | Format-RyverMessageObject
```

Parses the message objects via the pipeline.

### EXAMPLE 3
```
Format-RyverMessageObject $objects
```

Parses the message objects via positional parameter.

## PARAMETERS

### -InputObject
The public forum or private team channel objects to parse.

```yaml
Type: PSObject[]
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

### System.Management.Automation.PSCustomObject[]

### System.Management.Automation.PSCustomObject

## OUTPUTS

### System.Management.Automation.PSObject[]

### System.Management.Automation.PSObject

## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Private/Format-RyverMessageObject/](https://tlindsay42.github.io/PSRyver/Private/Format-RyverMessageObject/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Format-RyverMessageObject.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Format-RyverMessageObject.ps1)

