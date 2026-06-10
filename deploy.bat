@echo off
REM Salesforce Deploy Helper Script
REM This script provides a simple way to deploy to Salesforce org

setlocal enabledelayedexpansion

if "%1"=="" (
    echo Usage: deploy.bat [file^|project]
    echo.
    echo Examples:
    echo   deploy.bat file          - Deploy current file to myOrg
    echo   deploy.bat project       - Deploy entire force-app to myOrg
    exit /b 1
)

if "%1"=="file" (
    echo Deploying file to myOrg...
    sf project deploy start --source-dir "!CD!" --target-org myOrg --wait 10
) else if "%1"=="project" (
    echo Deploying force-app to myOrg...
    cd /d "%~dp0"
    sf project deploy start --source-dir force-app --target-org myOrg --wait 10
) else (
    echo Unknown command: %1
    exit /b 1
)
