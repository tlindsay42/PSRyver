function ConvertTo-UnixTime {
    <#
    .SYNOPSIS
        Convert datetime objects to UNIX time.

    .DESCRIPTION
        Convert datetime objects to UNIX time.

    .INPUTS
        System.Management.Automation.PSObject

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        ConvertTo-UnixTime -Date ( Get-Date -Date '2018-07-21 10:33:18' )
        Returns '1532187198'.

    .EXAMPLE
        ( Get-Date -Date '2018-07-21 10:33:18' ) | ConvertTo-UnixTime
        Processes the pipeline value and returns '1532187198'.

    .EXAMPLE
        ConvertTo-UnixTime ( Get-Date -Date '2018-07-21 10:33:18' )
        Uses positional parameter and returns '1532187198'.

    .LINK
        https://tlindsay42.github.io/PSRyver/Private/ConvertTo-UnixTime/

    .LINK
        https://github.com/PSRyver/blob/master/PSRyver/Private/ConvertTo-UnixTime.ps1
    #>
    [CmdletBinding()]
    [OutputType( [Int] )]
    param (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
        )]
        [DateTime]
        $Date
    )

    begin {
        $function = $MyInvocation.MyCommand.Name

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )
    }

    process {
        $unixEpochStart = New-Object -TypeName 'DateTime' -ArgumentList 1970, 1, 1, 0, 0, 0, ( [DateTimeKind]::Utc )
        [Int]( $Date.ToUniversalTime() - $unixEpochStart ).TotalSeconds
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
