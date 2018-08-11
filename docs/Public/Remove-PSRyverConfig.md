# Remove-PSRyverConfig

## SYNOPSIS
Remove the PSRyver module configuration.

## SYNTAX

```
Remove-PSRyverConfig [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove the PSRyver module configuration by removing the $Script:PSRyver
variable. 
Run 'Import-PSRyverConfig' or 'Initialize-PSRyverConfig' to
recreate it.

## EXAMPLES

### EXAMPLE 1
```
Remove-PSRyverConfig
```

Remove the PSRyver module configuration by removing the $Script:PSRyver
variable.

## PARAMETERS

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

### None
###     You cannot pipe input to this cmdlet.
## OUTPUTS

### System.Void
## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Public/Remove-PSRyverConfig/](https://tlindsay42.github.io/PSRyver/Public/Remove-PSRyverConfig/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Remove-PSRyverConfig.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Remove-PSRyverConfig.ps1)

[Get-PSRyverConfig]()

[Initialize-PSRyverConfig]()

[Export-PSRyverConfig]()

