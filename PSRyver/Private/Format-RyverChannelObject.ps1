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
        https://github.com/PSRyver/blob/master/PSRyver/Private/Format-RyverChannelObject.ps1

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

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )
    }

    process {
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
                CreateUser          = [PSCustomObject] @{
                    PSTypeName              = "PSRyver.$( $object.CreateUser.__Metadata.Type )"
                    Metadata                = [PSCustomObject] @{
                        Uri  = $object.CreateUser.__Metadata.Uri
                        Type = $object.CreateUser.__Metadata.Type
                        ETag = $object.CreateUser.__Metadata.ETag
                    }
                    ID                      = $object.CreateUser.ID
                    CreateDate              = $object.CreateUser.CreateDate
                    ModifyDate              = $object.CreateUser.ModifyDate
                    CreateSource            = $object.CreateUser.CreateSource
                    ModifySource            = $object.CreateUser.ModifySource
                    Version                 = $object.CreateUser.Version
                    UserName                = $object.CreateUser.UserName
                    EmailAddress            = $object.CreateUser.EmailAddress
                    PendingEmailAddress     = $object.CreateUser.PendingEmailAddress
                    PendingEmailAddressDate = $object.CreateUser.PendingEmailAddressDate
                    DisplayName             = $object.CreateUser.DisplayName
                    Description             = $object.CreateUser.Description
                    AboutMe                 = $object.CreateUser.AboutMe
                    HasAvatar               = $object.CreateUser.HasAvatar
                    NewUser                 = $object.CreateUser.NewUser
                    InviteDate              = $object.CreateUser.InviteDate
                    InviteAcceptedDate      = $object.CreateUser.InviteAcceptedDate
                    InviteMessage           = $object.CreateUser.InviteMessage
                    Roles                   = $object.CreateUser.Roles
                    Features                = $object.CreateUser.Features
                    IsCreator               = $object.CreateUser.IsCreator
                    Active                  = $object.CreateUser.Active
                    Locked                  = $object.CreateUser.Locked
                    Verified                = $object.CreateUser.Verified
                    JIDLocal                = $object.CreateUser.JIDLocal
                    JID                     = $object.CreateUser.JID
                    Type                    = $object.CreateUser.Type
                    TimeZone                = $object.CreateUser.TimeZone
                    TagDefs                 = $object.CreateUser.TagDefs
                    Descriptor              = $object.CreateUser.__Descriptor
                    Permissions             = $object.CreateUser.__Permissions
                    CreateUser              = $object.CreateUser.CreateUser.__Deferred.Uri
                    ModifyUser              = $object.CreateUser.ModifyUser.__Deferred.Uri
                    Board                   = $object.CreateUser.Board.__Deferred.Uri
                    ExternalLinks           = $object.CreateUser.ExternalLinks.__Deferred.Uri
                    Phones                  = $object.CreateUser.Phones.__Deferred.Uri
                    WorkRooms               = $object.CreateUser.WorkRooms.__Deferred.Uri
                    NotificationEndpoints   = $object.CreateUser.NotificationEndpoints.__Deferred.Uri
                    DefaultPublicReadAcl    = $object.CreateUser.DefaultPublicReadAcl.__Deferred.Uri
                    DefaultPublicWriteAcl   = $object.CreateUser.DefaultPublicWriteAcl.__Deferred.Uri
                    Groups                  = $object.CreateUser.Groups.__Deferred.Uri
                    Tasks                   = $object.CreateUser.Tasks.__Deferred.Uri
                }
                ModifyUser          = [PSCustomObject] @{
                    PSTypeName              = "PSRyver.$( $object.ModifyUser.__Metadata.Type )"
                    Metadata                = [PSCustomObject] @{
                        Uri  = $object.ModifyUser.__Metadata.Uri
                        Type = $object.ModifyUser.__Metadata.Type
                        ETag = $object.ModifyUser.__Metadata.ETag
                    }
                    ID                      = $object.ModifyUser.ID
                    CreateDate              = $object.ModifyUser.CreateDate
                    ModifyDate              = $object.ModifyUser.ModifyDate
                    CreateSource            = $object.ModifyUser.CreateSource
                    ModifySource            = $object.ModifyUser.ModifySource
                    Version                 = $object.ModifyUser.Version
                    UserName                = $object.ModifyUser.UserName
                    EmailAddress            = $object.ModifyUser.EmailAddress
                    PendingEmailAddress     = $object.ModifyUser.PendingEmailAddress
                    PendingEmailAddressDate = $object.ModifyUser.PendingEmailAddressDate
                    DisplayName             = $object.ModifyUser.DisplayName
                    Description             = $object.ModifyUser.Description
                    AboutMe                 = $object.ModifyUser.AboutMe
                    HasAvatar               = $object.ModifyUser.HasAvatar
                    NewUser                 = $object.ModifyUser.NewUser
                    InviteDate              = $object.ModifyUser.InviteDate
                    InviteAcceptedDate      = $object.ModifyUser.InviteAcceptedDate
                    InviteMessage           = $object.ModifyUser.InviteMessage
                    Roles                   = $object.ModifyUser.Roles
                    Features                = $object.ModifyUser.Features
                    IsCreator               = $object.ModifyUser.IsCreator
                    Active                  = $object.ModifyUser.Active
                    Locked                  = $object.ModifyUser.Locked
                    Verified                = $object.ModifyUser.Verified
                    JIDLocal                = $object.ModifyUser.JIDLocal
                    JID                     = $object.ModifyUser.JID
                    Type                    = $object.ModifyUser.Type
                    TimeZone                = $object.ModifyUser.TimeZone
                    TagDefs                 = $object.ModifyUser.TagDefs
                    Descriptor              = $object.ModifyUser.__Descriptor
                    Permissions             = $object.ModifyUser.__Permissions
                    CreateUser              = $object.ModifyUser.CreateUser.__Deferred.Uri
                    ModifyUser              = $object.ModifyUser.ModifyUser.__Deferred.Uri
                    Board                   = $object.ModifyUser.Board.__Deferred.Uri
                    ExternalLinks           = $object.ModifyUser.ExternalLinks.__Deferred.Uri
                    Phones                  = $object.ModifyUser.Phones.__Deferred.Uri
                    WorkRooms               = $object.ModifyUser.WorkRooms.__Deferred.Uri
                    NotificationEndpoints   = $object.ModifyUser.NotificationEndpoints.__Deferred.Uri
                    DefaultPublicReadAcl    = $object.ModifyUser.DefaultPublicReadAcl.__Deferred.Uri
                    DefaultPublicWriteAcl   = $object.ModifyUser.DefaultPublicWriteAcl.__Deferred.Uri
                    Groups                  = $object.ModifyUser.Groups.__Deferred.Uri
                    Tasks                   = $object.ModifyUser.Tasks.__Deferred.Uri
                }
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
            }
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
