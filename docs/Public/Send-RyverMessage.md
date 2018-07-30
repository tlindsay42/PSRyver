# Send-RyverMessage

## SYNOPSIS
Send a Ryver message.

## SYNTAX

### IncomingWebhookUri (Default)
```
Send-RyverMessage [[-IncomingWebhookUri] <Uri>] [-Message] <String> [-Ephemeral] [[-FromDisplayName] <String>]
 [[-FromAvatar] <Uri>] [-Raw] [<CommonParameters>]
```

### ID
```
Send-RyverMessage [-ID] <UInt64> [-Type] <String> [-Message] <String> [-Ephemeral]
 [[-FromDisplayName] <String>] [[-FromAvatar] <Uri>] [-Raw] [[-Credential] <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Send a Ryver message.

## EXAMPLES

### EXAMPLE 1
```
Send-RyverMessage -Message 'Test'
```

If the default incoming webhook URI is set in the running configuration
(available via Get-PSRyverConfig), then the message 'Test' is posted in the
configured channel; otherwise, it will generate an invalid request error.

### EXAMPLE 2
```
Send-RyverMessage -ID 12345678 -Type 'Team' -Message 'Test'
```

Posts the message 'Test' in private team channel 12345678.

### EXAMPLE 3
```
Send-RyverMessage -IncomingWebhookUri 'https://example.ryver.com/application/webhook/4z-_G76nj7Fic-M' -Message 'Test'
```

Posts the message 'Test' to the channel configured in the specified incoming
webhook URI.

### EXAMPLE 4
```
Send-RyverMessage -ID 12345678 -Type 'Forum' -Message 'Test' -FromDisplayName 'PSRyver' -FromAvatar 'https://pbs.twimg.com/profile_images/825987046992814080/7VZkFQA9_400x400.jpg'
```

Posts the message 'Test' to public forum channel 12345678 with a display name
override of 'PSRyver', and an avatar override defined by the URI.

### EXAMPLE 5
```
Send-RyverMessage -ID 12345678 -Type 'Forum' -Message 'Test' -Ephemeral -Raw -Credential ( Get-Credential )
```

Updates the $Script:PSRyver.Authorization value storing the basic
authentication authorization header to use for all requests and then posts the
temporary message 'Test' in public forum channel 12345678, and the resultant
output will not be formatted. 
The temporary message will disappear for each
user after he or she reads the message and refresh.

### EXAMPLE 6
```
Get-RyverUser -ID 12345678 | Send-RyverMessage -Message 'Hello!'
```

Queries for the user with ID 12345678 and sends the message 'Hello!'.

### EXAMPLE 7
```
'All your base are belong to us.', 'You have no chance to survive make your time.' | Send-RyverMessage -ID 12345678 -Type 'Forum' -FromDisplayName 'CATS' -FromAvatar 'https://upload.wikimedia.org/wikipedia/en/0/03/Aybabtu.png'
```

Posts 'All your base are belong to us.' and 'You have not chance to survive
make your time.' in the Ryver public forum channel with the display name of
CATS and the Zero Wing CATS avatar image.

### EXAMPLE 8
```
Send-RyverMessage 12345678 'User' 'Test'
```

Posts the message 'Test' in a direct message to user 12345678.

## PARAMETERS

### -Credential
Credentials to use for the Ryver API.

Default value is the value set by Set-PSRyverConfig.

```yaml
Type: PSCredential
Parameter Sets: ID
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Ephemeral
Optional flag to indicate that you want the message to be ephemeral, meaning it
will be displayed to people in the Ryver client when the message comes in, but
the message will not be stored in chat history.
Once a user refreshes, the
message will go away.

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

### -FromAvatar
Specifies the From avatar displayed for the message.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FromDisplayName
Specifies the From name displayed for the message.

Anyone that clicks on the from name or reviews the chat history will see the
actual user account's display name.

```yaml
Type: String
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
direct message where the chat message will be posted.

```yaml
Type: UInt64
Parameter Sets: ID
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -IncomingWebhookUri
{{Fill IncomingWebhookUri Description}}

```yaml
Type: Uri
Parameter Sets: IncomingWebhookUri
Aliases:

Required: False
Position: 1
Default value: $Script:PSRyver.IncomingWebhookUri
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Message
Specifies the message content to post.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
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
Position: 6
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
Parameter Sets: ID
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### System.Void

## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/PSRyver/Public/Send-RyverMessage/](https://tlindsay42.github.io/PSRyver/Public/Send-RyverMessage/)

[https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Send-RyverMessage.ps1](https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Send-RyverMessage.ps1)

[https://api.ryver.com/ryvrest_api_examples.html#create-chat-message](https://api.ryver.com/ryvrest_api_examples.html#create-chat-message)

