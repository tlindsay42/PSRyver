# Get-RyverTeam

## SYNOPSIS
Query for Ryver private team channels.

## SYNTAX

### ID (Default)
```
Get-RyverTeam [[-ID] <UInt64>] [-Detailed] [-Raw] [[-Credential] <PSCredential>] [-IncludeTotalCount]
 [-Skip <UInt64>] [-First <UInt64>] [<CommonParameters>]
```

### Name
```
Get-RyverTeam [[-Name] <String>] [-Detailed] [-Raw] [[-Credential] <PSCredential>] [-IncludeTotalCount]
 [-Skip <UInt64>] [-First <UInt64>] [<CommonParameters>]
```

## DESCRIPTION
Query for Ryver private team channels.

## EXAMPLES

### EXAMPLE 1
```
Get-RyverTeam -ID 12345678
```

Queries for the private team channel with ID 12345678.

### EXAMPLE 2
```
12345678 | Get-RyverTeam
```

Queries for the private team channel with ID 12345678 via pipeline value.

### EXAMPLE 3
```
Get-RyverTeam 12345678
```

Queries for the private team channel with ID 12345678 via positional parameter.

### EXAMPLE 4
```
Get-RyverTeam -Name 'Members Only!'
```

Queries for the 'Members Only!' private team channel.

### EXAMPLE 5
```
Get-RyverTeam -Name '*Only*' -Credential ( Get-Credential )
```

Updates the $Script:PSRyver.Authorization value storing the basic
authentication authorization header to use for all requests and then queries
for all private team channels containing the string 'Only', such as
'Members Only!' and 'Ninjas only'.

### EXAMPLE 6
```
'Members Only!' | Get-RyverTeam -Raw
```

Queries for the 'Members Only!' private team channel via the pipeline and
returns the raw, unformatted output.

### EXAMPLE 7
```
'*Member*' | Get-RyverTeam -Detailed
```

Queries for detailed information about all private team channels containing the
string 'Member', such as 'Members Only!' and 'Illuminati Membership Committee'.

### EXAMPLE 8
```
Get-RyverTeam 'Members Only!' $true $true
```

Queries for detailed information about the 'Members Only!' private team channel
via positional parameters and returns the raw, unformatted output.

### EXAMPLE 9
```
[PSCustomObject] @{ ID = [UInt64] 12345678 } | Get-RyverTeam
```

Queries for the private team channel with ID 12345678 via pipeline parameter
name.

### EXAMPLE 10
```
[PSCustomObject] @{ Name = 'Members Only!' } | Get-RyverTeam
```

Queries for the 'Members Only!' private team channel via pipeline parameter
name.

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

### -Detailed
Specifies whether to retrieve additional details about each object.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ID
Specifies the public forum channel ID.

```yaml
Type: UInt64
Parameter Sets: ID
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Name
Private team channel name. 
Case insensitive.

```yaml
Type: String
Parameter Sets: Name
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
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

### System.String
## OUTPUTS

### System.Management.Automation.PSObject[]
### System.Management.Automation.PSObject
## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Public/Get-RyverTeam/](https://tlindsay42.github.io/PSRyver/Public/Get-RyverTeam/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Get-RyverTeam.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Get-RyverTeam.ps1)

