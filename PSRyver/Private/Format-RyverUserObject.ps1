function Format-RyverUserObject {
    <#
    .SYNOPSIS
        Parse user objects.

    .DESCRIPTION
        Parse user objects.

    .INPUTS
        System.Management.Automation.PSCustomObject[]

    .INPUTS
        System.Management.Automation.PSCustomObject

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Format-RyverUserObject -InputObject $objects
        Parses user objects.

    .EXAMPLE
        $objects | Format-RyverUserObject
        Parses user objects via the pipeline.

    .EXAMPLE
        Format-RyverChannelObject $objects
        Parses user objects via positional parameter.

    .LINK
        https://tlindsay42.github.io/PSRyver/Private/Format-RyverUserObject/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Private/Format-RyverUserObject.ps1

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Private/Format-RyverUserObject/'
    )]
    [OutputType( [PSCustomObject[]] )]
    [OutputType( [PSCustomObject] )]
    param (
        # The user objects to parse.
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
            $IsDetailedObject = $null -ne (
                $object |
                    Select-Object -ExpandProperty 'CreateDate' -ErrorAction 'SilentlyContinue'
            )

            $IsBasicObject = $null -ne (
                $object |
                    Select-Object -ExpandProperty 'DisplayName' -ErrorAction 'SilentlyContinue'
            )

            $IsSimpleObject = $null -ne (
                $object |
                    Select-Object -ExpandProperty '__Deferred' -ErrorAction 'SilentlyContinue' |
                    Select-Object -ExpandProperty 'Uri' -ErrorAction 'SilentlyContinue'
            )

            if ( $IsDetailedObject -eq $true ) {
                [PSCustomObject] @{
                    PSTypeName              = "PSRyver.$( $object.__Metadata.Type )"
                    Metadata                = [PSCustomObject] @{
                        Uri  = $object.__Metadata.Uri
                        Type = $object.__Metadata.Type
                        ETag = $object.__Metadata.ETag
                    }
                    ID                      = $object.ID.ToUInt64( $null )
                    CreateDate              = $object.CreateDate
                    ModifyDate              = $object.ModifyDate
                    CreateSource            = $object.CreateSource
                    ModifySource            = $object.ModifySource
                    Version                 = $object.Version
                    UserName                = $object.UserName
                    EmailAddress            = $object.EmailAddress
                    PendingEmailAddress     = $object.PendingEmailAddress
                    PendingEmailAddressDate = $object.PendingEmailAddressDate
                    DisplayName             = $object.DisplayName
                    Description             = $object.Description
                    AboutMe                 = $object.AboutMe
                    HasAvatar               = $object.HasAvatar
                    NewUser                 = $object.NewUser
                    InviteDate              = $object.InviteDate
                    InviteAcceptedDate      = $object.InviteAcceptedDate
                    InviteMessage           = $object.InviteMessage
                    Roles                   = $object.Roles
                    Features                = $object.Features
                    IsCreator               = $object.IsCreator
                    Active                  = $object.Active
                    Locked                  = $object.Locked
                    Verified                = $object.Verified
                    JIDLocal                = $object.JIDLocal
                    JID                     = $object.JID
                    Type                    = 'User'
                    RyverType               = $object.Type
                    TimeZone                = $object.TimeZone
                    TagDefs                 = $object.TagDefs
                    Descriptor              = $object.__Descriptor
                    Permissions             = $object.__Permissions
                    CreateUser              = $object.CreateUser
                    ModifyUser              = $object.ModifyUser
                    Board                   = $object.Board
                    ExternalLinks           = $object.ExternalLinks
                    Phones                  = $object.Phones
                    WorkRooms               = $object.WorkRooms
                    NotificationEndpoints   = $object.NotificationEndpoints
                    DefaultPublicReadAcl    = $object.DefaultPublicReadAcl
                    DefaultPublicWriteAcl   = $object.DefaultPublicWriteAcl
                    Groups                  = $object.Groups
                    Tasks                   = $object.Tasks
                }
            }
            elseif ( $IsBasicObject -eq $true ) {
                [PSCustomObject] @{
                    PSTypeName  = "PSRyver.$( $object.__Metadata.Type )"
                    Metadata    = [PSCustomObject] @{
                        Type = $object.__Metadata.Type
                    }
                    ID          = $object.ID.ToUInt64( $null )
                    Descriptor  = $object.__Descriptor
                    DisplayName = $object.DisplayName
                    UserName    = $object.UserName
                    Type        = 'User'
                }
            }
            elseif ( $IsSimpleObject -eq $true ) {
                [PSCustomObject] @{
                    Uri = $object.__Deferred.Uri
                }
            }
            else {
                Write-Error -Message "Invalid object: '${object}'."
            }
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
