#!/bin/bash
# Salesforce Deploy Helper Script
# This script provides a simple way to deploy to Salesforce org

if [ -z "$1" ]; then
    echo "Usage: ./deploy.sh [file|project]"
    echo ""
    echo "Examples:"
    echo "  ./deploy.sh file      - Deploy current file to myOrg"
    echo "  ./deploy.sh project   - Deploy entire force-app to myOrg"
    exit 1
fi

if [ "$1" = "file" ]; then
    echo "Deploying file to myOrg..."
    sf project deploy start --source-dir "$(pwd)" --target-org myOrg --wait 10
elif [ "$1" = "project" ]; then
    echo "Deploying force-app to myOrg..."
    cd "$(dirname "$0")"
    sf project deploy start --source-dir force-app --target-org myOrg --wait 10
else
    echo "Unknown command: $1"
    exit 1
fi
