@echo off
cd %~dp0
set mcportable-setup="error - not found"
if exist ".\Minecraft.exe" (
set mcportable-setup=Minecraft.exe
)
if exist ".\MinecraftLauncher.exe" (
set mcportable-setup=MinecraftLauncher.exe
)
if %errorlevel% neq 0 (
echo Ein Fehler ist aufgetreten!
pause
exit
)
if %mcportable-setup%=="error - not found" (
echo.
echo.
echo.
echo ################################################################
echo.
echo      MinecraftLauncher.exe or Minecraft.exe was not found!
echo.
echo ################################################################
echo.
echo.
echo.
pause
) else (
if not exist "%tmp%\.minecraft" mkdir "%tmp%\.minecraft"
if not exist ".\.minecraft" mkdir ".\.minecraft"
robocopy ".\.minecraft" "%tmp%\.minecraft" -mir -mt
".\%mcportable-setup%" --workDir "%tmp%\.minecraft" --tmpDir "%tmp%" --lockDir ".\.minecraft"
robocopy "%tmp%\.minecraft" ".\.minecraft" -mir -mt
)
