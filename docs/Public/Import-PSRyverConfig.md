# Import-PSRyverConfig

## SYNOPSIS
Import a PSRyver module configuration from file.

## SYNTAX

```
Import-PSRyverConfig [[-Path] <FileInfo>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Import a PSRyver module configuration from file and set the $Script:PSRyver
module configuration variable.

## EXAMPLES

### EXAMPLE 1
```

```

## PARAMETERS

### -Path
Specifies the PSRyver config file to import.

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $Script:PSRyverConfigFilePath
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

### System.Void

## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Public/Import-PSRyverConfig/](https://tlindsay42.github.io/PSRyver/Public/Import-PSRyverConfig/)

[https://github.com/PSRyver/blob/master/PSRyver/Public/Import-PSRyverConfig.ps1](https://github.com/PSRyver/blob/master/PSRyver/Public/Import-PSRyverConfig.ps1)

[Export-PSRyverConfig]()

[Read-PSRyverConfig]()

[Get-PSRyverConfig]()

[Set-PSRyverConfig]()

[Get-PSRyverConfigPath]()

[Set-PSRyverConfigPath]()

