function Invoke-RyverRestMethod {
    <#
    .SYNOPSIS
        Send a message to the Ryver API endpoint.

    .DESCRIPTION
        Send a message to the Ryver API endpoint.

        This function is used by other PSRyver functions.
        It's a simple wrapper you could use for calls to the Ryver API

    .INPUTS
        System.Management.Automation.PSCustomObject

    .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

    .EXAMPLE
        Invoke-RyverRestMethod -Path '/forums' -Credential ( Get-Credential )
        Updates the $Script:PSRyver.Authorization value storing the basic
        authentication authorization header to use for all requests and then queries
        for all public forum channels.

    .EXAMPLE
        [PSCustomObject] @{ Path = '/workrooms'; Method = 'Get' } | Invoke-RyverRestMethod
        Queries for all private team channels via the pipeline by property name.

    .EXAMPLE
        Invoke-RyverRestMethod '/forums' 'Get'
        Queries for all public forum channels via positional parameters.

    .LINK
        https://tlindsay42.github.io/PSRyver/Public/Invoke-RyverRestMethod/

    .LINK
        https://github.com/tlindsay42/PSRyver/blob/master/PSRyver/Public/Invoke-RyverRestMethod.ps1

    .FUNCTIONALITY
        Ryver
    #>
    [OutputType( [String] )]
    [CmdletBinding()]
    param (
        # Specifies the Ryver API path to call.
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidatePattern( '^/\S+' )]
        [String]
        $Path,

        <#
        Specifies the method used for the web request.

        The acceptable values for this parameter were gathered from the response
        header: 'Access-Control-Allow-Methods'.
        #>
        [Parameter(
            Position = 1,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet(
            'Get',
            'Put',
            'Post',
            'Delete',
            'Options',
            'Merge',
            'Patch',
            'Head',
            'PropPatch',
            'ACL',
            'PropFind',
            'Copy',
            'Move',
            'MkCol',
            'Report',
            'MkCalendar'
        )]
        [ValidateScript( {
                if ( $PSVersionTable.PSVersion.Major -lt 6 -and $_ -in 'PropPatch', 'ACL', 'PropFind', 'Copy', 'Move', 'MkCol', 'Report', 'MkCalendar' ) {
                    throw "Method: '${_}' is not supported prior to PowerShell version 6."
                }
                else {
                    $true
                }
            }
        )]
        [String]
        $Method = 'Get',

        # Specifies the body of the request.
        [Parameter(
            Position = 2,
            ValueFromPipelineByPropertyName = $true
        )]
        [AllowEmptyString()]
        [String]
        $Body,

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

        Write-Verbose -Message (
            "Beginning: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Remove-SensitiveData | Format-Table -AutoSize -Wrap | Out-String )
        )

        if ( $PSBoundParameters.ContainsKey( 'Credential' ) ) {
            $Script:PSRyver.Authorization = ConvertTo-Authorization -Credential $Credential
            Remove-Variable -Name 'Credential'
        }

        if ( $Script:PSRyver.RestApiBaseUri -notmatch '^https://\w+.ryver.com(?::443)?/api/1/odata.svc$' ) {
            throw "Invalid REST API base URI: '$( $Script:PSRyver.RestApiBaseUri )'.  Please configure this via 'Set-PSRyverConfig -RestApiBaseUri `$uri'."
        }
    }

    process {
        $splat = @{
            Method  = $Method
            Uri     = "$( $Script:PSRyver.RestApiBaseUri )${Path}"
            Headers = @{
                Accept        = 'application/json'
                Authorization = $Script:PSRyver.Authorization
            }
        }

        if ( $Method -eq 'Post' ) {
            $splat.Headers.Add( 'Content-Type', 'application/json' )

            if ( $Body.Length -gt 0 ) {
                $splat.Add( 'Body', $Body )
            }
        }
        elseif ( $Method -in 'PropPatch', 'ACL', 'PropFind', 'Copy', 'Move', 'MkCol', 'Report', 'MkCalendar' ) {
            $splat.Remove( 'Method' )
            $splat.Add( 'CustomMethod', $Method )
        }

        if ( $Script:PSRyver.Proxy ) {
            $splat.Add( 'Proxy', $Script:PSRyver.Proxy )
        }

        Write-Verbose -Message (
            "Calling: 'Invoke-WebRequest' with Parameters: " +
            ( $splat | Remove-SensitiveData | Format-Table -AutoSize -Wrap | Out-String )
        )

        $response = Invoke-WebRequest @splat

        $response |
            Out-String |
            Write-Verbose

        if ( $response.StatusCode -match '^2\d\d$' ) {
            $response.Content |
                ConvertFrom-Json
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
