$ErrorActionPreference = "Stop"

$projectRoot = $PSScriptRoot
$frontendDirectory = Join-Path $projectRoot "helpdesk-frontend"
$backendDirectory = Join-Path $projectRoot "helpdesk-backend\helpdesk-backend"
$mavenWrapper = Join-Path $backendDirectory "mvnw.cmd"

if (-not (Test-Path (Join-Path $frontendDirectory "package.json"))) {
    throw "Frontend project was not found at '$frontendDirectory'."
}

if (-not (Test-Path $mavenWrapper)) {
    throw "Backend Maven wrapper was not found at '$mavenWrapper'."
}

if (-not (Get-Command npm.cmd -ErrorAction SilentlyContinue)) {
    throw "npm was not found. Install Node.js, then try again."
}

$backendProcess = Start-Process `
    -FilePath $mavenWrapper `
    -ArgumentList "spring-boot:run" `
    -WorkingDirectory $backendDirectory `
    -PassThru

try {
    Start-Process `
        -FilePath "npm.cmd" `
        -ArgumentList "run", "dev" `
        -WorkingDirectory $frontendDirectory | Out-Null
}
catch {
    Stop-Process -Id $backendProcess.Id -ErrorAction SilentlyContinue
    throw
}

Write-Host "Help Desk is starting in separate terminal windows."
Write-Host "Frontend: http://localhost:5173"
Write-Host "Backend API: http://localhost:8080"
Write-Host "Make sure MySQL is running and the helpdesk_db database is available."
