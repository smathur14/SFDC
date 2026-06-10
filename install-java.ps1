# Java Installation Script for Salesforce Apex Development
# This script downloads and installs Java 17 LTS (required for Apex Language Server)
# Run as Administrator

param(
    [string]$JavaVersion = "17.0.11",
    [string]$InstallPath = "C:\Program Files\Java"
)

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -match 'S-1-5-32-544'
if (-not $isAdmin) {
    Write-Host "❌ This script must be run as Administrator!"
    Write-Host "Please right-click PowerShell and select 'Run as Administrator'"
    exit 1
}

Write-Host "🚀 Starting Java Installation for Apex Development..."
Write-Host "==============================================="

# Step 1: Check if Java is already installed
Write-Host "`n1️⃣  Checking for existing Java installation..."
$existingJava = Get-Command java -ErrorAction SilentlyContinue
if ($existingJava) {
    Write-Host "✅ Java is already installed at: $($existingJava.Source)"
    java -version
    exit 0
}

# Step 2: Check if Chocolatey is installed
Write-Host "`n2️⃣  Checking for Chocolatey package manager..."
$choco = Get-Command choco -ErrorAction SilentlyContinue

if ($choco) {
    Write-Host "✅ Chocolatey found! Installing Java via Chocolatey..."
    choco install temurin17 -y
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n✅ Java installed successfully!"
        refreshenv
        java -version
        exit 0
    }
}

# Step 3: Fallback - Download and install MSI from Adoptium
Write-Host "`n3️⃣  Downloading Java 17 from Adoptium (adoptium.net)..."

$downloadUrl = "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.11+9/OpenJDK17U-jdk_x64_windows_hotspot_17.0.11_9.msi"
$msiPath = "$env:TEMP\java-installer.msi"

try {
    Write-Host "Downloading from: $downloadUrl"
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $downloadUrl -OutFile $msiPath -ErrorAction Stop
    Write-Host "✅ Download completed!"
    
    # Step 4: Install MSI
    Write-Host "`n4️⃣  Installing Java..."
    $msiArgs = @(
        "/i"
        $msiPath
        "/qn"
        "/norestart"
        'INSTALLLEVEL=3'
        "INSTALLDIR=$InstallPath\jdk-17"
    )
    
    $process = Start-Process -FilePath "msiexec.exe" -ArgumentList $msiArgs -NoNewWindow -Wait -PassThru
    
    if ($process.ExitCode -eq 0) {
        Write-Host "✅ Java installation completed successfully!"
        
        # Step 5: Verify installation
        Write-Host "`n5️⃣  Verifying installation..."
        $javaExe = "$InstallPath\jdk-17\bin\java.exe"
        
        if (Test-Path $javaExe) {
            Write-Host "✅ Java found at: $javaExe"
            & $javaExe -version
            
            # Step 6: Set environment variable
            Write-Host "`n6️⃣  Setting JAVA_HOME environment variable..."
            [Environment]::SetEnvironmentVariable("JAVA_HOME", "$InstallPath\jdk-17", "Machine")
            Write-Host "✅ JAVA_HOME set to: $InstallPath\jdk-17"
            
            # Add Java to PATH
            $currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
            if ($currentPath -notlike "*$InstallPath\jdk-17\bin*") {
                $newPath = "$InstallPath\jdk-17\bin;$currentPath"
                [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
                Write-Host "✅ Added Java bin directory to PATH"
            }
            
            Write-Host "`n7️⃣  Configuring VS Code..."
            Write-Host "Please do the following in VS Code:"
            Write-Host "  1. Open Settings (Ctrl+,)"
            Write-Host "  2. Search for: 'apex.java.home'"
            Write-Host "  3. Set value to: $InstallPath\jdk-17"
            Write-Host "  4. Restart VS Code"
            Write-Host ""
            Write-Host "✅ Or restart PowerShell and VS Code - they should auto-detect Java now!"
            
        } else {
            Write-Host "❌ Java installation failed!"
            exit 1
        }
    } else {
        Write-Host "❌ MSI installation failed with exit code: $($process.ExitCode)"
        exit 1
    }
    
    # Clean up
    Remove-Item $msiPath -Force -ErrorAction SilentlyContinue
    
} catch {
    Write-Host "❌ Error: $_"
    exit 1
}

Write-Host "`n=========================================="
Write-Host "✅ Java installation complete!"
Write-Host "=========================================="
Write-Host "Next steps:"
Write-Host "1. Restart VS Code completely"
Write-Host "2. The Apex Language Server should now activate"
Write-Host "3. Errors should disappear"
