# PowerShell command-line tool for Windows Optimization

param (
    [switch]$DisableServices,
    [switch]$DisableStartupPrograms,
    [switch]$OptimizeSystemSettings,
    [switch]$CreateRestorePoint,
    [switch]$RevertToPreviousState
)

if ($CreateRestorePoint) {
    # Create a system restore point before making any changes
    Checkpoint-Computer -Description "Pre-Optimization Restore Point" -RestorePointType "MODIFY_SETTINGS"
    Write-Host "System restore point created."
}

if ($DisableServices) {
    # Disable unnecessary services
    $servicesToDisable = @(
        "DiagTrack", # Diagnostic Tracking Service
        "dmwappushservice", # dmwappushsvc
        "WMPNetworkSvc", # Windows Media Player Network Sharing Service
        "Fax", # Fax Service
        "XblGameSave", # Xbox Live Game Save
        "XboxNetApiSvc" # Xbox Live Networking Service
    )

    foreach ($service in $servicesToDisable) {
        Set-Service -Name $service -StartupType Disabled
        Stop-Service -Name $service -Force
    }
    Write-Host "Unnecessary services disabled."
}

if ($DisableStartupPrograms) {
    # Disable startup programs
    $startupProgramsToDisable = @(
        "OneDrive", # OneDrive
        "Skype", # Skype
        "MicrosoftEdgeUpdate", # Microsoft Edge Update
        "AdobeARM", # Adobe Reader and Acrobat Manager
        "GoogleUpdate" # Google Update
    )

    foreach ($program in $startupProgramsToDisable) {
        $task = Get-ScheduledTask | Where-Object {$_.TaskName -like "*$program*"}
        if ($task) {
            Disable-ScheduledTask -TaskName $task.TaskName
        }
    }
    Write-Host "Startup programs disabled."
}

if ($OptimizeSystemSettings) {
    # Optimize system settings for performance
    # Adjust visual effects
    $performanceOptions = New-Object -ComObject WScript.Shell
    $performanceOptions.RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\VisualFXSetting", 2, "REG_DWORD")

    # Adjust power settings
    powercfg -change -monitor-timeout-ac 10
    powercfg -change -monitor-timeout-dc 5
    powercfg -change -disk-timeout-ac 20
    powercfg -change -disk-timeout-dc 10
    powercfg -change -standby-timeout-ac 30
    powercfg -change -standby-timeout-dc 15
    powercfg -change -hibernate-timeout-ac 60
    powercfg -change -hibernate-timeout-dc 30

    Write-Host "System settings optimized for performance."
}

if ($RevertToPreviousState) {
    # Revert to the previous state
    Start-Process "rstrui.exe" -ArgumentList "/restore"
    Write-Host "Reverting to the previous state..."
}
