# Remove-RyverMessage

## SYNOPSIS
Delete a Ryver message.

## SYNTAX

```
Remove-RyverMessage [-ID] <UInt64> [-ChannelID] <UInt64> [-Type] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Delete a Ryver message.

## EXAMPLES

### EXAMPLE 1
```
Remove-RyverMessage -ID 001234567890123456789 -ChannelID 12345678 -Type 'Forum'
```

Deletes message with ID 001234567890123456789 in the public forum channel with
ID 12345678.

### EXAMPLE 2
```
001234567890123456789 | Remove-RyverMessage -ChannelID 12345678 -Type 'Team'
```

Deletes message with ID 001234567890123456789 in the private team channel with
ID 12345678 via pipeline value.

### EXAMPLE 3
```
Remove-RyverMessage 001234567890123456789 12345678 'User'
```

Deletes message with ID 001234567890123456789 in the public forum with ID
12345678 via positional parameter.

### EXAMPLE 4
```
[PSCustomObject] @{ ID = 001234567890123456789; ChannelID = 12345678; Type = 'Forum' } | Remove-RyverMessage
```

Deletes message with ID 001234567890123456789 in the public forum with ID
12345678 via the pipeline by parameter name.

## PARAMETERS

### -ChannelID
Specifies the ID of the public forum channel, private team channel, or user
direct message where the chat message will be posted.

```yaml
Type: UInt64
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ID
Specifies the ID of the message that will be deleted.

```yaml
Type: UInt64
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Type
Specifies the type of channel to post the message in:
- Public forum
- Private team
- User direct message

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### System.String
## OUTPUTS

### System.Void
## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Public/Remove-RyverMessage/](https://tlindsay42.github.io/PSRyver/Public/Remove-RyverMessage/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Remove-RyverMessage.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Remove-RyverMessage.ps1)

