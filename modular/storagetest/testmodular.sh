#!/bin/bash
#create key vault secret for deployment
location="eastus"
vmResourceGroup=Modular-Workspace-dev
vmDeployName=ALAS-deployModular-dev

template="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/modular/storagetest/azuredeploy.json"
templateParams="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/modular/storagetest/azuredeploy.parameters.json"


az group create -n $vmResourceGroup -l $location \
    --verbose

# create template deployment
az group deployment create \
    --name $vmDeployName \
    --resource-group $vmResourceGroup \
    --template-uri $template \
    --parameters $templateParams \
    --debug



# set the secret in keyvault
#az keyvault secret set \
#    --name $secretname \
#    --vault-name $keyVault \
#    --value $securepassword \
#   --verbose