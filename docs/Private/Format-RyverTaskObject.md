# Format-RyverTaskObject

## SYNOPSIS
Parse task objects.

## SYNTAX

```
Format-RyverTaskObject [-InputObject] <PSObject[]> [<CommonParameters>]
```

## DESCRIPTION
Parse task objects.

## EXAMPLES

### EXAMPLE 1
```
Format-RyverTaskObject -InputObject $objects
```

Parses the task objects.

### EXAMPLE 2
```
$objects | Format-RyverTaskObject
```

Parses the task objects via the pipeline.

### EXAMPLE 3
```
Format-RyverTaskObject $objects
```

Parses the task objects via positional parameter.

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

[https://tlindsay42.github.io/PSRyver/Private/Format-RyverTaskObject/](https://tlindsay42.github.io/PSRyver/Private/Format-RyverTaskObject/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Format-RyverTaskObject.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Format-RyverTaskObject.ps1)

