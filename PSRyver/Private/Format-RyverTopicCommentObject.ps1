function Format-RyverTopicCommentObject {
    <#
    .SYNOPSIS
        Parse topic comment objects.

    .DESCRIPTION
        Parse topic comment objects.

    .INPUTS
        System.Management.Automation.PSCustomObject[]

    .INPUTS
        System.Management.Automation.PSCustomObject

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Format-RyverTopicCommentObject -InputObject $objects
        Parses the topic comment objects.

    .EXAMPLE
        $objects | Format-RyverTopicCommentObject
        Parses the topic comment objects via the pipeline.

    .EXAMPLE
        Format-RyverTopicCommentObject $objects
        Parses the topic comment objects via positional parameter.

    .LINK
        https://tlindsay42.github.io/PSRyver/Private/Format-RyverTopicCommentObject/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Format-RyverTopicCommentObject.ps1

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Private/Format-RyverTopicCommentObject/'
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
                Comment      = $object.Comment
                Post         = $object.Post |
                    Where-Object -FilterScript { $null -ne $_ } |
                    ForEach-Object -Process {
                        [PSCustomObject] @{
                            PSTypeName   = "PSRyver.$( $_.__Metadata.Type )"
                            Metadata     = [PSCustomObject] @{
                                Type = $_.__Metadata.Type
                            }
                            ID             = $_.ID.ToUInt64( $null )
                            Descriptor     = $_.__Descriptor
                        }
                    }
            }
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
