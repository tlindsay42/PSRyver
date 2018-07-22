function Convert-ColorToHexTriplet {
    <#
    .SYNOPSIS
        Converts a color object to a RGB hex triplet.

    .DESCRIPTION
        Converts a System.Drawing.Color object to a hexadecimal code representing that
        color.

    .INPUTS
        System.Drawing.Color

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Convert-ColorToHexTriplet -Color ( [System.Drawing.Color]::Red )
        Returns '#FF0000'.

    .EXAMPLE
        [System.Drawing.Color]::Azure | Convert-ColorToHexTriplet
        Specifies the color to convert via the pipeline and returns '#F0FFFF'.

    .EXAMPLE
        Convert-ColorToHexTriplet ( [System.Drawing.Color]::BlancheDalmond )
        Specifies the color to convert via positional parameter and returns '#FFEBCD'.

    .LINK
        https://tlindsay42.github.io/PSRyver/Private/Convert-ColorToHexTriplet/

    .LINK
        https://github.com/PSRyver/blob/master/PSRyver/Private/Convert-ColorToHexTriplet.ps1

    .LINK
        https://en.wikipedia.org/wiki/Web_colors#Hex_triplet

    .FUNCTIONALITY
        PowerShell Language
    #>
    [CmdletBinding(
        HelpUri = 'https://tlindsay42.github.io/PSRyver/Private/Convert-ColorToHexTriplet/'
    )]
    [OutputType( [String] )]
    param (
        # Specifies the color to convert.
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
        )]
        [System.Drawing.Color]
        $Color
    )

    begin {
        $function = $MyInvocation.MyCommand.Name

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )
    }

    process {
        '#{0:X2}{1:X2}{2:X2}' -f $Color.R, $Color.G, $Color.B
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
