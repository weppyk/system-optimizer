# PowerShell script to test the optimization-script.ps1 file

# Import the module containing the optimization script
Import-Module -Name "C:\path\to\optimization-script.ps1"

# Test disabling unnecessary services and features
Describe "Optimization Script - Disable Unnecessary Services" {
    It "should disable the Diagnostic Tracking Service" {
        $service = Get-Service -Name "DiagTrack"
        $service.StartType | Should -Be "Disabled"
    }

    It "should disable the dmwappushservice" {
        $service = Get-Service -Name "dmwappushservice"
        $service.StartType | Should -Be "Disabled"
    }

    It "should disable the Windows Media Player Network Sharing Service" {
        $service = Get-Service -Name "WMPNetworkSvc"
        $service.StartType | Should -Be "Disabled"
    }

    It "should disable the Fax Service" {
        $service = Get-Service -Name "Fax"
        $service.StartType | Should -Be "Disabled"
    }

    It "should disable the Xbox Live Game Save" {
        $service = Get-Service -Name "XblGameSave"
        $service.StartType | Should -Be "Disabled"
    }

    It "should disable the Xbox Live Networking Service" {
        $service = Get-Service -Name "XboxNetApiSvc"
        $service.StartType | Should -Be "Disabled"
    }
}

# Test disabling startup programs
Describe "Optimization Script - Disable Startup Programs" {
    It "should disable OneDrive" {
        $task = Get-ScheduledTask | Where-Object {$_.TaskName -like "*OneDrive*"}
        $task.State | Should -Be "Disabled"
    }

    It "should disable Skype" {
        $task = Get-ScheduledTask | Where-Object {$_.TaskName -like "*Skype*"}
        $task.State | Should -Be "Disabled"
    }

    It "should disable Microsoft Edge Update" {
        $task = Get-ScheduledTask | Where-Object {$_.TaskName -like "*MicrosoftEdgeUpdate*"}
        $task.State | Should -Be "Disabled"
    }

    It "should disable Adobe Reader and Acrobat Manager" {
        $task = Get-ScheduledTask | Where-Object {$_.TaskName -like "*AdobeARM*"}
        $task.State | Should -Be "Disabled"
    }

    It "should disable Google Update" {
        $task = Get-ScheduledTask | Where-Object {$_.TaskName -like "*GoogleUpdate*"}
        $task.State | Should -Be "Disabled"
    }
}

# Test optimizing system settings for performance
Describe "Optimization Script - Optimize System Settings" {
    It "should adjust visual effects for best performance" {
        $performanceOptions = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
        $performanceOptions.VisualFXSetting | Should -Be 2
    }

    It "should adjust power settings for performance" {
        $powerSettings = powercfg -query SCHEME_CURRENT SUB_VIDEO VIDEOIDLE
        $powerSettings | Should -Contain "10"
    }
}

# Test creating a system restore point
Describe "Optimization Script - Create System Restore Point" {
    It "should create a system restore point" {
        $restorePoints = Get-ComputerRestorePoint
        $restorePoints.Description | Should -Contain "Pre-Optimization Restore Point"
    }
}

# Test reverting the backup
Describe "Optimization Script - Revert Backup" {
    It "should revert to the previous system restore point" {
        Start-Process "rstrui.exe" -ArgumentList "/restore"
        $restorePoints = Get-ComputerRestorePoint
        $restorePoints.Description | Should -Contain "Pre-Optimization Restore Point"
    }
}
