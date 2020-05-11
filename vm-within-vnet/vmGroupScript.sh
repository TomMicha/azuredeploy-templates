#!/bin/bash
#create key vault secret for deployment
location="eastus"
vmResourceGroup=ALAS-External-Workspace-dev
vmDeployName=ALAS-deployWorkspace-dev

template="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/vm-within-vnet/azuredeploy.json"
templateParams="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/vm-within-vnet/azuredeploy.parameters.json"

az keyvault secret set --vault-name ALAS-keyvaultgroup-dev --secret-name externalVM --value HBRgroup2020 --verbose

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