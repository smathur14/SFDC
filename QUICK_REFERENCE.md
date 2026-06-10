# 🚀 Salesforce Deployment - Quick Reference

## Fastest Methods

### Keyboard Shortcuts (VS Code)
```
Ctrl + Alt + D        → Deploy current file
Ctrl + Alt + Shift+D  → Deploy entire project
Ctrl + Alt + R        → Retrieve from org
```

### Command Palette (Ctrl+Shift+P)
```
Deploy File to Source Org
Deploy Project to Source Org
```

---

## PowerShell Commands

### Deploy Project
```powershell
.\deploy-sf.ps1 -Action project
```

### Deploy Single File
```powershell
.\deploy-sf.ps1 -Action file -FilePath "force-app/main/default/classes/MyClass.cls"
```

### Retrieve from Org
```powershell
.\deploy-sf.ps1 -Action retrieve
```

### Check Deployment Status
```powershell
.\deploy-sf.ps1 -Action status -JobId <JOB_ID>
```

---

## Direct SF CLI Commands

### Show Org Info
```powershell
sf org display --target-org myOrg
```

### List All Authenticated Orgs
```powershell
sf org list
```

### Validate Without Deploying
```powershell
sf project deploy start --source-dir force-app --target-org myOrg --dry-run
```

### Deploy with Specific Test Level
```powershell
sf project deploy start --source-dir force-app --target-org myOrg --test-level RunLocalTests
```

---

## 🆘 Troubleshooting

| Issue | Solution |
|-------|----------|
| Org not found | Run: `sf org list` |
| Permission denied | Check Salesforce user permissions |
| Deployment timeout | Increase wait time in `.vscode/tasks.json` |
| File not found | Verify file is in correct `force-app` subdirectory |

---

## 📋 Org Details
- **Alias**: myOrg
- **Username**: simran.mathur@analytics.com
- **Org ID**: 00Dg8000005pgAUEAY
- **Instance**: https://docusign-6d-dev-ed.develop.my.salesforce.com
