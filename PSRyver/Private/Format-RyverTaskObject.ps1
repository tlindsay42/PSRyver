function Format-RyverTaskObject {
    <#
    .SYNOPSIS
        Parse task objects.

    .DESCRIPTION
        Parse task objects.

    .INPUTS
        System.Management.Automation.PSCustomObject[]

    .INPUTS
        System.Management.Automation.PSCustomObject

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Format-RyverTaskObject -InputObject $objects
        Parses the task objects.

    .EXAMPLE
        $objects | Format-RyverTaskObject
        Parses the task objects via the pipeline.

    .EXAMPLE
        Format-RyverTaskObject $objects
        Parses the task objects via positional parameter.

    .LINK
        https://tlindsay42.github.io/PSRyver/Private/Format-RyverTaskObject/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Format-RyverTaskObject.ps1

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Private/Format-RyverTaskObject/'
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
                Subject      = $object.Subject
                Body         = $object.Body
                Position     = $object.Position.ToUInt16( $null )
                Tags         = $object.Tags |
                    Where-Object -FilterScript { $null -ne $_ }
                Short        = $object.Short
                DueDate      = $object.DueDate
                CompleteDate = $object.CompleteDate
                Archived     = [Boolean] $object.Archived
                Category     = $object.Category |
                    Where-Object -FilterScript { $null -ne $_ } |
                    ForEach-Object -Process {
                        [PSCustomObject] @{
                            PSTypeName   = "PSRyver.$( $_.__Metadata.Type )"
                            Metadata     = [PSCustomObject] @{
                                Type = $_.__Metadata.Type
                            }
                            ID         = [UInt64] $_.ID
                            Descriptor = $_.__Descriptor
                            Name       = $_.Name
                            Position   = $_.Position
                            Tasks          = $_.Tasks |
                                Where-Object -FilterScript { $null -ne $_ } |
                                ForEach-Object -Process {
                                    [PSCustomObject] @{
                                        Results = [PSCustomObject] @{
                                            Deferred = $_.Results.__Deferred
                                        }
                                    }
                                }
                        }
                    }
                Parent       = $object.Parent |
                    Where-Object -FilterScript { $null -ne $_ } |
                    ForEach-Object -Process {
                        [PSCustomObject] @{
                            PSTypeName   = "PSRyver.$( $_.__Metadata.Type )"
                            Metadata     = [PSCustomObject] @{
                                Type = $_.__Metadata.Type
                            }
                            ID         = [UInt64] $_.ID
                            Descriptor = $_.__Descriptor
                        }
                    }
                Assignees    = $object.Assignees |
                    Select-Object -ExpandProperty 'Results' -ErrorAction 'SilentlyContinue' |
                    Where-Object -FilterScript { $null -ne $_ } |
                    Format-RyverUserObject
                Board        = $object.Board |
                    Where-Object -FilterScript { $null -ne $_ } |
                    ForEach-Object -Process {
                        [PSCustomObject] @{
                            PSTypeName   = "PSRyver.$( $_.__Metadata.Type )"
                            Metadata     = [PSCustomObject] @{
                                Type = $_.__Metadata.Type
                            }
                            ID         = [UInt64] $_.ID
                            Descriptor = $_.__Descriptor
                        }
                    }
            }
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
