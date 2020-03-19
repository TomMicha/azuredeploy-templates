#!/bin/bash
# create key vault in designated environment

location="eastus"
resourceGroup=test-vnet-storage-mix
DeployName=test-vnet-storage-mix
networkgroup=test-vnet-storage-mix
template="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/sql_net/azuredeploy.json"
templateParams="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/sql_net/azuredeploy.parameters.json"

echo $location
az group create -n $resourceGroup -l $location \
    --verbose


# create template deployment
az group deployment create \
    --name $DeployName \
    --resource-group $resourceGroup \
    --template-uri $template \
    --parameters $templateParams \
    --debug

# show subscription info