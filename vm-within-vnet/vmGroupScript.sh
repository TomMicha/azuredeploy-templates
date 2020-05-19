#!/bin/bash
#create key vault secret for deployment
echo $1

echo Starting databricks extension script with networking configurations

case $1 in 
    'dev')
        echo Provided input, $1 is running
        templateParams="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/vm-within-vnet/azuredeploy.parameters.dev.json"
        ;;
    'prod')
        echo Provided input, $1 is running
        templateParams="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/vm-within-vnet/azuredeploy.parameters.prod.json"
        ;;
    *)
        echo Invalid input, must choose dev or prod parameters
        exit 1
        ;;
esac

location="eastus"
vmResourceGroup=ALAS-External-Workspace-dev
vmDeployName=ALAS-deployWorkspace-dev

template="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/vm-within-vnet/azuredeploy.json"

# create secret and enable for template deployment
az keyvault secret set --name externalVMPass --vault-name ALAS-keyvault-dev --value HBRgroup2020 --verbose
az keyvault update --name ALAS-keyvault-dev --enabled-for-template-deployment true

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