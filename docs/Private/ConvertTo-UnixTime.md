# ConvertTo-UnixTime

## SYNOPSIS
Convert datetime objects to UNIX time.

## SYNTAX

```
ConvertTo-UnixTime [-Date] <DateTime> [<CommonParameters>]
```

## DESCRIPTION
Convert System.DateTime objects to UNIX time.

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-UnixTime -Date ( Get-Date -Date '2018-07-21 10:33:18' )
```

Returns '1532187198'.

### EXAMPLE 2
```
( Get-Date -Date '2018-07-21 10:33:18' ) | ConvertTo-UnixTime
```

Processes the pipeline value and returns '1532187198'.

### EXAMPLE 3
```
ConvertTo-UnixTime ( Get-Date -Date '2018-07-21 10:33:18' )
```

Uses positional parameter and returns '1532187198'.

## PARAMETERS

### -Date
The System.DateTime formatted date & time.

```yaml
Type: DateTime
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

### System.DateTime

## OUTPUTS

### System.Int32

## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Private/ConvertTo-UnixTime/](https://tlindsay42.github.io/PSRyver/Private/ConvertTo-UnixTime/)

[https://github.com/PSRyver/blob/master/PSRyver/Private/ConvertTo-UnixTime.ps1](https://github.com/PSRyver/blob/master/PSRyver/Private/ConvertTo-UnixTime.ps1)

