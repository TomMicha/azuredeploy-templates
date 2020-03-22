#!/bin/bash
#create key vault secret for deployment
location="eastus"
keyResourceGroup=ALAS-keyvaultgroup-dev
keyDeploymentName=deploy-ALAS-keyvault-deploy-dev
keyVault=ALASDIA-keyvault-dev


az group create -n $keyResourceGroup -l $location \
    --verbose

#create key vault
az keyvault create \
    --name $keyVault \
    --resource-group $keyResourceGroup \
    --location $location \
    --enabled-for-template-deployment true

# add password to keyvault


# set the secret in keyvault
#az keyvault secret set \
#    --name $secretname \
#    --vault-name $keyVault \
#    --value $securepassword \
#   --verbose