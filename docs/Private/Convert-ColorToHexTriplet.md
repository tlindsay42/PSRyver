# Convert-ColorToHexTriplet

## SYNOPSIS
Converts a color object to a RGB hex triplet.

## SYNTAX

```
Convert-ColorToHexTriplet [-Color] <Color> [<CommonParameters>]
```

## DESCRIPTION
Converts a System.Drawing.Color object to a hexadecimal code representing that
color.

## EXAMPLES

### EXAMPLE 1
```
Convert-ColorToHexTriplet -Color ( [System.Drawing.Color]::Red )
```

Returns '#FF0000'.

### EXAMPLE 2
```
[System.Drawing.Color]::Azure | Convert-ColorToHexTriplet
```

Specifies the color to convert via the pipeline and returns '#F0FFFF'.

### EXAMPLE 3
```
Convert-ColorToHexTriplet ( [System.Drawing.Color]::BlancheDalmond )
```

Specifies the color to convert via positional parameter and returns '#FFEBCD'.

## PARAMETERS

### -Color
Specifies the color to convert.

```yaml
Type: Color
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

### System.Drawing.Color
## OUTPUTS

### System.String
## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Private/Convert-ColorToHexTriplet/](https://tlindsay42.github.io/PSRyver/Private/Convert-ColorToHexTriplet/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Convert-ColorToHexTriplet.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Convert-ColorToHexTriplet.ps1)

[https://en.wikipedia.org/wiki/Web_colors#Hex_triplet](https://en.wikipedia.org/wiki/Web_colors#Hex_triplet)

