# Salesforce Deploy Helper Extension

This extension adds right-click context menu options to deploy Salesforce files to your source org.

## Features

- **Deploy Single File**: Right-click on any Apex, Lightning Web Component, or Salesforce metadata file and select "Deploy to Source Org"
- **Deploy Project**: Right-click any Salesforce file and select "Deploy Project to Source Org" to deploy your entire force-app directory

## Installation

### Quick Setup

1. The extension folder is located at: `.vscode-extension/`
2. To install it in VS Code:
   - Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
   - Search for "Developer: Install Extension from Location"
   - Select the `.vscode-extension` folder

### Alternative: Manual Installation

1. Open VS Code
2. Go to Extensions (Ctrl+Shift+X)
3. Click the "..." menu and select "Install from VSIX"
4. Navigate to `.vscode-extension/salesforce-deploy-helper-1.0.0.vsix` (after packaging)

## Requirements

- Salesforce CLI (sf/sfdx) - Already installed ✓
- Active org authentication with alias `myOrg` - Already configured ✓

## Usage

### Deploy Single File
1. Right-click on a file in the Explorer (e.g., `.cls`, `.js`, `.html`)
2. Select **"Deploy to Source Org"**
3. Watch the deployment progress in the Output panel

### Deploy Entire Project
1. Right-click on any Salesforce metadata file
2. Select **"Deploy Project to Source Org"**
3. The entire `force-app` directory will be deployed

## Verification

Check if your org is authenticated:
```powershell
sf org list
```

You should see `myOrg` listed as the default org.

## Troubleshooting

### Deployment fails with "org not found"
- Run: `sf org list` to verify `myOrg` is authenticated
- Re-authenticate if needed: `sf auth web login --alias myOrg --set-default`

### Permission denied errors
- Ensure your Salesforce user has deployment permissions
- Check the deployment status in your Salesforce org

### File not found in manifest
- Ensure the file is in the `force-app/main/default/` directory structure
- Verify the file extension matches Salesforce metadata format

## Org Details

- **Org Alias**: myOrg
- **Instance**: https://docusign-6d-dev-ed.develop.my.salesforce.com
- **Username**: simran.mathur@analytics.com
- **Org ID**: 00Dg8000005pgAUEAY

---

For more information on Salesforce CLI deployment, run:
```powershell
sf project deploy start --help
```
