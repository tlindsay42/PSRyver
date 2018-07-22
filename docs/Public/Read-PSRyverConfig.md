# Read-PSRyverConfig

## SYNOPSIS
Read a PSRyver module configuration file.

## SYNTAX

```
Read-PSRyverConfig [[-Path] <FileInfo>] [<CommonParameters>]
```

## DESCRIPTION
Read a PSRyver module configuration file and if the user has the correct key
and run from a Windows system, decrypt the encrypted settings via the
Data Protection API (DPAPI).

## EXAMPLES

### EXAMPLE 1
```
Read-PSRyverConfig
```

Reads the PSRyver module configuration stored in the file defined in
'$Script:PSRyverConfigFilePath', which can be accessed via
'Get-PSRyverConfigPath' and set via 'Set-PSRyverConfigPath'. 
The encrypted
values are decrypted if the user has the correct key and if run from a Windows
system.

The default location is '~/.psryver.xml'

### EXAMPLE 2
```
Read-PSRyverConfig -Path '~/.psryver.xml'
```

Reads & decrypts the PSRyver module configuration stored in the specified path.

### EXAMPLE 3
```
'~/.psryver.xml' | Read-PSRyverConfig
```

Reads & decrypts the PSRyver module configuration stored in the path specified
via the pipeline.

### EXAMPLE 4
```
Read-PSRyverConfig '~/.psryver.xml'
```

Reads & decrypts the PSRyver module configuration stored in the path specified
via positional parameter.

## PARAMETERS

### -Path
Specifies the PSRyver config file.

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

[https://tlindsay42.github.io/PSRyver/Public/Read-PSRyverConfig/](https://tlindsay42.github.io/PSRyver/Public/Read-PSRyverConfig/)

[https://github.com/PSRyver/blob/master/PSRyver/Public/Read-PSRyverConfig.ps1](https://github.com/PSRyver/blob/master/PSRyver/Public/Read-PSRyverConfig.ps1)

[Import-PSRyverConfig]()

