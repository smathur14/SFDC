const vscode = require('vscode');
const { exec } = require('child_process');
const path = require('path');

function executeCommand(command, cwd) {
  return new Promise((resolve, reject) => {
    exec(command, { cwd }, (error, stdout, stderr) => {
      if (error) {
        reject(error);
        return;
      }
      resolve(stdout);
    });
  });
}

async function deploySingleFile(fileUri) {
  if (!fileUri) {
    const editor = vscode.window.activeTextEditor;
    if (!editor) {
      vscode.window.showErrorMessage('No file selected for deployment');
      return;
    }
    fileUri = editor.document.uri;
  }

  const filePath = fileUri.fsPath;
  const workspaceFolders = vscode.workspace.workspaceFolders;
  
  if (!workspaceFolders) {
    vscode.window.showErrorMessage('No workspace folder open');
    return;
  }

  const workspaceRoot = workspaceFolders[0].uri.fsPath;
  const relativePath = path.relative(workspaceRoot, filePath);

  try {
    const channel = vscode.window.createOutputChannel('Salesforce Deploy');
    channel.show();
    
    channel.appendLine(`Deploying file: ${relativePath}`);
    channel.appendLine('-----------------------------------');

    const command = `sf project deploy start --manifest "${relativePath}" --target-org myOrg`;
    
    channel.appendLine(`Running: ${command}`);
    channel.appendLine('');

    const output = await executeCommand(command, workspaceRoot);
    
    channel.appendLine(output);
    
    if (output.includes('✓') || output.includes('deployed')) {
      vscode.window.showInformationMessage(`✓ Successfully deployed: ${path.basename(filePath)}`);
    }
  } catch (error) {
    vscode.window.showErrorMessage(`Deployment failed: ${error.message}`);
  }
}

async function deployProject() {
  const workspaceFolders = vscode.workspace.workspaceFolders;
  
  if (!workspaceFolders) {
    vscode.window.showErrorMessage('No workspace folder open');
    return;
  }

  const workspaceRoot = workspaceFolders[0].uri.fsPath;

  try {
    const channel = vscode.window.createOutputChannel('Salesforce Deploy');
    channel.show();
    
    channel.appendLine('Deploying entire project to myOrg');
    channel.appendLine('-----------------------------------');

    const command = `sf project deploy start --source-dir force-app --target-org myOrg`;
    
    channel.appendLine(`Running: ${command}`);
    channel.appendLine('');

    const output = await executeCommand(command, workspaceRoot);
    
    channel.appendLine(output);
    
    if (output.includes('✓') || output.includes('deployed')) {
      vscode.window.showInformationMessage('✓ Project deployment completed successfully');
    }
  } catch (error) {
    vscode.window.showErrorMessage(`Project deployment failed: ${error.message}`);
  }
}

function activate(context) {
  context.subscriptions.push(
    vscode.commands.registerCommand('extension.deploySingleFile', deploySingleFile)
  );

  context.subscriptions.push(
    vscode.commands.registerCommand('extension.deployProject', deployProject)
  );

  console.log('Salesforce Deploy Helper is now active');
}

function deactivate() {}

module.exports = {
  activate,
  deactivate
};
