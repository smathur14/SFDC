# Salesforce Deployment Setup Guide

## ✅ Setup Complete!

Your Salesforce DX project is now configured for easy deployment. Here's what was set up:

### 🔐 Source Org Configuration
- **Org Alias**: `myOrg`
- **Instance**: https://docusign-6d-dev-ed.develop.my.salesforce.com
- **Username**: simran.mathur@analytics.com
- **Org ID**: 00Dg8000005pgAUEAY
- **Status**: ✅ Authenticated and set as default

---

## 📋 Available Deployment Methods

### Method 1: **Keyboard Shortcuts** (Quickest!)

**Deploy Current File:**
- Press: `Ctrl + Alt + D`
- Deploys the file you're currently editing to myOrg

**Deploy Entire Project:**
- Press: `Ctrl + Alt + Shift + D`
- Deploys all files in `force-app` to myOrg

**Retrieve from Org:**
- Press: `Ctrl + Alt + R`
- Retrieves latest metadata from myOrg

---

### Method 2: **Command Palette**

1. Press `Ctrl + Shift + P` (or `Cmd + Shift + P` on Mac)
2. Type one of the following:
   - `Deploy File to Source Org`
   - `Deploy Project to Source Org`
   - `Retrieve from Source Org`
   - `Display Org Info`
   - `List All Authenticated Orgs`

---

### Method 3: **PowerShell Scripts**

**Deploy Current File:**
```powershell
.\deploy.ps1 file
```

**Deploy Entire Project:**
```powershell
.\deploy.ps1 project
```

---

### Method 4: **Direct CLI Commands**

**Deploy Single File:**
```powershell
sf project deploy start --source-dir "path/to/file" --target-org myOrg
```

**Deploy Project:**
```powershell
sf project deploy start --source-dir force-app --target-org myOrg
```

**Check Org Details:**
```powershell
sf org display --target-org myOrg
```

**List All Orgs:**
```powershell
sf org list
```

---

## 📁 Project Structure

```
d:\Zwei\
├── force-app/
│   └── main/default/
│       ├── classes/          (Apex classes)
│       ├── lwc/              (Lightning Web Components)
│       ├── aura/             (Aura components)
│       ├── pages/            (Visualforce pages)
│       └── ...
├── .vscode/
│   ├── tasks.json           (Deployment tasks)
│   ├── keybindings.json     (Keyboard shortcuts)
│   ├── settings.json        (VS Code settings)
│   └── extensions.json      (Recommended extensions)
├── .vscode-extension/       (Custom VS Code extension)
├── deploy.bat              (Windows batch script)
├── deploy.sh               (Linux/Mac shell script)
└── sfdx-project.json       (Project configuration)
```

---

## 🚀 Recommended Workflow

### For Single File Changes:
1. Make your changes to a file (e.g., `.cls`, `.js`, `.html`)
2. Save the file (`Ctrl + S`)
3. Press `Ctrl + Alt + D` to deploy
4. Check the output panel for success/failure

### For Multiple File Changes:
1. Make all your changes
2. Press `Ctrl + Alt + Shift + D` to deploy the entire project
3. Review deployment results

### To Sync with Org:
1. Press `Ctrl + Alt + R` to retrieve latest changes from the org
2. Resolve any conflicts if necessary

---

## 🔧 Troubleshooting

### Error: "org not found"
**Solution**: Verify org is authenticated
```powershell
sf org list
```
You should see `myOrg` listed as the default.

### Error: "Permission denied"
**Solution**: Ensure your Salesforce user has:
- API Enabled
- Metadata API deployment permissions

Check with your Salesforce admin.

### Deployment takes too long
**Solution**: The default timeout is 10 minutes. To increase it, edit `.vscode/tasks.json`:
```json
"--wait",
"30"    // Increase from 10 to 30 minutes
```

### File not found in deployment
**Solution**: Ensure files are in the correct structure:
- Apex: `force-app/main/default/classes/`
- LWC: `force-app/main/default/lwc/`
- Aura: `force-app/main/default/aura/`
- Pages: `force-app/main/default/pages/`

---

## 📚 Useful SF CLI Commands

### View Deployment Status
```powershell
sf project deploy report --job-id <JOB_ID> --target-org myOrg
```

### Deploy with Validation (Don't commit)
```powershell
sf project deploy start --source-dir force-app --target-org myOrg --test-level RunLocalTests --dry-run
```

### Deploy Specific Component
```powershell
sf project deploy start --source-dir "force-app/main/default/classes/MyClass.cls" --target-org myOrg
```

### Run Apex Tests
```powershell
sf apex run test --target-org myOrg
```

### Generate Code Coverage
```powershell
sf apex run test --code-coverage --target-org myOrg
```

---

## ✨ Next Steps

1. **Install Recommended Extensions**:
   - Open VS Code Extensions (`Ctrl + Shift + X`)
   - Look for "Salesforce Extensions" pack
   - These provide better Apex/LWC support

2. **Create Your First Test**:
   ```powershell
   sf project generate test --template ApexClass --name MyTest --target-org myOrg
   ```

3. **Set Up Scratch Org** (for isolated testing):
   ```powershell
   sf org create scratch --definition-file config/project-scratch-def.json --alias scratch-org
   ```

---

## 🆘 Support & Documentation

- **Salesforce CLI Docs**: https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/
- **Salesforce DX Guide**: https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev_guide.meta/sfdx_dev_guide/
- **VS Code Salesforce Extension**: https://github.com/forcedotcom/salesforcedx-vscode

---

**Happy Deploying! 🎉**
