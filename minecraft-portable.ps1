$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

function NormalizePath ([string]$path) { return $path.Replace('\', '/').ToLower() }

Set-Location $PSScriptRoot
$_dir = NormalizePath([System.IO.Path]::Combine($PSScriptRoot, ".minecraft"))
$_launcher = NormalizePath([System.IO.Path]::Combine($PSScriptRoot, "minecraft.exe"))
$_tmp = NormalizePath([System.IO.Path]::Combine($env:TMP, ".minecraft"))
$_url = "https://launcher.mojang.com/download/Minecraft.exe"

Write-Host
if (!(Test-Path "$_launcher")) {
    Write-Host "Downloading minecraft launcher..."
    Invoke-WebRequest -Uri "$_url" -OutFile "./minecraft.exe"
}

if (!(Test-Path "$_dir")) { New-Item -Force -ItemType Directory "$_dir" | Out-Null }
if (Test-Path "$_tmp") { 
    Write-Host "Cleaning up..."
    Remove-Item -Force -Recurse "$_tmp/*"
}
else { New-Item -Force -ItemType Directory "$_tmp" | Out-Null }

Write-Host "Copying minecraft files..."
Copy-Item -Force -Recurse -Container "$_dir/*" "$_tmp"

Write-Host "Launching minecraft..."
Start-Process -Wait -FilePath "$_launcher" -ArgumentList "--workDir `"$_tmp`" --lockDir `"$_tmp`""

Write-Host "Saving minecraft files..."
Copy-Item -Force -Recurse -Container "$_tmp/*" "$_dir"

Write-Host "Done!`n"
Write-Host -NoNewline "Press any key to continue..."
[System.Console]::ReadKey($true) | Out-Null
