# PowerShell GUI application for Windows Optimization

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create a form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Windows Optimization"
$form.Size = New-Object System.Drawing.Size(400, 300)
$form.StartPosition = "CenterScreen"

# Create a checkbox for each optimization option
$servicesCheckbox = New-Object System.Windows.Forms.CheckBox
$servicesCheckbox.Text = "Disable Unnecessary Services"
$servicesCheckbox.Location = New-Object System.Drawing.Point(20, 20)
$form.Controls.Add($servicesCheckbox)

$startupProgramsCheckbox = New-Object System.Windows.Forms.CheckBox
$startupProgramsCheckbox.Text = "Disable Startup Programs"
$startupProgramsCheckbox.Location = New-Object System.Drawing.Point(20, 50)
$form.Controls.Add($startupProgramsCheckbox)

$systemSettingsCheckbox = New-Object System.Windows.Forms.CheckBox
$systemSettingsCheckbox.Text = "Adjust System Settings for Performance"
$systemSettingsCheckbox.Location = New-Object System.Drawing.Point(20, 80)
$form.Controls.Add($systemSettingsCheckbox)

# Create a button to create a system restore point
$createRestorePointButton = New-Object System.Windows.Forms.Button
$createRestorePointButton.Text = "Create Restore Point"
$createRestorePointButton.Location = New-Object System.Drawing.Point(20, 110)
$createRestorePointButton.Add_Click({
    Checkpoint-Computer -Description "Pre-Optimization Restore Point" -RestorePointType "MODIFY_SETTINGS"
    [System.Windows.Forms.MessageBox]::Show("System restore point created.")
})
$form.Controls.Add($createRestorePointButton)

# Create a button to apply optimizations
$applyButton = New-Object System.Windows.Forms.Button
$applyButton.Text = "Apply Optimizations"
$applyButton.Location = New-Object System.Drawing.Point(20, 140)
$applyButton.Add_Click({
    if ($servicesCheckbox.Checked) {
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
    }

    if ($startupProgramsCheckbox.Checked) {
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
    }

    if ($systemSettingsCheckbox.Checked) {
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
    }

    [System.Windows.Forms.MessageBox]::Show("Optimizations applied successfully.")
})
$form.Controls.Add($applyButton)

# Create a button to revert to the previous state
$revertButton = New-Object System.Windows.Forms.Button
$revertButton.Text = "Revert to Previous State"
$revertButton.Location = New-Object System.Drawing.Point(20, 170)
$revertButton.Add_Click({
    Start-Process "rstrui.exe" -ArgumentList "/restore"
})
$form.Controls.Add($revertButton)

# Show the form
$form.Add_Shown({$form.Activate()})
[void] $form.ShowDialog()
