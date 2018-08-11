# Get-RyverHistory

## SYNOPSIS
Get history from a Ryver public forum or private team channel.

## SYNTAX

```
Get-RyverHistory [-ID] <UInt64> [-Type] <String> [-Raw] [[-Credential] <PSCredential>] [-IncludeTotalCount]
 [-Skip <UInt64>] [-First <UInt64>] [<CommonParameters>]
```

## DESCRIPTION
Get history from a Ryver public forum or private team channel.

## EXAMPLES

### EXAMPLE 1
```
Get-RyverHistory -ID 12345678 -Type 'Team'
```

Queries for the chat history of the private team channel with ID 12345678.

### EXAMPLE 2
```
Get-RyverHistory -ID 12345678 -Type 'Forum' -Credential ( Get-Credential )
```

Updates the $Script:PSRyver.Authorization value storing the basic
authentication authorization header to use for all requests and then queries
for the chat history of the public forum channel with ID 12345678.

### EXAMPLE 3
```
12345678 | Get-RyverHistory -Type 'User' -Raw
```

Queries for the chat history with the user with ID 12345678 via pipeline value,
and returns the raw, unformatted output.

### EXAMPLE 4
```
[PSCustomObject] @{ ID = 12345678; Type = 'Team' } | Get-RyverHistory
```

Queries for the chat history with the user with ID 12345678 via pipeline
parameter names.

### EXAMPLE 5
```
Get-RyverHistory 12345678 'Forum' $true
```

Queries for the chat history of the public forum channel with ID 12345678 via
positional parameter and returns the raw, unformatted output.

## PARAMETERS

### -Credential
Credentials to use for the Ryver API.

Default value is the value set by Set-PSRyverConfig.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID
Specifies the ID of the public forum channel, private team channel, or user
direct message to download the chat history from.

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

### -Raw
Specifies that objects should not be formatted.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: False
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
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncludeTotalCount
Reports the number of objects in the data set (an integer) followed by the objects.
If the cmdlet cannot determine the total count, it returns 'Unknown total count'.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Skip
Ignores the first 'n' objects and then gets the remaining objects.

```yaml
Type: UInt64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -First
Gets only the first 'n' objects.

```yaml
Type: UInt64
Parameter Sets: (All)
Aliases:

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

### System.UInt64
### System.Management.Automation.PSCustomObject
## OUTPUTS

## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Public/Get-RyverHistory/](https://tlindsay42.github.io/PSRyver/Public/Get-RyverHistory/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Get-RyverHistory.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Get-RyverHistory.ps1)

