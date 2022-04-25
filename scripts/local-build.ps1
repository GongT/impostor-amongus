#!/usr/bin/env pwsh
Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

Set-Location $PSScriptRoot/..

# TO INSTALL: Install-Module -Name Set-PsEnv
Import-Module Set-PsEnv -Verbose

$env:TARGET_SYSTEM = "windows"
$env:CI = "local"
$env:HOME = $env:SYSTEM_COMMON_CACHE
$env:PATH += ":$(Get-Location)/node_modules/.bin"
Set-PsEnv

Write-Output "GH_TOKEN=${env:GH_TOKEN}"
. scripts/build-publish.ps1
