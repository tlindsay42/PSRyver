# Export-PSRyverConfig

## SYNOPSIS
Save the PSRyver module configuration to file.

## SYNTAX

```
Export-PSRyverConfig [[-Path] <FileInfo>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Save the PSRyver module configuration to file.

## EXAMPLES

### EXAMPLE 1
```
Export-PSRyverConfig
```

Saves the PSRyver module configuration stored in $Script:PSRyver to the default
file path stored in $Script:PSRyverConfigFilePath, which can be accessed via
Get-PSRyverConfigPath and set via Set-PSRyverConfigPath. 
The default location
is '~/.psryver.xml'

### EXAMPLE 2
```
Export-PSRyverConfig -Path '~/.psryver.xml'
```

Saves the PSRyver module configuration stored in $Script:PSRyver to the
specified path of '~/.psryver.xml'.

### EXAMPLE 3
```
'~/.psryver.xml' | Export-PSRyverConfig
```

Saves the PSRyver module configuration stored in $Script:PSRyver to the
specified path of '~/.psryver.xml', which is set via the pipeline.

## PARAMETERS

### -Path
Specifies the PSRyver config file to export.

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $Script:PSRyverConfigFilePath
Accept pipeline input: True (ByPropertyName, ByValue)
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

### System.Void

## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Public/Export-PSRyverConfig/](https://tlindsay42.github.io/PSRyver/Public/Export-PSRyverConfig/)

[https://github.com/PSRyver/blob/master/PSRyver/Public/Export-PSRyverConfig.ps1](https://github.com/PSRyver/blob/master/PSRyver/Public/Export-PSRyverConfig.ps1)

[Import-PSRyverConfig]()

[Read-PSRyverConfig]()

[Get-PSRyverConfig]()

[Set-PSRyverConfig]()

[Get-PSRyverConfigPath]()

[Set-PSRyverConfigPath]()

