Set-StrictMode -Version 3
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

$myHome = [Environment]::GetFolderPath("UserProfile")
$url = "https://launcher.mojang.com/download/Minecraft.exe"

function EliminateMultipleSlash ([string]$s) {
    return [Regex]::Replace($s, "//+", "/")
}

function NormalizePath ([string]$s) {
    return EliminateMultipleSlash $s.Replace('~', $myHome).Replace('\', '/')
}

Set-Location $PSScriptRoot

$dir = NormalizePath $([System.IO.Path]::Combine($PSScriptRoot, ".minecraft"))
$launcher = NormalizePath $([System.IO.Path]::Combine($PSScriptRoot, "minecraft.exe"))
$tmp = NormalizePath $([System.IO.Path]::Combine($env:TMP, ".minecraft"))

Write-Output ""

if (!(Test-Path -PathType Leaf $launcher)) {
    Write-Output "Downloading Minecraft launcher..."
    Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $launcher
}

if (!(Test-Path -PathType Container $dir)) {
    New-Item -ItemType Directory $dir -Force > $null
}

if (Test-Path -PathType Container $tmp) { 
    Write-Output "Cleaning up..."
    Remove-Item -Recurse $tmp -Force
} else {
    New-Item -ItemType Directory $tmp -Force > $null
}

Write-Output "Copying Minecraft files..."
Copy-Item -Recurse -Container "$dir/*" $tmp -Force

Write-Output "Launching Minecraft..."
Start-Process -Wait -FilePath $launcher -ArgumentList "--workDir `"$tmp`" --lockDir `"$tmp`""

Write-Output "Saving Minecraft files..."
Copy-Item -Recurse -Container "$tmp/*" $dir -Force

Write-Output "Done!`n"
Write-Output "Press any key to continue..."
[System.Console]::ReadKey($true) > $null
