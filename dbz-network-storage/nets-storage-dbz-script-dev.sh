#!/bin/bash

#create resource group and template links to resources
location="eastus"
resourceGroup=ALAS-dataworkspace-dev
#databaseResourceGroup=ALAS-storage-dev
DeployName=ALAS-deploy-data-workspace-dev
template="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/dbz-network-storage/azuredeploy.json"
templateParams="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/dbz-network-storage/azuredeploy.parameters.json"

echo $location
az group create \
    --name $resourceGroup  \
    --location $location \
    --verbose
#az group create -n $databaseResourceGroup -l $location \
 #   --verbose

# create template deployment
az group deployment create \
    --name $DeployName \
    --resource-group $resourceGroup \
    --template-uri $template \
    --parameters $templateParams \
    --debug

# show subscription info
