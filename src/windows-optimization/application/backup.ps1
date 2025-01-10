# PowerShell script to create a system restore point

# Create a system restore point
Checkpoint-Computer -Description "Pre-Optimization Restore Point" -RestorePointType "MODIFY_SETTINGS"

Write-Host "System restore point created successfully."
