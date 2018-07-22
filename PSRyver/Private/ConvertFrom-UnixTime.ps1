function ConvertFrom-UnixTime {
    <#
    .SYNOPSIS
        Convert UNIX time to datetime objects.

    .DESCRIPTION
        Convert UNIX time to datetime objects.

    .INPUTS
        System.Int32

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        ConvertFrom-UnixTime -UnixTime 1532186850
        Returns 'Saturday, July 21, 2018 15:27:30'.

    .EXAMPLE
        1532186850 | ConvertFrom-UnixTime
        Processes the pipeline value and returns
        'Saturday, July 21, 2018 15:27:30'.

    .EXAMPLE
        ConvertFrom-UnixTime 1532186850
        Uses positional parameter and returns
        'Saturday, July 21, 2018 15:27:30'.

    .LINK
        https://tlindsay42.github.io/PSRyver/Private/ConvertFrom-UnixTime/

    .LINK
        https://github.com/PSRyver/blob/master/PSRyver/Private/ConvertFrom-UnixTime.ps1

    .LINK
        http://powershell.com/cs/blogs/tips/archive/2012/03/09/converting-unix-time.aspx

    .FUNCTIONALITY
        Ryver
    #>
    [OutputType( [DateTime] )]
    param (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
        )]
        [Int32]
        $UnixTime
    )

    begin {
        $function = $MyInvocation.MyCommand.Name

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )

        $startDate = Get-Date –Date '01/01/1970'
    }

    process {
        $timeSpan = New-Timespan -Seconds $UnixTime
        $startDate + $timeSpan
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
