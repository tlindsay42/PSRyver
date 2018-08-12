function Format-RyverTopicObject {
    <#
    .SYNOPSIS
        Parse topic objects.

    .DESCRIPTION
        Parse topic objects.

    .INPUTS
        System.Management.Automation.PSCustomObject[]

    .INPUTS
        System.Management.Automation.PSCustomObject

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Format-RyverTopicObject -InputObject $objects
        Parses the topic objects.

    .EXAMPLE
        $objects | Format-RyverTopicObject
        Parses the topic objects via the pipeline.

    .EXAMPLE
        Format-RyverTopicObject $objects
        Parses the topic objects via positional parameter.

    .LINK
        https://tlindsay42.github.io/PSRyver/Private/Format-RyverTopicObject/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Format-RyverTopicObject.ps1

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Private/Format-RyverTopicObject/'
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
                ID           = $object.ID
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
                RecordType   = $object.RecordType
                Subject      = $object.Subject
                Body         = $object.Body
            }
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
