# Requires elevation

####################################################
# Based on NVIDIA-GPU-Shader-Cache-Cleaner
####################################################

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Restarting script as Administrator..."
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$dxCachePath                = "$env:LOCALAPPDATA\NVIDIA\DXCache"
$glCachePath                = "$env:LOCALAPPDATA\NVIDIA\GLCache"
$steamShaderCachePath       = "C:\Program Files (x86)\Steam\steamapps\shadercache"
$iobitUnlockerPath          = "C:\Program Files (x86)\IObit\IObit Unlocker\IObitUnlocker.exe"
$poe2shaderCachePathDX12    = "$env:APPDATA\Path of Exile 2\ShaderCacheD3D12"

if (-not (Test-Path -Path $iobitUnlockerPath)) {
    Write-Host "IObit Unlocker not found. Please install IObit Unlocker and try again."
    exit
}

if (Test-Path $dxCachePath) {
    Write-Host "Removing DirectX NVIDIA Shader Cache..."
    Remove-Item -Path $dxCachePath -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "DirectX NVIDIA Shader Cache removed."
} else {
    Write-Host "The DirectX NVIDIA Shader Cache folder does not exist."
}

if (Test-Path $glCachePath) {
    Write-Host "Removing OpenGL NVIDIA Shader Cache..."
    Remove-Item -Path $glCachePath -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "OpenGL NVIDIA Shader Cache removed."
} else {
    Write-Host "The OpenGL NVIDIA Shader Cache folder does not exist."
}

if (Test-Path $steamShaderCachePath) {
    Write-Host "Removing Steam Shader Cache..."
    Remove-Item -Path $steamShaderCachePath -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Steam Shader Cache removed."
} else {
    Write-Host "The Steam Shader Cache folder does not exist."
}

if (Test-Path $poe2shaderCachePathDX12) {
    Write-Host "Removing Path of Exile 2 DirectX 12 Shader Cache..."
    Remove-Item -Path $poe2shaderCachePathDX12 -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Path of Exile 2 DirectX 12 Shader Cache removed."
} else {
    Write-Host "The Path of Exile 2 DirectX 12 Shader Cache folder does not exist."
}


Write-Host "Trying to unlock remaining files..."
& "$iobitUnlockerPath" /delete "$dxCachePath" /s
& "$iobitUnlockerPath" /delete "$glCachePath" /s
& "$iobitUnlockerPath" /delete "$steamShaderCachePath" /s
& "$iobitUnlockerPath" /delete "$poe2shaderCachePathDX12" /s

