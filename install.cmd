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
.\%mcportable-setup%
)
