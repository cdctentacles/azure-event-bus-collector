Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

function Exec
{
    [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=1)][scriptblock]$cmd,
        [Parameter(Position=1,Mandatory=0)][string]$errorMessage = ("Error executing command {0}" -f $cmd)
    )
    & $cmd
    if ($lastexitcode -ne 0) {
        throw ("Exec: " + $errorMessage)
    }
}

pushd consumer
Exec { dotnet build }
popd

pushd producer
Exec { dotnet build }
popd

pushd tests
Exec { dotnet test }
popd