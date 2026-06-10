<<<<<<< HEAD
# Salesforce DX Project

Welcome to your Salesforce DX project!

## Project Setup

This is a Salesforce DX project configured for org development. The following elements are part of the structure:

### Folders

- **force-app/main/default**: The main source code folder containing:
  - **classes**: Apex classes for backend logic
  - **lwc**: Lightning Web Components
  - **triggers**: Apex triggers
  - **aura**: Aura components (legacy)
  - **objects**: Custom object configurations
  - **flows**: Flow definitions
  - **pages**: Visualforce pages
  - **staticresources**: Static resources (CSS, JavaScript files)

## Getting Started

### 1. Set the Default Org

To set MyOrgAlias as your default org:
```bash
sf config set target-org=MyOrgAlias
```

### 2. Verify Org Connection

```bash
sf org list --all
```

You should see `MyOrgAlias` in the list.

### 3. Create Your First Apex Class

```bash
sf force generate class --name MyFirstClass
```

### 4. Create Your First LWC Component

```bash
sf force generate lightning-component --name myFirstComponent --type lwc
```

### 5. Deploy to Org

```bash
sf project deploy start --target-org MyOrgAlias
```

### 6. Retrieve from Org

```bash
sf project retrieve start --target-org MyOrgAlias
```

## Useful Commands

- `sf project deploy start` - Deploy source to org
- `sf project retrieve start` - Retrieve source from org
- `sf force generate class` - Generate an Apex class
- `sf force generate lightning-component` - Generate LWC
- `sf force generate trigger` - Generate a trigger
- `sf org open` - Open the org in browser
- `sf apex run` - Run Apex code

## Configuration

The project is configured in `sfdx-project.json`:
- **sfdcLoginUrl**: Login URL for your Salesforce org
- **packageDirectories**: Locations of your source code
- **sourceApiVersion**: The API version (currently 60.0)

## Need Help?

- [Salesforce DX Documentation](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/)
- [Salesforce CLI Commands](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/)
=======
# SFDC
Salesforce Projects
>>>>>>> edffdc740e2e1472c97d8a5690d6c25eafb77a3f
