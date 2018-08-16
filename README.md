# PSRyver

[![Current Version](https://img.shields.io/powershellgallery/v/PSRyver.svg)](https://www.powershellgallery.com/packages/PSRyver)
[![Total Downloads](https://img.shields.io/powershellgallery/dt/PSRyver.svg)](https://www.powershellgallery.com/packages/PSRyver)

[![Build status](https://ci.appveyor.com/api/projects/status/qwuvmd3cc4iodlc0?svg=true)](https://ci.appveyor.com/project/tlindsay42/psryver)

This is a quick and dirty community module to interact with the Ryver API.

Pull requests and other contributions would be welcome!

## Prerequisites

* PowerShell 3 or later
* Valid credentials or an incoming webhook URI from Ryver.
    * [Add an incoming webhook to your organization, grab the URI](https://api.ryver.com/ryvhooks_simple_incoming.html)

## Getting Started

* Installation
    * PowerShell 3 & 4
        * Download the repository
        * Unblock the zip
        * Extract the PSRyver folder to a module path in `$Env:PSModulePath`
            * Example: `"$Env:USERPROFILE\Documents\WindowsPowerShell\Modules\"`
    * PowerShell 5+
        ```powershell
        Install-Module -Name 'PSRyver'
        Import-Module -Name 'PSRyver'
        ```
* List the commands in the module
    ```powershell
    Get-Command -Module 'PSRyver'
    ```
* Get help
    ```powershell
    # Output the full help content in PowerShell.
    Get-Help -Name 'Send-RyverMessage' -Full

    # Open the help content from the documentation site in a new tab on your default browser.
    Get-Help -Name 'Send-RyverMessage' -Online
    ```

## Examples

### Send a Simple Ryver Message

* This example shows a crudely crafted message without any attachments, using parameters from `Send-RyverMessage` to construct the message.
  NOTE: This assumes that an incoming webhook URI was setup at `"https://${yourOrg}.ryver.com/"`
* Send a message to @tlindsay42 in the channel configured for the webhook
    ```powershell
    $splat = @{
        IncomingWebhookUri = 'Some incoming webhook URI from Ryver'
        Message            = 'Hello @tlindsay42, join me in #devnull!'
    }
    Send-RyverMessage @splat
    ```

### Search for a Ryver Message

* Search for all chat messages containing the word PowerShell.
    ```powershell
    Find-RyverMessage -SearchText 'PowerShell'
    ```

* Search for attachments that contain the name PowerShell.
    ```powershell
    Find-RyverAttachment -SearchText 'PowerShell'
    ```

### Store and Retrieve Configs

* To save time and typing, you can save your credentials or incoming webhook URI to a config file (protected via DPAPI on Windows) and a module variable.
* This is used as the default for commands, and is loaded automatically when you import the PowerShell module if stored in the default location: `"~/.psryver.xml"`.

```powershell
# Update the current config in memory.
Set-PSRyverConfig -RestApiBaseUri "https://${yourOrg}.ryver.com/api/1/odata.svc" -Credential ( Get-Credential )

# Read the current config in memory.
Get-PSRyverConfig

# Save the current config to file.
Export-PSRyverConfig

# Read & decrypt the default config file (if authorized).
Read-PSRyverConfig
```

#### Credentials

```powershell
# Update the current config in memory.
Set-PSRyverConfig -IncomingWebhookUri "https://${yourOrg}.ryver.com/application/webhook/${yourWebhookID}"

# Read the current config in memory.
Get-PSRyverConfig
```

## Notes

This project was forked with :heart: from v0.1.0 of [Warren Frame's](https://github.com/RamblingCookieMonster) awesome [PSSlack project](https://github.com/RamblingCookieMonster/PSSlack/tree/c0bf2b67278d5df455ae769d5912aa25d09fcf72).  Thanks Warren!

Currently evaluating .NET Core / Cross-platform functionality.  The following will not work initially:

* Serialization of URIs via `Set-PSRyverConfig`.  Set these values per-session if needed.
* `[System.Drawing.Color]::SomeColor` shortcut.  Use the provided `$Script:PSRyverColorMap` hash to simplify this.
    * Example: `$Script:PSRyverColorMap.Red`

If you want to go beyond interacting with the Ryver API, you might consider [using a bot](http://ramblingcookiemonster.github.io/PoshBot/#references).
