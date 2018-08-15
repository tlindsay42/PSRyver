#
# Module manifest for module 'PSGet_PSRyver'
#
# Generated by: Troy Lindsay, Warren F.
#
# Generated on: 2018-08-14
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PSRyver.psm1'

# Version number of this module.
ModuleVersion = '0.0.6'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '97326651-95ea-4b1a-a5a2-c9282b8e900b'

# Author of this module
Author = 'Troy Lindsay, Warren F.'

# Company or vendor of this module
CompanyName = ''

# Copyright statement for this module
Copyright = '©2018 Troy Lindsay. All rights reserved.  ©2016-2018 Warren F. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Community PowerShell module for the Ryver API'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '3.0'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Export-PSRyverConfig', 'Find-RyverAttachment', 'Find-RyverMessage',
               'Find-RyverTask', 'Find-RyverTopic', 'Get-PSRyverConfig',
               'Get-PSRyverConfigPath', 'Get-RyverForum', 'Get-RyverHistory',
               'Get-RyverTeam', 'Get-RyverUser', 'Get-RyverUserMap',
               'Import-PSRyverConfig', 'Initialize-PSRyverConfig',
               'Invoke-RyverRestMethod', 'Read-PSRyverConfig',
               'Remove-PSRyverConfig', 'Remove-RyverMessage', 'Send-RyverMessage',
               'Set-PSRyverConfig', 'Set-PSRyverConfigPath'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = 'PSRyverColorMap'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
FileList = 'PSRyver.psd1', 'PSRyver.psm1', 'Private\Assert-RyverApiConfig.ps1',
               'Private\Convert-ColorToHexTriplet.ps1',
               'Private\ConvertFrom-UnixTime.ps1',
               'Private\ConvertTo-Authorization.ps1',
               'Private\ConvertTo-UnixTime.ps1',
               'Private\Format-RyverAttachmentObject.ps1',
               'Private\Format-RyverChannelObject.ps1',
               'Private\Format-RyverMessageObject.ps1',
               'Private\Format-RyverTaskObject.ps1',
               'Private\Format-RyverTopicObject.ps1',
               'Private\Format-RyverUserObject.ps1',
               'Private\Remove-SensitiveData.ps1', 'Private\Test-IsWindows.ps1',
               'Public\Export-PSRyverConfig.ps1',
               'Public\Find-RyverAttachment.ps1', 'Public\Find-RyverMessage.ps1',
               'Public\Find-RyverTask.ps1', 'Public\Find-RyverTopic.ps1',
               'Public\Get-PSRyverConfig.ps1', 'Public\Get-PSRyverConfigPath.ps1',
               'Public\Get-RyverForum.ps1', 'Public\Get-RyverHistory.ps1',
               'Public\Get-RyverTeam.ps1', 'Public\Get-RyverUser.ps1',
               'Public\Get-RyverUserMap.ps1', 'Public\Import-PSRyverConfig.ps1',
               'Public\Initialize-PSRyverConfig.ps1',
               'Public\Invoke-RyverRestMethod.ps1',
               'Public\Read-PSRyverConfig.ps1', 'Public\Remove-PSRyverConfig.ps1',
               'Public\Remove-RyverMessage.ps1', 'Public\Send-RyverMessage.ps1',
               'Public\Set-PSRyverConfig.ps1', 'Public\Set-PSRyverConfigPath.ps1'

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Ryver','Chat','Message','Messaging','ChatOps','PSEdition_Desktop','PSEdition_Core'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/tlindsay42/PSRyver/blob/master/LICENSE.txt'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/tlindsay42/PSRyver/'

        # A URL to an icon representing this module.
        IconUri = 'https://tlindsay42.github.io/PSRyver/img/ryver-favicon1.png'

        # ReleaseNotes of this module
        ReleaseNotes = 'Add Find-RyverAttachment'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

