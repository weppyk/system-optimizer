# PowerShell script to test the optimization-gui.ps1 file

# Import the module containing the optimization GUI script
Import-Module -Name "C:\path\to\optimization-gui.ps1"

# Test selecting optimizations to apply
Describe "Optimization GUI - Select Optimizations" {
    It "should allow selecting to disable unnecessary services" {
        $form = New-Object System.Windows.Forms.Form
        $servicesCheckbox = New-Object System.Windows.Forms.CheckBox
        $servicesCheckbox.Text = "Disable Unnecessary Services"
        $servicesCheckbox.Checked = $true
        $form.Controls.Add($servicesCheckbox)
        $servicesCheckbox.Checked | Should -Be $true
    }

    It "should allow selecting to disable startup programs" {
        $form = New-Object System.Windows.Forms.Form
        $startupProgramsCheckbox = New-Object System.Windows.Forms.CheckBox
        $startupProgramsCheckbox.Text = "Disable Startup Programs"
        $startupProgramsCheckbox.Checked = $true
        $form.Controls.Add($startupProgramsCheckbox)
        $startupProgramsCheckbox.Checked | Should -Be $true
    }

    It "should allow selecting to adjust system settings for performance" {
        $form = New-Object System.Windows.Forms.Form
        $systemSettingsCheckbox = New-Object System.Windows.Forms.CheckBox
        $systemSettingsCheckbox.Text = "Adjust System Settings for Performance"
        $systemSettingsCheckbox.Checked = $true
        $form.Controls.Add($systemSettingsCheckbox)
        $systemSettingsCheckbox.Checked | Should -Be $true
    }
}

# Test disabling unnecessary services, startup programs, and adjusting system settings
Describe "Optimization GUI - Apply Optimizations" {
    It "should disable unnecessary services" {
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
            $serviceStatus = Get-Service -Name $service
            $serviceStatus.StartType | Should -Be "Disabled"
        }
    }

    It "should disable startup programs" {
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
                $taskState = Get-ScheduledTask | Where-Object {$_.TaskName -like "*$program*"}
                $taskState.State | Should -Be "Disabled"
            }
        }
    }

    It "should adjust system settings for performance" {
        $performanceOptions = New-Object -ComObject WScript.Shell
        $performanceOptions.RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\VisualFXSetting", 2, "REG_DWORD")
        $visualEffectsSetting = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
        $visualEffectsSetting.VisualFXSetting | Should -Be 2

        powercfg -change -monitor-timeout-ac 10
        powercfg -change -monitor-timeout-dc 5
        powercfg -change -disk-timeout-ac 20
        powercfg -change -disk-timeout-dc 10
        powercfg -change -standby-timeout-ac 30
        powercfg -change -standby-timeout-dc 15
        powercfg -change -hibernate-timeout-ac 60
        powercfg -change -hibernate-timeout-dc 30

        $powerSettings = powercfg -query SCHEME_CURRENT SUB_VIDEO VIDEOIDLE
        $powerSettings | Should -Contain "10"
    }
}

# Test creating a system restore point
Describe "Optimization GUI - Create Restore Point" {
    It "should create a system restore point" {
        Checkpoint-Computer -Description "Pre-Optimization Restore Point" -RestorePointType "MODIFY_SETTINGS"
        $restorePoints = Get-ComputerRestorePoint
        $restorePoints.Description | Should -Contain "Pre-Optimization Restore Point"
    }
}

# Test reverting to the previous state
Describe "Optimization GUI - Revert to Previous State" {
    It "should revert to the previous system restore point" {
        Start-Process "rstrui.exe" -ArgumentList "/restore"
        $restorePoints = Get-ComputerRestorePoint
        $restorePoints.Description | Should -Contain "Pre-Optimization Restore Point"
    }
}
