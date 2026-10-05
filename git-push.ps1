$repo = "D:\data analyst"

Set-Location $repo

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "       DATA ANALYST - GIT PUSH" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check Git repository
if (-not (Test-Path "$repo\.git")) {
    Write-Host "ERROR: This folder is not a Git repository." -ForegroundColor Red
    Read-Host "Press ENTER to close"
    exit
}

# Check for changes
$status = git status --porcelain

if ($status) {

    Write-Host "Changes found!" -ForegroundColor Green
    Write-Host ""

    git add .

    $date = Get-Date -Format "yyyy-MM-dd HH:mm"
    $message = "Daily update - $date"

    git commit -m $message

    if ($LASTEXITCODE -eq 0) {

        Write-Host ""
        Write-Host "Pushing to GitHub..." -ForegroundColor Yellow

        git push origin main

        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "SUCCESS: Changes pushed to GitHub!" -ForegroundColor Green
        }
        else {
            Write-Host ""
            Write-Host "ERROR: Push failed." -ForegroundColor Red
        }
    }

}
else {

    Write-Host "No changes found." -ForegroundColor Yellow
    Write-Host "Nothing to commit."
}

Write-Host ""
Write-Host "========================================"
Read-Host "Press ENTER to close"
