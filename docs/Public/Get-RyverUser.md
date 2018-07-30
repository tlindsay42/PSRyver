# Get-RyverUser

## SYNOPSIS
Query for Ryver users.

## SYNTAX

### ID (Default)
```
Get-RyverUser [[-ID] <UInt64>] [-Detailed] [-Raw] [[-Credential] <PSCredential>] [-IncludeTotalCount]
 [-Skip <UInt64>] [-First <UInt64>] [<CommonParameters>]
```

### Name
```
Get-RyverUser [[-Name] <String>] [-Detailed] [-Raw] [[-Credential] <PSCredential>] [-IncludeTotalCount]
 [-Skip <UInt64>] [-First <UInt64>] [<CommonParameters>]
```

## DESCRIPTION
Query for users in this Ryver instance.

## EXAMPLES

### EXAMPLE 1
```
Get-RyverUser -ID 12345678
```

Queries for the user account with ID 12345678.

### EXAMPLE 2
```
12345678 | Get-RyverUser
```

Queries for the user account with ID 12345678 via pipeline value.

### EXAMPLE 3
```
Get-RyverUser 12345678
```

Queries for the user account with ID 12345678 via positional parameter.

### EXAMPLE 4
```
Get-RyverUser -Name 'Eddy Bot'
```

Queries for the 'Eddy Bot' user account.

### EXAMPLE 5
```
Get-RyverUser -Name 'Eddy*' -Credential ( Get-Credential )
```

Updates the $Script:PSRyver.Authorization value storing the basic
authentication authorization header to use for all requests and then queries
for all users starting with the string 'Eddy', such as 'Eddy Bot' and
'Eddy Munster'.

### EXAMPLE 6
```
'Eddy Bot' | Get-RyverUser -Detailed
```

Queries for detailed information about the 'Eddy Bot' user account via the
pipeline.

### EXAMPLE 7
```
'*Bot*' | Get-RyverUser -Raw
```

Queries for all user accounts containing the string '*Bot*', such as 'Eddy Bot'
and "Don't Bother Me!" and returns the raw, unformatted output.

### EXAMPLE 8
```
Get-RyverUser 'Eddy Bot' $true $true
```

Queries for detailed information about the 'Eddy Bot' user account via
positional parameters and returns the raw, unformatted output.

### EXAMPLE 9
```
[PSCustomObject] @{ ID = [UInt64] 12345678 } | Get-RyverUser
```

Queries for the user account with ID 12345678 via pipeline parameter name.

### EXAMPLE 10
```
[PSCustomObject] @{ Name = 'Eddy Bot' } | Get-RyverUser
```

Queries for the 'Eddy Bot' user account via pipeline parameter name.

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

### -IncludeTotalCount
Reports the number of objects in the data set (an integer) followed by the objects. If
the cmdlet cannot determine the total count, it returns "Unknown total count".

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

### -Name
Specifies the public forum channel name. 
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

[https://tlindsay42.github.io/PSRyver/Public/Get-RyverUser/](https://tlindsay42.github.io/PSRyver/Public/Get-RyverUser/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Get-RyverUser.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Get-RyverUser.ps1)

[https://api.ryver.com/ryvrest_api_examples.html#get-organization-users](https://api.ryver.com/ryvrest_api_examples.html#get-organization-users)

