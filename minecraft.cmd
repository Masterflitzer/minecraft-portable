@echo off
if not exist "%tmp%\.minecraft" mkdir "%tmp%\.minecraft"
robocopy ".\.minecraft" "%tmp%\.minecraft" -mir -mt
pause
".\MinecraftLauncher.exe" --workDir "%tmp%\.minecraft" --tmpDir "%tmp%" --lockDir ".\.minecraft"
pause
if not exist ".\.minecraft" mkdir ".\.minecraft"
robocopy "%tmp%\.minecraft" ".\.minecraft" -mir -mt
