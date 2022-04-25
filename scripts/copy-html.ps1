#!/usr/bin/env pwsh
Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

Get-ChildItem src | Copy-Item -Destination lib -Recurse -filter *.html
