# PSRyver

[![Build status](https://ci.appveyor.com/api/projects/status/qwuvmd3cc4iodlc0?svg=true)](https://ci.appveyor.com/project/tlindsay42/psryver)

This is a quick and dirty community module to interact with the Ryver API.

Pull requests and other contributions would be welcome!

## Prerequisites

* PowerShell 3 or later
* Valid credentials or an incoming webhook URI from Ryver.
    * [Add an incoming webhook to your team, grab the URI](https://api.ryver.com/ryvhooks_simple_incoming.html)

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
    Get-Help -Name 'Send-RyverMessage' -Full
    Get-Help -Name 'about_PSRyver'
    ```

## Examples

### Send a Simple Ryver Message

* This example shows a crudely crafted message without any attachments, using parameters from `Send-RyverMessage` to construct the message.
  NOTE: This assumes that an incoming webhook URI was setup at `"https://${yourTeam}.ryver.com/"`
* Send a direct message to @tlindsay42 (not a channel), parsing the text to linkify usernames and channels
    ```powershell
    $splat = @{
        URI     = 'Some incoming webhook URI from Ryver'
        Channel = '@tlindsay42'
        Parse   = 'full'
        Text    = 'Hello @tlindsay42, join me in #devnull!'
    }
    Send-RyverMessage @splat
    ```

![Simple Send-RyverMessage](/docs/img/SimpleMessage.png)

### Search for a Ryver Message

* Search for a message containing PowerShell, sorting results by timestamp.
    ```powershell
    $splat = @{
        URI    = 'Some incoming webhook URI from Ryver'
        Query  = 'PowerShell'
        SortBy = 'timestamp'
    }
    Find-RyverMessage @splat
    ```

![Find Message](/docs/img/FindMessage.png)

* Search for a message containing PowerShell
* Results are sorted by best match by default
* Notice the extra properties and previous/next messages
    ```powershell
    $splat = @{
        Token    = $Token
        Query    = 'PowerShell'
        Property = '*'
    }
    Find-RyverMessage @splat |
        Select-Object -Property '*'
    ```

![Find Message Select All](/docs/img/FindMessageSelect.png)

You could use this simply to search Ryver from the CLI, or in an automated solution that might avoid posting if certain content is already found in Ryver.

### Send a Richer Ryver Message

* This is a simple example illustrating some common options when constructing a message attachment giving you a richer message
    ```powershell
    $splat = @{
      Color      = [System.Drawing.Color]::Red
      Title      = 'The System Is Down'
      TitleLink  = 'https://www.youtube.com/watch?v=TmpRs7xN06Q'
      Text       = 'Please Do The Needful'
      Pretext    = 'Everything is broken'
      AuthorName = 'SCOM Bot'
      AuthorIcon = 'https://tlindsay42.github.io/PSRyver/img/wrench.png'
      Fallback   = 'Your client is bad'
    }
    New-RyverMessageAttachment @splat |
        New-RyverMessage -Channel '@tlindsay42' -IconEmoji ':bomb:' |
        Send-RyverMessage -URI 'Some incoming webhook URI from Ryver'
    ```

![Rich messages](/docs/img/RichMessage.png)

Notice that the title is clickable.  You might link to:

* The alert in question
* A logging solution query
* A dashboard
* Some other contextual link
* Strongbad

### Send Multiple Ryver Attachments

* This example demonstrates that you can chain new attachments together to form a multi-attachment message.

```powershell
$attachment1 = @{
    Color     = $_PSRyverColorMap.Red
    Title     = 'The System Is Down'
    TitleLink = 'https://www.youtube.com/watch?v=TmpRs7xN06Q'
    Text      = 'Everybody panic!'
    Pretext   = 'Everything is broken'
    Fallback  = 'Your client is bad'
}
$attachment2 = @{
    Color     = [System.Drawing.Color]::Orange
    Title     = 'The Other System Is Down'
    TitleLink = 'https://www.youtube.com/watch?v=TmpRs7xN06Q'
    Text      = 'Please Do The Needful'
    Fallback  = 'Your client is bad'
}
New-RyverMessageAttachment @attachment1 |
    New-RyverMessageAttachment @attachment2 |
    New-RyverMessage -Channel '@tlindsay42' -IconEmoji ':bomb:' -AsUser -Username 'SCOM Bot' |
    Send-RyverMessage -URI 'Some incoming webhook URI from Ryver'
```

![Multiple Attachments](/docs/img/MultiAttachments.png)

Notice that we can chain multiple `New-RyverMessageAttachment`s together.

### Send a Table of Key Value Pairs

* This example illustrates a pattern where you might want to send output from a script; you might include errors, successful items, or other output.
* Pretend we're in a script, and caught an exception of some sort
    ```powershell
    $fail = [PSCustomObject] @{
        SAMAccountName = 'bob'
        Operation      = 'Remove privileges'
        Status         = "An error message"
        Timestamp      = ( Get-Date ).ToString()
    }

    # Create an array from the properties in our fail object
    $fields = @()
    foreach( $property in $fail.PSObject.Properties.Name)
    {
        $fields += @{
            Title = $property
            Value = $fail.$property
            Short = $true
        }
    }

    # Construct and send the message!
    $splat = @{
        Color    = [System.Drawing.Color]::Orange
        Title    = 'Failed to process account'
        Fields   = $Fields
        Fallback = 'Your client is bad'
    }
    New-RyverMessageAttachment @splat |
        New-RyverMessage -Channel 'devnull' |
        Send-RyverMessage -URI 'Some incoming webhook URI from Ryver'
    ```

* We build up a pretend error object, and send each property to a `fields` array
* Creates an attachment with the fields from our error
* Creates a message from that attachment and send it with an incoming webhook URI

![Fields](/docs/img/Fields.png)

### Store and Retrieve Configs

* To save time and typing, you can save your credentials or incoming webhook URI to a config file (protected via DPAPI) and a module variable.
* This is used as the default for commands, and is reloaded if you open a new PowerShell session.

#### Incoming Webhook URI

```powershell
Set-PSRyverConfig -URI 'SomeRyverUri'

# Read the current cofig
Get-PSRyverConfig
```

#### Credentials

```powershell
Set-PSRyverConfig -Credential ( Get-Credential )

# Read the current cofig
Get-PSRyverConfig
```

## Notes

This project was ported with :heart: from v0.1.0 of [Warren Frame's](https://github.com/RamblingCookieMonster) awesome [PSSlack project](https://github.com/RamblingCookieMonster/PSSlack/tree/c0bf2b67278d5df455ae769d5912aa25d09fcf72).  Thanks Warren!

Currently evaluating .NET Core / Cross-platform functionality.  The following will not work initially:

* Serialization of URIs via `Set-PSRyverConfig`.  Set these values per-session if needed.
* `[System.Drawing.Color]::SomeColor` shortcut.  Use the provided `$_PSRyverColorMap` hash to simplify this.
    * Example: `$_PSRyverColorMap.Red`

If you want to go beyond interacting with the Ryver API, you might consider [using a bot](http://ramblingcookiemonster.github.io/PoshBot/#references).
