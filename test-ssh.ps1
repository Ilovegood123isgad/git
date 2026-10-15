<#
GitHub SSH auth self-check.
Usage: powershell -ExecutionPolicy Bypass -File E:\git\test-ssh.ps1
#>

$ErrorActionPreference = 'Stop'

Write-Host '== GitHub SSH Auth Self-Check ==' -ForegroundColor Cyan
Write-Host ('Time: {0}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
Write-Host ''

Write-Host '[1] Local key fingerprint:'
$fp = & ssh-keygen -l -f "$env:USERPROFILE\.ssh\id_ed25519.pub" 2>&1
foreach ($line in $fp) { Write-Host "    $line" }
Write-Host ''

Write-Host '[2] ssh -T git@github.com:'
$out = & ssh -T -o ConnectTimeout=8 -o BatchMode=yes git@github.com 2>&1
foreach ($line in $out) { Write-Host "    $line" }
Write-Host ''

if ($out -match 'successfully authenticated') {
    Write-Host 'PASS - SSH auth works. Switch remote with:' -ForegroundColor Green
    Write-Host '  git remote set-url origin git@github.com:Ilovegood123isgad/git.git' -ForegroundColor Green
} else {
    Write-Host 'FAIL - still denied. Check https://github.com/settings/keys for Last used timestamp.' -ForegroundColor Yellow
    Write-Host 'Tip: if Last used just updated locally, close this terminal and retry.' -ForegroundColor Yellow
}
