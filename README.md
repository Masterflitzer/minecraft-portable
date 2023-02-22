# Minecraft Portable

## Windows

- Download the script and save it (e.g. on an usb drive: `X:/minecraft/minecraft-portable.ps1`)

```pwsh
irm https://github.com/masterflitzer/minecraft-portable/raw/main/minecraft-portable.ps1 -o X:/minecraft/minecraft-portable.ps1
```

- Run the powershell script `minecraft-portable.ps1` (right-click and **Run with PowerShell**)

If your ExecutionPolicy doesn't allow the script to run, execute these commands in PowerShell and try again:

```pwsh
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Unblock-File "X:/minecraft/minecraft-portable.ps1"
```
