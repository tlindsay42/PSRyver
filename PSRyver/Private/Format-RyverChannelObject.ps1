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
                ID                  = $object.ID.ToUInt64( $null )
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
                SecurityGroup       = $object.SecurityGroup |
                    Where-Object -FilterScript { $null -ne $_ } |
                    ForEach-Object -Process {
                        if ( $null -ne ( $_ | Select-Object -ExpandProperty '__Deferred' -ErrorAction 'SilentlyContinue' ) ) {
                            [PSCustomObject] @{
                                Deferred = [PSCustomObject] @{
                                    Uri  = $_.__Deferred.Uri
                                }
                            }
                        }
                        else {
                            [PSCustomObject] @{
                                PSTypeName   = "PSRyver.$( $_.__Metadata.Type )"
                                Metadata     = [PSCustomObject] @{
                                    Uri  = $_.__Metadata.Uri
                                    Type = $_.__Metadata.Type
                                    ETag = $_.__Metadata.ETag
                                }
                                ID           = $_.ID.ToUInt64( $null )
                                CreateDate   = $_.CreateDate
                                ModifyDate   = $_.ModifyDate
                                CreateSource = $_.CreateSource
                                ModifySource = $_.ModifySource
                                Code         = $_.Code
                                Name         = $_.Name
                                Description  = $_.Description
                                Type         = $_.Type
                                SubType      = $_.SubType
                                Descriptor   = $_.__Descriptor
                                CreateUser   = $_.CreateUser.__Deferred.Uri
                                ModifyUser   = $_.ModifyUser.__Deferred.Uri
                                Users        = $_.Users.__Deferred.Uri
                            }
                        }
                    }
                AdministratorsGroup = $object.AdministratorsGroup |
                    Where-Object -FilterScript { $null -ne $_ } |
                    ForEach-Object -Process {
                        if ( $null -ne ( $_ | Select-Object -ExpandProperty '__Deferred' -ErrorAction 'SilentlyContinue' ) ) {
                            [PSCustomObject] @{
                                Deferred = [PSCustomObject] @{
                                    Uri  = $_.__Deferred.Uri
                                }
                            }
                        }
                        else {
                            [PSCustomObject] @{
                                PSTypeName   = "PSRyver.$( $_.__Metadata.Type )"
                                Metadata     = [PSCustomObject] @{
                                    Uri  = $_.__Metadata.Uri
                                    Type = $_.__Metadata.Type
                                    ETag = $_.__Metadata.ETag
                                }
                                ID           = $_.ID.ToUInt64( $null )
                                CreateDate   = $_.CreateDate
                                ModifyDate   = $_.ModifyDate
                                CreateSource = $_.CreateSource
                                ModifySource = $_.ModifySource
                                Code         = $_.Code
                                Name         = $_.Name
                                Description  = $_.Description
                                Type         = $_.Type
                                SubType      = $_.SubType
                                Descriptor   = $_.__Descriptor
                                CreateUser   = $_.CreateUser.__Deferred.Uri
                                ModifyUser   = $_.ModifyUser.__Deferred.Uri
                                Users        = $_.Users.__Deferred.Uri
                            }
                        }
                    }
                ModeratorsGroup     = $object.ModeratorsGroup |
                    Where-Object -FilterScript { $null -ne $_ } |
                    ForEach-Object -Process {
                        if ( $null -ne ( $_ | Select-Object -ExpandProperty '__Deferred' -ErrorAction 'SilentlyContinue' ) ) {
                            [PSCustomObject] @{
                                Deferred = [PSCustomObject] @{
                                    Uri = $_.__Deferred.Uri
                                }
                            }
                        }
                        else {
                            [PSCustomObject] @{
                                PSTypeName   = "PSRyver.$( $_.__Metadata.Type )"
                                Metadata     = [PSCustomObject] @{
                                    Uri  = $_.__Metadata.Uri
                                    Type = $_.__Metadata.Type
                                    ETag = $_.__Metadata.ETag
                                }
                                ID           = $_.ID.ToUInt64( $null )
                                CreateDate   = $_.CreateDate
                                ModifyDate   = $_.ModifyDate
                                CreateSource = $_.CreateSource
                                ModifySource = $_.ModifySource
                                Code         = $_.Code
                                Name         = $_.Name
                                Description  = $_.Description
                                Type         = $_.Type
                                SubType      = $_.SubType
                                Descriptor   = $_.__Descriptor
                                CreateUser   = $_.CreateUser.__Deferred.Uri
                                ModifyUser   = $_.ModifyUser.__Deferred.Uri
                                Users        = $_.Users.__Deferred.Uri
                            }
                        }
                    }
                Board               = [PSCustomObject] @{
                    Uri = $object.Board.__Deferred.Uri
                }
                Members             = $object.Members.Results |
                    Where-Object -FilterScript { $null -ne $_ } |
                    ForEach-Object -Process {
                        if ( $null -ne ( $_ | Select-Object -ExpandProperty '__Deferred' -ErrorAction 'SilentlyContinue' ) ) {
                            [PSCustomObject] @{
                                Deferred = [PSCustomObject] @{
                                    Uri  = $_.__Deferred.Uri
                                }
                            }
                        }
                        else {
                            [PSCustomObject] @{
                                PSTypeName   = "PSRyver.$( $_.__Metadata.Type )"
                                Metadata     = [PSCustomObject] @{
                                    Uri  = $_.__Metadata.Uri
                                    Type = $_.__Metadata.Type
                                    ETag = $_.__Metadata.ETag
                                }
                                ID           = $_.ID.ToUInt64( $null )
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
                    }
                Acl                 = $object.Acl |
                    Where-Object -FilterScript { $null -ne $_ } |
                    ForEach-Object -Process {
                        if ( $null -ne ( $_ | Select-Object -ExpandProperty '__Deferred' -ErrorAction 'SilentlyContinue' ) ) {
                            [PSCustomObject] @{
                                Deferred = [PSCustomObject] @{
                                    Uri = $_.__Deferred.Uri
                                }
                            }
                        }
                        else {
                            [PSCustomObject] @{
                                PSTypeName = "PSRyver.$( $_.__Metadata.Type )"
                                Metadata   = [PSCustomObject] @{
                                    Uri  = $_.__Metadata.Uri
                                    Type = $_.__Metadata.Type
                                }
                                ID         = $object.Acl.ID.ToUInt64( $null )
                            }
                        }
                    }
                ExternalLinks       = $object.ExternalLinks.Results |
                    Where-Object -FilterScript { $null -ne $_ } |
                    ForEach-Object -Process {
                        $_
                    }
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
