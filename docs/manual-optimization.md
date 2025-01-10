# Manual Optimization for Windows

## Step-by-Step Instructions

### 1. Disable Unnecessary Services

1. Press `Win + R` to open the Run dialog box.
2. Type `services.msc` and press Enter.
3. In the Services window, scroll through the list and identify services that are not needed.
4. Right-click on the service you want to disable and select `Properties`.
5. In the Properties window, set the `Startup type` to `Disabled`.
6. Click `Apply` and then `OK`.

### 2. Disable Startup Programs

1. Press `Ctrl + Shift + Esc` to open the Task Manager.
2. Go to the `Startup` tab.
3. Identify programs that are not needed at startup.
4. Right-click on the program and select `Disable`.

### 3. Adjust System Settings for Performance

1. Press `Win + R` to open the Run dialog box.
2. Type `sysdm.cpl` and press Enter.
3. In the System Properties window, go to the `Advanced` tab.
4. Under `Performance`, click on `Settings`.
5. In the Performance Options window, select `Adjust for best performance`.
6. Click `Apply` and then `OK`.

## Creating a System Restore Point

1. Press `Win + R` to open the Run dialog box.
2. Type `sysdm.cpl` and press Enter.
3. In the System Properties window, go to the `System Protection` tab.
4. Click on `Create`.
5. Enter a description for the restore point and click `Create`.

## Troubleshooting

### Reverting to a Previous State

1. Press `Win + R` to open the Run dialog box.
2. Type `rstrui.exe` and press Enter.
3. In the System Restore window, click `Next`.
4. Select the restore point you created before making any changes.
5. Click `Next` and then `Finish` to restore your system to the previous state.

## Screenshots and Illustrations

![Disable Services](images/disable-services.png)
![Disable Startup Programs](images/disable-startup-programs.png)
![Adjust System Settings](images/adjust-system-settings.png)
![Create Restore Point](images/create-restore-point.png)
![System Restore](images/system-restore.png)
