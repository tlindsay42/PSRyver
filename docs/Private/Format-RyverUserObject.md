# Format-RyverUserObject

## SYNOPSIS
Parse user objects.

## SYNTAX

```
Format-RyverUserObject [-InputObject] <PSObject[]> [<CommonParameters>]
```

## DESCRIPTION
Parse user objects.

## EXAMPLES

### EXAMPLE 1
```
Format-RyverUserObject -InputObject $objects
```

Parses user objects.

### EXAMPLE 2
```
$objects | Format-RyverUserObject
```

Parses user objects via the pipeline.

### EXAMPLE 3
```
Format-RyverChannelObject $objects
```

Parses user objects via positional parameter.

## PARAMETERS

### -InputObject
{{Fill InputObject Description}}

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

[https://tlindsay42.github.io/PSRyver/Private/Format-RyverUserObject/](https://tlindsay42.github.io/PSRyver/Private/Format-RyverUserObject/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Format-RyverUserObject.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Format-RyverUserObject.ps1)

