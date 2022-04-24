#!/usr/bin/env pwsh
Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

Set-Location "$PSScriptRoot/.."

New-Item build/icons -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null

function x() {
	Write-Host -ForegroundColor Gray " + $($args -join " ")"
	& convert @args
}

$files = @()
foreach ($size in @(16, 32, 128, 256, 512)) {
	x -background none -density 72 -resize $size -units PixelsPerInch "./resources/main-icon.png" "./build/icons/${size}x${size}.png"
	$files += "./build/icons/${size}x${size}.png"
}

x @files -colors 256 "./build/icon.ico"
