function Format-RyverAttachmentObject {
    <#
    .SYNOPSIS
        Parse attachment objects.

    .DESCRIPTION
        Parse attachment objects.

    .INPUTS
        System.Management.Automation.PSCustomObject[]

    .INPUTS
        System.Management.Automation.PSCustomObject

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Format-RyverAttachmentObject -InputObject $objects
        Parses the attachment objects.

    .EXAMPLE
        $objects | Format-RyverAttachmentObject
        Parses the attachment objects via the pipeline.

    .EXAMPLE
        Format-RyverAttachmentObject $objects
        Parses the attachment objects via positional parameter.

    .LINK
        https://tlindsay42.github.io/PSRyver/Private/Format-RyverAttachmentObject/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Format-RyverAttachmentObject.ps1

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Private/Format-RyverAttachmentObject/'
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
        Write-Verbose -Message "Beginning: '${function}'."
    }

    process {
        Write-Verbose -Message (
            "Processing: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )

        foreach ( $object in $InputObject ) {
            [PSCustomObject] @{
                PSTypeName   = "PSRyver.$( $object.__Metadata.Type )"
                Metadata     = [PSCustomObject] @{
                    Type = $object.__Metadata.Type
                }
                ID           = $object.ID.ToUInt64( $null )
                Descriptor   = $object.__Descriptor
                CreateUser   = $object.CreateUser |
                    Format-RyverUserObject
                CreateDate   = $object.CreateDate
                CreateSource = $object.CreateSource |
                    Where-Object -FilterScript { $null -ne $_ } |
                    ForEach-Object -Process {
                        [PSCustomObject] @{
                            DisplayName = $_.DisplayName
                            Avatar      = $_.Avatar
                        }
                    }
                Title        = $object.Title
                Description  = $object.Description
                FileName     = $object.FileName
                Post         = $object.Post
                Task         = $object.Task
            }
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
