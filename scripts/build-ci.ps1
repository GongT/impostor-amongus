#!/usr/bin/env pwsh
Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

Set-Location $PSScriptRoot
Set-Location ..
$cwd = $(Get-Location)

function die() {
	Write-Error @args
}

if ((-not $env:CI) -or (-not $env:TARGET_SYSTEM)) {
	die "此脚本仅用于CI"
}

sudo chown root:root "${env:HOME}"

$ctrArgs = @("--rm", "--user=root:root", "--env=EP_PRE_RELEASE=true", "--env=GH_TOKEN=${env:GH_TOKEN}", "--env=CI=${env:CI}", "--env=TARGET_SYSTEM=${env:TARGET_SYSTEM}", "--volume=${env:HOME}:/root", "--volume=${cwd}:/source", "--workdir=/source")
$cmd = @("npm", "run", "electron-builder", "--", "--x64")

function xRun {
	Write-Host -ForegroundColor Gray " + sudo podman run $($args -join ' ')"
	sudo podman run @args
	
	if ($LASTEXITCODE -ne 0) {
		die "podman run 失败"
	}
}

npm run rebuild
if ($LASTEXITCODE -ne 0) {
	die "npm run rebuild 失败"
}

$cmd += @("-p", "always")

if ($env:TARGET_SYSTEM -like "linux") {
	Write-Host -BackgroundColor Green -ForegroundColor Black "building for linux"
	$cmd += @('--linux')
	xRun @ctrArgs electronuserland/builder @cmd
} elseif ($env:TARGET_SYSTEM -like "windows") {
	Write-Host -BackgroundColor Green -ForegroundColor Black "building for windows"
	$cmd += @('--windows')
	xRun @ctrArgs electronuserland/builder:wine @cmd
} else {
	die "不支持这个平台"
}
