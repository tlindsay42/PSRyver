# ConvertFrom-UnixTime

## SYNOPSIS
Convert UNIX time to datetime objects.

## SYNTAX

```
ConvertFrom-UnixTime [-UnixTime] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Convert UNIX time to datetime objects.

## EXAMPLES

### EXAMPLE 1
```
ConvertFrom-UnixTime -UnixTime 1532186850
```

Returns 'Saturday, July 21, 2018 15:27:30'.

### EXAMPLE 2
```
1532186850 | ConvertFrom-UnixTime
```

Processes the pipeline value and returns
'Saturday, July 21, 2018 15:27:30'.

### EXAMPLE 3
```
ConvertFrom-UnixTime 1532186850
```

Uses positional parameter and returns
'Saturday, July 21, 2018 15:27:30'.

## PARAMETERS

### -UnixTime
The UNIX formatted date & time.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Int32

## OUTPUTS

### System.DateTime

## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Private/ConvertFrom-UnixTime/](https://tlindsay42.github.io/PSRyver/Private/ConvertFrom-UnixTime/)

[https://github.com/PSRyver/blob/master/PSRyver/Private/ConvertFrom-UnixTime.ps1](https://github.com/PSRyver/blob/master/PSRyver/Private/ConvertFrom-UnixTime.ps1)

[http://powershell.com/cs/blogs/tips/archive/2012/03/09/converting-unix-time.aspx](http://powershell.com/cs/blogs/tips/archive/2012/03/09/converting-unix-time.aspx)

