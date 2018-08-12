function Get-RyverHistory {
    <#
    .SYNOPSIS
        Get history from a Ryver public forum or private team channel.

    .DESCRIPTION
        Get history from a Ryver public forum or private team channel.

    .INPUTS
        System.UInt64

    .INPUTS
        System.Management.Automation.PSCustomObject

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Get-RyverHistory -ID 12345678 -Type 'Team'
        Queries for the chat history of the private team channel with ID 12345678.

    .EXAMPLE
        Get-RyverHistory -ID 12345678 -Type 'Forum' -Credential ( Get-Credential )
        Updates the $Script:PSRyver.Authorization value storing the basic
        authentication authorization header to use for all requests and then queries
        for the chat history of the public forum channel with ID 12345678.

    .EXAMPLE
        12345678 | Get-RyverHistory -Type 'User' -Raw
        Queries for the chat history with the user with ID 12345678 via pipeline value,
        and returns the raw, unformatted output.

    .EXAMPLE
        [PSCustomObject] @{ ID = 12345678; Type = 'Team' } | Get-RyverHistory
        Queries for the chat history with the user with ID 12345678 via pipeline
        parameter names.

    .EXAMPLE
        Get-RyverHistory 12345678 'Forum' $true
        Queries for the chat history of the public forum channel with ID 12345678 via
        positional parameter and returns the raw, unformatted output.

    .LINK
        https://tlindsay42.github.io/PSRyver/Public/Get-RyverHistory/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Get-RyverHistory.ps1

    .FUNCTIONALITY
        Ryver
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Public/Get-RyverHistory/',
        SupportsPaging = $true
    )]
    param (
        <#
        Specifies the ID of the public forum channel, private team channel, or user
        direct message to download the chat history from.
        #>
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [UInt64]
        $ID,

        <#
        Specifies the type of channel to post the message in:
        - Public forum
        - Private team
        - User direct message
        #>
        [Parameter(
            Mandatory = $true,
            Position = 1,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet( 'Forum', 'Team', 'User' )]
        [String]
        $Type,

        # Specifies that objects should not be formatted.
        [Parameter( Position = 2 )]
        [Switch]
        $Raw,

        <#
        Credentials to use for the Ryver API.

        Default value is the value set by Set-PSRyverConfig.
        #>
        [Parameter( Position = 3 )]
        [PSCredential]
        $Credential
    )

    begin {
        $function = $MyInvocation.MyCommand.Name
        Write-Verbose -Message "Beginning: '${function}'."

        #region init
        $return = @()
        $first = $PSCmdlet.PagingParameters.Skip
        $last = $first + $PSCmdlet.PagingParameters.First
        #endregion

        Write-Verbose -Message "First index position: '${first}'."

        if ( $PSBoundParameters.ContainsKey( 'Credential' ) ) {
            $Script:PSRyver.Authorization = ConvertTo-Authorization -Credential $Credential
            Remove-Variable -Name 'Credential'
        }

        Assert-RyverApiConfig

        if ( $PSCmdlet.PagingParameters.First -eq 0 ) {
            Write-Verbose -Message "The 'First' parameter is set to accept zero results- terminating."
            break
        }
    }

    process {
        Write-Verbose -Message (
            "Processing: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize -Wrap | Out-String )
        )

        #region init
        $path = '/'
        $skip = 0
        $count = [UInt64]::MaxValue
        $objects = @()
        #endregion

        switch ( $Type ) {
            'Forum' {
                $path += "forums(${ID})"
            }

            'Team' {
                $path += "workrooms(${ID})"
            }

            'User' {
                $path += "users(${ID})"
            }
        }

        #region Build the URI path
        $path += (
            '/Chat.History()?' +
            "&`$top=$( $Script:PSRyver.MaxPageSize )" +
            "&`$skip=${skip}" +
            '&$orderby=when+asc' +
            '&$inlinecount=allpages'
        )
        #endregion

        $splat = @{
            Method      = 'Get'
            Path        = $path
            ErrorAction = 'Stop'
        }

        while ( $return.Count -lt $last -and $skip -lt $count ) {
            $response = Invoke-RyverRestMethod @splat
            [UInt64] $count = $response.D.__Count

            Write-Verbose -Message "Found '${count}' objects."
            Write-Verbose -Message "Queried for objects '${skip}-$( $skip + $Script:PSRyver.MaxPageSize )'."

            $tempObjects = $response |
                Select-Object -ExpandProperty 'D' |
                Select-Object -ExpandProperty 'Results'

            if ( $Name ) {
                Write-Verbose -Message "Received '$( ( $tempObjects | Measure-Object ).Count )' objects with server-side filtering."

                $tempObjects = $tempObjects |
                    Where-Object -FilterScript {
                    $_.Name -like $Name
                }

                Write-Verbose -Message "Filtered to '$( ( $tempObjects | Measure-Object ).Count )' objects after client-side filtering."
            }

            $objects += $tempObjects

            $skip += $Script:PSRyver.MaxPageSize
            $splat.Path = $path -replace '\$skip=\d+', "`$skip=${skip}"

            $return += $objects
        }

        Write-Verbose -Message "Added '$( ( $objects | Measure-Object ).Count )' objects in this Process cycle."
    }

    end {
        $count = ( $return | Measure-Object ).Count
        if ( $count -gt 0 ) {
            if ( $PSCmdlet.PagingParameters.Skip -ge $count ) {
                Write-Verbose -Message "Insufficient results: '${count}' to satisfy the 'Skip' parameter value: '${first}'."
                $return = $null
            }
            else {
                $last = $first + [Math]::Min( $PSCmdlet.PagingParameters.First, $count - $PSCmdlet.PagingParameters.Skip ) - 1
                Write-Verbose -Message "Last index position: '${last}'."

                if ( $first -le $last ) {
                    $return = $return[$first..$last]

                    if ( $Raw -eq $true ) {
                        $return
                    }
                    else {
                        $return |
                            Format-RyverMessageObject
                    }
                }
                else {
                    $return = $null
                }
            }
        }

        $count = ( $return | Measure-Object ).Count
        Write-Verbose -Message "Returned '${count}' objects."
        if ( $PSCmdlet.PagingParameters.IncludeTotalCount ) {
            $PSCmdlet.PagingParameters.NewTotalCount( $count, 1.0 )
        }

        Write-Verbose -Message "Ending: '${function}'."
    }
}
