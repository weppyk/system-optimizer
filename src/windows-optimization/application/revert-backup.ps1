# PowerShell script to revert to the previous system restore point

# Revert to the previous system restore point
Start-Process "rstrui.exe" -ArgumentList "/restore"

Write-Host "Reverting to the previous system restore point..."
