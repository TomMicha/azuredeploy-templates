#!/bin/bash

location="eastus"
resourceGroup=ALAS-nsg
DeployName=ALAS-nsg
networkgroup=ALAS-nsg
template="https://github.com/TomMicha/azuredeploy-templates/NSG/azuredeploy.json"
templateParams="https://github.com/TomMicha/azuredeploy-templates/NSG/azuredeploy.parameters.json"

echo $location
az group create -n $resourceGroup -l $location \
    --verbose


# create template deployment
az group deployment create \
    --name $DeployName \
    --resource-group $resourceGroup \
    --template-uri $template \
    --parameters $templateParams \
    --verbose

#     --parameters $templateParams \ need all params for this param file to work