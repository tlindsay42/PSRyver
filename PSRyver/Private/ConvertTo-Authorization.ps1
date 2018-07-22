function ConvertTo-Authorization {
    <#
    .SYNOPSIS
        Convert credential objects to basic authorization headers.

    .DESCRIPTION
        Convert credential objects to basic authorization headers.

    .INPUTS
        System.Management.Automation.PSCredential

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        ConvertTo-Authorization -Credential ( Get-Credential )
        Converts the credential to a base64 encoded basic authentication authorization
        header value.

    .EXAMPLE
        ( Get-Credential ) | ConvertTo-Authorization
        Converts the credential set via the pipeline to a base64 encoded basic
        authentication authorization header value.

    .EXAMPLE
        ConvertTo-Authorization ( Get-Credential )
        Converts the credential set via positional parameter to a base64 encoded basic
        authentication authorization header value.

    .LINK
        https://tlindsay42.github.io/PSRyver/Private/ConvertTo-Authorization/

    .LINK
        https://github.com/PSRyver/blob/master/PSRyver/Private/ConvertTo-Authorization.ps1
    #>
    param (
        <#
        Specifies the credential to convert to a base64 encoded basic authentication
        authorization header value.
        #>
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
        )]
        [ValidateNotNull()]
        [PSCredential]
        $Credential
    )

    begin {
        $function = $MyInvocation.MyCommand.Name

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize | Out-String )
        )
    }

    process {
        'Basic ' + [System.Convert]::ToBase64String(
            [System.Text.Encoding]::ASCII.GetBytes(
                "$( $Credential.UserName ):$( $Credential.GetNetworkCredential().Password )"
            )
        )
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
