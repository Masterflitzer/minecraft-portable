@echo off
cd %~dp0
if not exist "%tmp%\.minecraft" mkdir "%tmp%\.minecraft"
if not exist ".\.minecraft" mkdir ".\.minecraft"
robocopy ".\.minecraft" "%tmp%\.minecraft" -mir -mt
".\MinecraftLauncher.exe" --workDir "%tmp%\.minecraft" --tmpDir "%tmp%" --lockDir ".\.minecraft"
robocopy "%tmp%\.minecraft" ".\.minecraft" -mir -mt
