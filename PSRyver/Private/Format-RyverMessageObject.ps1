function Format-RyverMessageObject {
    <#
    .SYNOPSIS
        Parse message objects.

    .DESCRIPTION
        Parse message objects.

    .INPUTS
        System.Management.Automation.PSCustomObject[]

    .INPUTS
        System.Management.Automation.PSCustomObject

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Format-RyverMessageObject -InputObject $objects
        Parses the message objects.

    .EXAMPLE
        $objects | Format-RyverMessageObject
        Parses the message objects via the pipeline.

    .EXAMPLE
        Format-RyverMessageObject $objects
        Parses the message objects via positional parameter.

    .LINK
        https://tlindsay42.github.io/PSRyver/Private/Format-RyverMessageObject/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Format-RyverMessageObject.ps1

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Private/Format-RyverMessageObject/'
    )]
    [OutputType( [PSCustomObject[]] )]
    [OutputType( [PSCustomObject] )]
    param (
        # The public forum or private team channel objects to parse.
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
        )]
        [PSCustomObject[]]
        $InputObject
    )

    begin {
        $function = $MyInvocation.MyCommand.Name

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )
    }

    process {
        foreach ( $object in $InputObject ) {
            [PSCustomObject] @{
                PSTypeName   = 'PSRyver.Entity.Message'
                ID           = $object.ID
                MessageType  = $object.MessageType
                CreateDate   = $object.When
                ModifyDate   = $object.ModifyDate
                CreateSource = $object.CreateSource |
                    Where-Object -FilterScript { $null -ne $_ } |
                    ForEach-Object -Process {
                        [PSCustomObject] @{
                            DisplayName = $_.DisplayName
                            Avatar      = $_.Avatar
                        }
                    }
                ModifySource = $object.ModifySource
                To           = [PSCustomObject] @{
                    PSTypeName = "PSRyver.$( $object.From.__Metadata.Type )"
                    Metadata   = [PSCustomObject] @{
                        Type = $object.To.__Metadata.Type
                    }
                    ID         = $object.To.ID
                    Descriptor = $object.To.__Descriptor
                    JID        = $object.To.JID
                }
                From         = [PSCustomObject] @{
                    PSTypeName = "PSRyver.$( $object.From.__Metadata.Type )"
                    Metadata   = [PSCustomObject] @{
                        Type = $object.From.__Metadata.Type
                    }
                    ID         = $object.From.ID
                    Descriptor = $object.From.__Descriptor
                    JID        = $object.From.JID
                }
                Body         = $object.Body
                Reactions    = $object.__Reactions
                Embeds       = $object.Embeds
            }
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
