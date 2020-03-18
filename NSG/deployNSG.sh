#!/bin/bash

location="eastus"
resourceGroup=ALAS-nsg
DeployName=ALAS-nsg
networkgroup=ALAS-nsg
template="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/NSG/azuredeploy.json"
templateParams="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/NSG/azuredeploy.parameters.json"

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