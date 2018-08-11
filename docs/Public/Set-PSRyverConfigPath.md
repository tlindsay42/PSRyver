# Set-PSRyverConfigPath

## SYNOPSIS
Sets the PSRyver config file path.

## SYNTAX

```
Set-PSRyverConfigPath [-Path] <FileInfo> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the PSRyver config file path.

## EXAMPLES

### EXAMPLE 1
```
Set-PSRyverConfigPath -Path '~/.psryver.xml'
```

Sets the PSRyver config file path.

### EXAMPLE 2
```
'~/.psryver.xml' | Set-PSRyverConfigPath
```

Sets the PSRyver config file path via the pipeline.

### EXAMPLE 3
```
Set-PSRyverConfigPath '~/.psryver.xml'
```

Sets the PSRyver config file path via positional parameter.

## PARAMETERS

### -Path
Specifies the PSRyver config file path that will be used as the default.

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.IO.FileInfo
## OUTPUTS

### System.IO.FileInfo
## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Public/Set-PSRyverConfigPath/](https://tlindsay42.github.io/PSRyver/Public/Set-PSRyverConfigPath/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Set-PSRyverConfigPath.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Set-PSRyverConfigPath.ps1)

[Get-PSRyverConfigPath]()

