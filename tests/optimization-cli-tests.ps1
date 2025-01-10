# PowerShell script to test the optimization-cli.ps1 file

# Import the module containing the optimization CLI script
Import-Module -Name "C:\path\to\optimization-cli.ps1"

# Test running different options to optimize the system
Describe "Optimization CLI - Run Options" {
    It "should disable unnecessary services" {
        .\optimization-cli.ps1 -DisableServices
        $servicesToDisable = @(
            "DiagTrack", # Diagnostic Tracking Service
            "dmwappushservice", # dmwappushsvc
            "WMPNetworkSvc", # Windows Media Player Network Sharing Service
            "Fax", # Fax Service
            "XblGameSave", # Xbox Live Game Save
            "XboxNetApiSvc" # Xbox Live Networking Service
        )

        foreach ($service in $servicesToDisable) {
            $serviceStatus = Get-Service -Name $service
            $serviceStatus.StartType | Should -Be "Disabled"
        }
    }

    It "should disable startup programs" {
        .\optimization-cli.ps1 -DisableStartupPrograms
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
                $taskState = Get-ScheduledTask | Where-Object {$_.TaskName -like "*$program*"}
                $taskState.State | Should -Be "Disabled"
            }
        }
    }

    It "should adjust system settings for performance" {
        .\optimization-cli.ps1 -OptimizeSystemSettings
        $performanceOptions = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
        $performanceOptions.VisualFXSetting | Should -Be 2

        $powerSettings = powercfg -query SCHEME_CURRENT SUB_VIDEO VIDEOIDLE
        $powerSettings | Should -Contain "10"
    }
}

# Test creating a system restore point
Describe "Optimization CLI - Create Restore Point" {
    It "should create a system restore point" {
        .\optimization-cli.ps1 -CreateRestorePoint
        $restorePoints = Get-ComputerRestorePoint
        $restorePoints.Description | Should -Contain "Pre-Optimization Restore Point"
    }
}

# Test reverting to the previous state
Describe "Optimization CLI - Revert to Previous State" {
    It "should revert to the previous system restore point" {
        .\optimization-cli.ps1 -RevertToPreviousState
        $restorePoints = Get-ComputerRestorePoint
        $restorePoints.Description | Should -Contain "Pre-Optimization Restore Point"
    }
}
