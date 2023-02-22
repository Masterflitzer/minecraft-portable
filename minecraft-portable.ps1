Set-StrictMode -Version 3
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

if ([System.Environment]::OSVersion.Platform -ne "Win32NT") {
    throw "This script only supports Windows!"
}

$homeDir = [System.Environment]::GetFolderPath("UserProfile")
$url = "https://launcher.mojang.com/download/Minecraft.exe"

function EliminateMultipleSlash {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [string] $s
    )
    return [regex]::Replace($s, "//+", "/")
}

function NormalizePath {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [string] $s
    )
    return $s.Replace('~', $homeDir).Replace('\', '/') | EliminateMultipleSlash
}

Set-Location $PSScriptRoot

$dir = [System.IO.Path]::Combine($PSScriptRoot, ".minecraft") | NormalizePath
$launcher = [System.IO.Path]::Combine($PSScriptRoot, "minecraft.exe") | NormalizePath
$tmp = [System.IO.Path]::Combine($env:TMP, ".minecraft") | NormalizePath

Write-Output ""

if (!(Test-Path $launcher)) {
    Write-Output "Downloading Minecraft launcher..."
    Invoke-RestMethod -OutFile $launcher $url
}

if (!(Test-Path $dir)) {
    New-Item -ItemType Directory $dir -Force > $null
}

if (Test-Path $tmp) { 
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
