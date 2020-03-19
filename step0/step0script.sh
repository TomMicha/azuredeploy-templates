#!/bin/bash
# create key vault in designated environment

location="eastus"
resourceGroup=ALAS-step0
DeployName=ALAS-step0
networkgroup=ALAS-step0
template="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/step0/azuredeploy.json"
templateParams="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/step0/azuredeploy.parameters.json"

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
az account show