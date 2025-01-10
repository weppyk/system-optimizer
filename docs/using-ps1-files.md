# Using .ps1 Files

## Instructions on How to Use .ps1 Files

1. Open PowerShell as an administrator:
   - Press `Win + X` and select `Windows PowerShell (Admin)` or `Windows Terminal (Admin)` if you are using Windows 10 or later.
   - Alternatively, you can search for `PowerShell` in the Start menu, right-click on it, and select `Run as administrator`.

2. Navigate to the directory containing the `.ps1` file:
   - Use the `cd` command to change the directory. For example, if your script is located in `C:\Scripts`, type `cd C:\Scripts` and press Enter.

3. Run the `.ps1` file:
   - Type `.\filename.ps1` and press Enter. Replace `filename.ps1` with the name of your script file.

4. Follow any prompts or instructions provided by the script.

## Examples of Running .ps1 Files in PowerShell

### Example 1: Running a Simple Script

```powershell
# Navigate to the directory containing the script
cd C:\Scripts

# Run the script
.\example-script.ps1
```

### Example 2: Running a Script with Parameters

```powershell
# Navigate to the directory containing the script
cd C:\Scripts

# Run the script with parameters
.\example-script.ps1 -Parameter1 Value1 -Parameter2 Value2
```

## Common Issues and Troubleshooting

### Issue 1: Execution Policy Restriction

If you encounter an error message about the execution policy, you may need to change the execution policy to allow running scripts. To do this, run the following command in PowerShell as an administrator:

```powershell
Set-ExecutionPolicy RemoteSigned
```

This command allows you to run scripts that are created locally or downloaded from the internet if they are signed by a trusted publisher.

### Issue 2: Script Not Found

If you receive an error message stating that the script file is not found, ensure that you have navigated to the correct directory and that the file name is correct. Use the `Get-ChildItem` command to list the files in the current directory:

```powershell
Get-ChildItem
```

### Issue 3: Insufficient Permissions

If you encounter permission-related errors, make sure you are running PowerShell as an administrator. Right-click on the PowerShell icon and select `Run as administrator`.

### Issue 4: Missing Modules or Cmdlets

If your script relies on specific modules or cmdlets that are not available on your system, you may need to install them. Use the `Install-Module` command to install the required modules. For example, to install the `Azure` module, run:

```powershell
Install-Module -Name Azure
```

### Issue 5: Syntax Errors

If you encounter syntax errors, review the script for any typos or incorrect syntax. PowerShell provides error messages that can help you identify the issue. Make sure to follow the correct syntax and structure for PowerShell scripts.

## Additional Resources

For more information on using PowerShell and `.ps1` files, refer to the following resources:

- [PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/)
- [PowerShell Gallery](https://www.powershellgallery.com/)
- [PowerShell Script Center](https://gallery.technet.microsoft.com/scriptcenter)
