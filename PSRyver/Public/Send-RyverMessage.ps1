function Send-RyverMessage {
    <#
    .SYNOPSIS
        Send a Ryver message.

    .DESCRIPTION
        Send a Ryver message.

    .INPUTS
        System.String

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Send-RyverMessage -Message 'Test'
        If the default incoming webhook URI is set in the running configuration
        (available via Get-PSRyverConfig), then the message 'Test' is posted in the
        configured channel; otherwise, it will generate an invalid request error.

    .EXAMPLE
        Send-RyverMessage -ID 12345678 -Type 'Team' -Message 'Test'
        Posts the message 'Test' in private team channel 12345678.

    .EXAMPLE
        Send-RyverMessage -IncomingWebhookUri 'https://example.ryver.com/application/webhook/4z-_G76nj7Fic-M' -Message 'Test'
        Posts the message 'Test' to the channel configured in the specified incoming
        webhook URI.

    .EXAMPLE
        Send-RyverMessage -ID 12345678 -Type 'Forum' -Message 'Test' -FromDisplayName 'PSRyver' -FromAvatar 'https://pbs.twimg.com/profile_images/825987046992814080/7VZkFQA9_400x400.jpg'
        Posts the message 'Test' to public forum channel 12345678 with a display name
        override of 'PSRyver', and an avatar override defined by the URI.

    .EXAMPLE
        Send-RyverMessage -ID 12345678 -Type 'Forum' -Message 'Test' -Ephemeral -Raw -Credential ( Get-Credential )
        Updates the $Script:PSRyver.Authorization value storing the basic
        authentication authorization header to use for all requests and then posts the
        temporary message 'Test' in public forum channel 12345678, and the resultant
        output will not be formatted.  The temporary message will disappear for each
        user after he or she reads the message and refresh.

    .EXAMPLE
        Get-RyverUser -ID 12345678 | Send-RyverMessage -Message 'Hello!'
        Queries for the user with ID 12345678 and sends the message 'Hello!'.

    .EXAMPLE
        'All your base are belong to us.', 'You have no chance to survive make your time.' | Send-RyverMessage -ID 12345678 -Type 'Forum' -FromDisplayName 'CATS' -FromAvatar 'https://upload.wikimedia.org/wikipedia/en/0/03/Aybabtu.png'
        Posts 'All your base are belong to us.' and 'You have not chance to survive
        make your time.' in the Ryver public forum channel with the display name of
        CATS and the Zero Wing CATS avatar image.

    .EXAMPLE
        Send-RyverMessage 12345678 'User' 'Test'
        Posts the message 'Test' in a direct message to user 12345678.

    .LINK
        https://tlindsay42.github.io/PSRyver/Public/Send-RyverMessage/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Send-RyverMessage.ps1

    .LINK
        https://api.ryver.com/ryvrest_api_examples.html#create-chat-message

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding( DefaultParameterSetName = 'IncomingWebhookUri' )]
    [OutputType( [PSCustomObject[]], [PSCustomObject], ParameterSetName = 'ID' )]
    [OutputType( [Void], ParameterSetName = 'IncomingWebhookUri' )]
    param (
        <#
        Specifies the ID of the public forum channel, private team channel, or user
        direct message where the chat message will be posted.
        #>
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'ID',
            Position = 0,
            ValueFromPipelineByPropertyName = $true
        )]
        [UInt64]
        $ID,

        <#
        Specifies the type of channel to post the message in:
        - Public forum
        - Private team
        - User direct message
        #>
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'ID',
            Position = 1,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet( 'Forum', 'Team', 'User' )]
        [String]
        $Type,

        [Parameter(
            ParameterSetName = 'IncomingWebhookUri',
            Position = 0,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateScript( {
                $_.IsAbsoluteUri -eq $true -and
                $_.Scheme -eq 'https'
            }
        )]
        [Uri]
        $IncomingWebhookUri = $Script:PSRyver.IncomingWebhookUri,

        # Specifies the message content to post.
        [Parameter(
            ParameterSetName = 'ID',
            Mandatory = $true,
            Position = 2,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [Parameter(
            ParameterSetName = 'IncomingWebhookUri',
            Mandatory = $true,
            Position = 1,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]
        $Message,

        <#
        Optional flag to indicate that you want the message to be ephemeral, meaning it
        will be displayed to people in the Ryver client when the message comes in, but
        the message will not be stored in chat history. Once a user refreshes, the
        message will go away.
        #>
        [Parameter(
            ParameterSetName = 'ID',
            Position = 3
        )]
        [Parameter(
            ParameterSetName = 'IncomingWebhookUri',
            Position = 2
        )]
        [Switch]
        $Ephemeral,

        <#
        Specifies the From name displayed for the message.

        Anyone that clicks on the from name or reviews the chat history will see the
        actual user account's display name.
        #>
        [Parameter(
            ParameterSetName = 'ID',
            Position = 4
        )]
        [Parameter(
            ParameterSetName = 'IncomingWebhookUri',
            Position = 3
        )]
        [ValidateNotNullOrEmpty()]
        [String]
        $FromDisplayName,

        # Specifies the From avatar displayed for the message.
        [Parameter(
            ParameterSetName = 'ID',
            Position = 5
        )]
        [Parameter(
            ParameterSetName = 'IncomingWebhookUri',
            Position = 4
        )]
        [ValidateScript( { $_.IsAbsoluteUri -eq $true } )]
        [Uri]
        $FromAvatar,

        # Specifies that objects should not be formatted.
        [Parameter(
            ParameterSetName = 'ID',
            Position = 6
        )]
        [Parameter(
            ParameterSetName = 'IncomingWebhookUri',
            Position = 5
        )]
        [Switch]
        $Raw,

        <#
        Credentials to use for the Ryver API.

        Default value is the value set by Set-PSRyverConfig.
        #>
        [Parameter(
            ParameterSetName = 'ID',
            Position = 7
        )]
        [PSCredential]
        $Credential
    )

    begin {
        $function = $MyInvocation.MyCommand.Name

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )

        if ( $PSBoundParameters.ContainsKey( 'Credential' ) ) {
            $Script:PSRyver.Authorization = ConvertTo-Authorization -Credential $Credential
            Remove-Variable -Name 'Credential'
        }
    }

    process {
        #region Build Body
        $body = @{
            # Key names are case sensitive
            body        = $Message
            isEphemeral = [Boolean] $Ephemeral
        }

        if (
            $PSBoundParameters.ContainsKey( 'FromDisplayName' ) -eq $true -or
            $PSBoundParameters.ContainsKey( 'FromAvatar' ) -eq $true
        ) {
            $body.Add(
                # Key name is case sensitive
                'createSource',
                @{
                    # Key names are case sensitive
                    avatar      = $FromAvatar
                    displayName = $FromDisplayName
                }
            )
        }

        $body = $body |
            ConvertTo-Json -ErrorAction 'Stop'
        #endregion

        if ( $PSCmdlet.ParameterSetName -eq 'ID' ) {
            #region init
            $path = '/'
            #endregion

            Assert-RyverApiConfig

            #region Build Path
            switch ( $Type ) {
                'Forum' {
                    $path += "forums(${ID})"
                }

                'Team' {
                    $path += "workrooms(${ID})"
                }

                'User' {
                    $path += "users(${ID})"
                }
            }

            $path += '/Chat.PostMessage()'
            #endregion

            #region Send message
            $splat = @{
                Path   = $path
                Method = 'Post'
                Body   = $body
            }
            $response = Invoke-RyverRestMethod @splat
            #endregion

            #region Process response
            $return = $response |
                Select-Object -ExpandProperty 'D'

            if ( $Raw -eq $true ) {
                $return
            }
            else {
                [PSCustomObject] @{
                    ID = $return.ID
                }
            }
            #endregion
        }
        elseif ( $IncomingWebhookUri ) {
            $splat = @{
                Uri     = $IncomingWebhookUri
                Headers = @{
                    Accept         = 'application/json'
                    'Content-Type' = 'application/json'
                }
                Method  = 'Post'
                Body    = $body
            }
            $response = Invoke-WebRequest @splat

            $response |
                Out-String |
                Write-Verbose

            $response.Content |
                ConvertFrom-Json
        }
        else {
            $splat = @{
                Message     = 'Invalid request: Please either specify ID & Type or an incoming webhook URI.'
                ErrorAction = 'Stop'
            }
            Write-Error @splat
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
