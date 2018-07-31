function Remove-RyverMessage {
    <#
    .SYNOPSIS
        Delete a Ryver message.

    .DESCRIPTION
        Delete a Ryver message.

    .INPUTS
        System.String

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Remove-RyverMessage -ID 001234567890123456789 -ChannelID 12345678 -Type 'Forum'
        Deletes message with ID 001234567890123456789 in the public forum channel with
        ID 12345678.

    .EXAMPLE
        001234567890123456789 | Remove-RyverMessage -ChannelID 12345678 -Type 'Team'
        Deletes message with ID 001234567890123456789 in the private team channel with
        ID 12345678 via pipeline value.

    .EXAMPLE
        Remove-RyverMessage 001234567890123456789 12345678 'User'
        Deletes message with ID 001234567890123456789 in the public forum with ID
        12345678 via positional parameter.

    .EXAMPLE
        [PSCustomObject] @{ ID = 001234567890123456789; ChannelID = 12345678; Type = 'Forum' } | Remove-RyverMessage
        Deletes message with ID 001234567890123456789 in the public forum with ID
        12345678 via the pipeline by parameter name.

    .LINK
        https://tlindsay42.github.io/PSRyver/Public/Remove-RyverMessage/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Remove-RyverMessage.ps1

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Public/Remove-RyverMessage/',
        SupportsShouldProcess = $true,
        ConfirmImpact = 'High'
    )]
    [OutputType( [Void] )]
    param (
        # Specifies the ID of the message that will be deleted.
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [UInt64]
        $ID,

        <#
        Specifies the ID of the public forum channel, private team channel, or user
        direct message where the chat message will be posted.
        #>
        [Parameter(
            Mandatory = $true,
            Position = 1,
            ValueFromPipelineByPropertyName = $true
        )]
        [UInt64]
        $ChannelID,

        <#
        Specifies the type of channel to post the message in:
        - Public forum
        - Private team
        - User direct message
        #>
        [Parameter(
            Mandatory = $true,
            Position = 2,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet( 'Forum', 'Team', 'User' )]
        [String]
        $Type
    )

    begin {
        $function = $MyInvocation.MyCommand.Name

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )

        Assert-RyverApiConfig
    }

    process {
        #region init
        $path = '/'
        #endregion

        if ( $PSCmdlet.ShouldProcess( $ID, 'Delete Ryver message' ) -eq $true ) {
            switch ( $Type ) {
                'Forum' {
                    $path += "forums(${ChannelID})"
                }

                'Team' {
                    $path += "workrooms(${ChannelID})"
                }

                'User' {
                    $path += "users(${ChannelID})"
                }
            }

            $path += '/Chat.DeleteMessage()'

            $splat = @{
                Path   = $path
                Method = 'Post'
                Body   = @{ id = $ID } |
                    ConvertTo-Json -ErrorAction 'Stop'
            }
            Invoke-RyverRestMethod @splat
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
