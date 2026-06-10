#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Salesforce Deploy Helper - Easy deployment to myOrg from the command line

.DESCRIPTION
    This script provides simple commands to deploy Salesforce metadata to your myOrg

.PARAMETER Action
    The deployment action: 'file', 'project', 'retrieve', or 'status'

.PARAMETER FilePath
    The path to the file to deploy (for 'file' action)

.PARAMETER JobId
    The deployment job ID (for 'status' action)

.EXAMPLE
    .\deploy-sf.ps1 -Action project
    Deploys the entire force-app directory to myOrg

.EXAMPLE
    .\deploy-sf.ps1 -Action file -FilePath force-app/main/default/classes/MyClass.cls
    Deploys a specific file to myOrg

.EXAMPLE
    .\deploy-sf.ps1 -Action retrieve
    Retrieves the latest metadata from myOrg
#>

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('file', 'project', 'retrieve', 'status')]
    [string]$Action,
    
    [Parameter(Mandatory=$false)]
    [string]$FilePath,
    
    [Parameter(Mandatory=$false)]
    [string]$JobId
)

$ErrorActionPreference = "Stop"
$TargetOrg = "myOrg"

function Deploy-File {
    param([string]$Path)
    
    if (-not (Test-Path $Path)) {
        Write-Error "File not found: $Path"
        return
    }
    
    Write-Host "🚀 Deploying file to $TargetOrg..." -ForegroundColor Green
    Write-Host "   File: $Path" -ForegroundColor Cyan
    
    sf project deploy start --source-dir $Path --target-org $TargetOrg --wait 10
}

function Deploy-Project {
    Write-Host "🚀 Deploying entire project to $TargetOrg..." -ForegroundColor Green
    Write-Host "   Source: force-app" -ForegroundColor Cyan
    
    sf project deploy start --source-dir force-app --target-org $TargetOrg --wait 10
}

function Retrieve-From-Org {
    Write-Host "📥 Retrieving metadata from $TargetOrg..." -ForegroundColor Green
    
    sf project retrieve start --source-dir force-app --target-org $TargetOrg
}

function Show-DeploymentStatus {
    param([string]$Id)
    
    if ([string]::IsNullOrEmpty($Id)) {
        Write-Error "Job ID is required for status check"
        return
    }
    
    Write-Host "📊 Checking deployment status..." -ForegroundColor Green
    Write-Host "   Job ID: $Id" -ForegroundColor Cyan
    
    sf project deploy report --job-id $Id --target-org $TargetOrg
}

# Main execution
switch ($Action) {
    'file' {
        if ([string]::IsNullOrEmpty($FilePath)) {
            Write-Error "FilePath is required for file deployment"
            exit 1
        }
        Deploy-File -Path $FilePath
    }
    'project' {
        Deploy-Project
    }
    'retrieve' {
        Retrieve-From-Org
    }
    'status' {
        Show-DeploymentStatus -Id $JobId
    }
}

Write-Host "`n✅ Operation completed!" -ForegroundColor Green
