function Format-RyverChannelObject {
    <#
    .SYNOPSIS
        Parse forum & team channel objects.

    .DESCRIPTION
        Parse public forum & private team channel objects.

    .INPUTS
        System.Management.Automation.PSCustomObject[]

    .INPUTS
        System.Management.Automation.PSCustomObject

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Format-RyverChannelObject -InputObject $objects
        Parses the forum or team channel objects.

    .EXAMPLE
        $objects | Format-RyverChannelObject
        Parses the forum or team channel objects via the pipeline.

    .EXAMPLE
        Format-RyverChannelObject $objects
        Parses the forum or team channel objects via positional parameter.

    .LINK
        https://tlindsay42.github.io/PSRyver/Private/Format-RyverChannelObject/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Format-RyverChannelObject.ps1

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Private/Format-RyverChannelObject/'
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
                PSTypeName          = "PSRyver.$( $object.__Metadata.Type )"
                Metadata            = [PSCustomObject] @{
                    Uri  = $object.__Metadata.Uri
                    Type = $object.__Metadata.Type
                    ETag = $object.__Metadata.ETag
                }
                ID                  = $object.ID
                CreateDate          = $object.CreateDate
                ModifyDate          = $object.ModifyDate
                CreateSource        = $object.CreateSource
                ModifySource        = $object.ModifySource
                Name                = $object.Name
                Nickname            = $object.Nickname
                Description         = $object.Description
                About               = $object.About
                Avatar              = $object.Avatar
                HasAvatar           = $object.HasAvatar
                Identifier          = $object.Identifier
                Channel             = $object.Channel
                JID                 = $object.JID
                Active              = $object.Active
                AddNewMembers       = $object.AddNewMembers
                SharePosts          = $object.SharePosts
                ShareTasks          = $object.ShareTasks
                TagDefs             = $object.TagDefs |
                    Where-Object -FilterScript { $null -ne $_ } |
                    ForEach-Object -Process {
                        [PSCustomObject] @{
                            Name   = $_.Name
                            Colors = [PSCustomObject] @{
                                Text       = $_.Colors.Text
                                Background = $_.Colors.Background
                                Border     = $_.Colors.Border
                            }
                        }
                    }
                Settings            = $object.Settings
                Tabs                = $object.Tabs
                Descriptor          = $object.__Descriptor
                Permissions         = $object.__Permissions
                Bookmarked          = $object.__Bookmarked
                Subscribed          = $object.__Subscribed
                Subscription        = $object.__Subscription
                CreateUser          = $object.CreateUser |
                    Format-RyverUserObject
                ModifyUser          = $object.ModifyUser |
                    Format-RyverUserObject
                SecurityGroup       = [PSCustomObject] @{
                    PSTypeName   = "PSRyver.$( $object.SecurityGroup.__Metadata.Type )"
                    Metadata     = [PSCustomObject] @{
                        Uri  = $object.SecurityGroup.__Metadata.Uri
                        Type = $object.SecurityGroup.__Metadata.Type
                        ETag = $object.SecurityGroup.__Metadata.ETag
                    }
                    ID           = $object.SecurityGroup.ID
                    CreateDate   = $object.SecurityGroup.CreateDate
                    ModifyDate   = $object.SecurityGroup.ModifyDate
                    CreateSource = $object.SecurityGroup.CreateSource
                    ModifySource = $object.SecurityGroup.ModifySource
                    Code         = $object.SecurityGroup.Code
                    Name         = $object.SecurityGroup.Name
                    Description  = $object.SecurityGroup.Description
                    Type         = $object.SecurityGroup.Type
                    SubType      = $object.SecurityGroup.SubType
                    Descriptor   = $object.SecurityGroup.__Descriptor
                    CreateUser   = $object.SecurityGroup.CreateUser.__Deferred.Uri
                    ModifyUser   = $object.SecurityGroup.ModifyUser.__Deferred.Uri
                    Users        = $object.SecurityGroup.Users.__Deferred.Uri
                }
                AdministratorsGroup = [PSCustomObject] @{
                    PSTypeName   = "PSRyver.$( $object.AdministratorsGroup.__Metadata.Type )"
                    Metadata     = [PSCustomObject] @{
                        Uri  = $object.AdministratorsGroup.__Metadata.Uri
                        Type = $object.AdministratorsGroup.__Metadata.Type
                        ETag = $object.AdministratorsGroup.__Metadata.ETag
                    }
                    ID           = $object.AdministratorsGroup.ID
                    CreateDate   = $object.AdministratorsGroup.CreateDate
                    ModifyDate   = $object.AdministratorsGroup.ModifyDate
                    CreateSource = $object.AdministratorsGroup.CreateSource
                    ModifySource = $object.AdministratorsGroup.ModifySource
                    Code         = $object.AdministratorsGroup.Code
                    Name         = $object.AdministratorsGroup.Name
                    Description  = $object.AdministratorsGroup.Description
                    Type         = $object.AdministratorsGroup.Type
                    SubType      = $object.AdministratorsGroup.SubType
                    Descriptor   = $object.AdministratorsGroup.__Descriptor
                    CreateUser   = $object.AdministratorsGroup.CreateUser.__Deferred.Uri
                    ModifyUser   = $object.AdministratorsGroup.ModifyUser.__Deferred.Uri
                    Users        = $object.AdministratorsGroup.Users.__Deferred.Uri
                }
                ModeratorsGroup     = [PSCustomObject] @{
                    PSTypeName   = "PSRyver.$( $object.ModeratorsGroup.__Metadata.Type )"
                    Metadata     = [PSCustomObject] @{
                        Uri  = $object.ModeratorsGroup.__Metadata.Uri
                        Type = $object.ModeratorsGroup.__Metadata.Type
                        ETag = $object.ModeratorsGroup.__Metadata.ETag
                    }
                    ID           = $object.ModeratorsGroup.ID
                    CreateDate   = $object.ModeratorsGroup.CreateDate
                    ModifyDate   = $object.ModeratorsGroup.ModifyDate
                    CreateSource = $object.ModeratorsGroup.CreateSource
                    ModifySource = $object.ModeratorsGroup.ModifySource
                    Code         = $object.ModeratorsGroup.Code
                    Name         = $object.ModeratorsGroup.Name
                    Description  = $object.ModeratorsGroup.Description
                    Type         = $object.ModeratorsGroup.Type
                    SubType      = $object.ModeratorsGroup.SubType
                    Descriptor   = $object.ModeratorsGroup.__Descriptor
                    CreateUser   = $object.ModeratorsGroup.CreateUser.__Deferred.Uri
                    ModifyUser   = $object.ModeratorsGroup.ModifyUser.__Deferred.Uri
                    Users        = $object.ModeratorsGroup.Users.__Deferred.Uri
                }
                Board               = @{
                    Uri = $object.Board.__Deferred.Uri
                }
                Members             = $object.Members.Results |
                    Where-Object -FilterScript { $null -ne $_ } |
                    ForEach-Object -Process {
                        [PSCustomObject] @{
                            PSTypeName   = "PSRyver.$( $_.__Metadata.Type )"
                            Metadata     = [PSCustomObject] @{
                                Uri  = $_.__Metadata.Uri
                                Type = $_.__Metadata.Type
                                ETag = $_.__Metadata.ETag
                            }
                            ID           = $_.ID
                            CreateDate   = $_.CreateDate
                            ModifyDate   = $_.ModifyDate
                            CreateSource = $_.CreateSource
                            ModifySource = $_.ModifySource
                            Descriptor   = $_.__Descriptor
                            Role         = $_.Role
                            Extras       = [PSCustomObject] @{
                                DisplayName = $_.Extras.DisplayName
                            }
                            Roles        = @(
                                $_.Roles
                            )
                            CreateUser   = $_.CreateUser.__Deferred.Uri
                            ModifyUser   = $_.ModifyUser.__Deferred.Uri
                            WorkRoom     = $_.WorkRoom.__Deferred.Uri
                            Member       = $_.Member.__Deferred.Uri
                        }
                    }
                Acl                 = [PSCustomObject] @{
                    PSTypeName = "PSRyver.$( $object.Acl.__Metadata.Type )"
                    Metadata   = [PSCustomObject] @{
                        Uri  = $object.Acl.__Metadata.Uri
                        Type = $object.Acl.__Metadata.Type
                    }
                    ID         = $object.Acl.ID
                }
                ExternalLinks       = @(
                    $object.ExternalLinks.Results
                )
                Type                = switch ( $object.__Metadata.Type ) {
                    'Entity.Forum' {
                        'Forum'
                    }

                    'Entity.Workroom' {
                        'Team'
                    }

                    default {
                        ''
                    }
                }
            }
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
