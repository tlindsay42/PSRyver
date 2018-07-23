# Format-RyverV1ChannelObject

## SYNOPSIS
Parse forum & team channel objects.

## SYNTAX

```
Format-RyverV1ChannelObject [-InputObject] <PSObject[]> [<CommonParameters>]
```

## DESCRIPTION
Parse public forum & private team channel objects.

## EXAMPLES

### EXAMPLE 1
```
Format-RyverV1ChannelObject -InputObject $objects
```

Parses the forum or team channel objects.

### EXAMPLE 2
```
$objects | Format-RyverV1ChannelObject
```

Parses the forum or team channel objects via the pipeline.

### EXAMPLE 3
```
Format-RyverV1ChannelObject $objects
```

Parses the forum or team channel objects via positional parameter.

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

[https://tlindsay42.github.io/PSRyver/Private/Format-RyverV1ChannelObject/](https://tlindsay42.github.io/PSRyver/Private/Format-RyverV1ChannelObject/)

[https://github.com/PSRyver/blob/master/PSRyver/Private/Format-RyverV1ChannelObject.ps1](https://github.com/PSRyver/blob/master/PSRyver/Private/Format-RyverV1ChannelObject.ps1)

