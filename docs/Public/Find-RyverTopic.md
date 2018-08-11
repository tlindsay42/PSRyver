# Find-RyverTopic

## SYNOPSIS
Find Ryver topics.

## SYNTAX

```
Find-RyverTopic [-SearchText] <String> [-Raw] [[-Credential] <PSCredential>] [-IncludeTotalCount]
 [-Skip <UInt64>] [-First <UInt64>] [<CommonParameters>]
```

## DESCRIPTION
Queries for the specified search text in the topics in all public forums &
private teams that the user is a member of, as well as all direct message
topics that match the search text.

## EXAMPLES

### EXAMPLE 1
```
Find-RyverTopic -SearchText 'Hello world!' -Credential ( Get-Credential )
```

Updates the $Script:PSRyver.Authorization value storing the basic
authorization header to use for all requests and then queries all topics
containing the text 'Hello world!' in all public forums & private teams that
the user is a member of, as well as all direct messages.

### EXAMPLE 2
```
'Hello world!' | Find-RyverTopic -Raw
```

Queries all topics containing the text 'Hello world!' via the pipeline in all
public forums & private teams that the user is a member of, as well as all
direct messages, and returns the raw, unformatted output.

### EXAMPLE 3
```
[PSCustomObject] @{ SearchText = 'Hello world!' } | Find-RyverTopic
```

Queries all topics containing the text 'Hello world!' via the pipeline by
parameter name in all public forums & private teams that the user is a member
of, as well as all direct messages.

### EXAMPLE 4
```
Find-RyverTopic 'Hello world!'
```

Queries for all topics containing the text 'Hello world!' via positional
parameter.

## PARAMETERS

### -Credential
Credentials to use for the Ryver API.

Default value is the value set by Set-PSRyverConfig.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Raw
Specifies that objects should not be formatted.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchText
Specifies the text to search for.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
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
### System.Management.Automation.PSCustomObject
## OUTPUTS

### System.Management.Automation.PSObject[]
### System.Management.Automation.PSObject
## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Public/Find-RyverTopic/](https://tlindsay42.github.io/PSRyver/Public/Find-RyverTopic/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Find-RyverTopic.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Find-RyverTopic.ps1)

