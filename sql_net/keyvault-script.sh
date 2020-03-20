#!/bin/bash
#create key vault secret for deployment
location="eastus"
keyResourceGroup=ALAS-keyvault
keyDeploymentName=ALAS-keyvault
keyVault=ALAS-keyvault
password=ALASdiadb123
secretname=sqlServerAdminPass
echo $password
echo $location
az group create -n $keyResourceGroup -l $location \
    --verbose

#create key vault
az keyvault create \
    --name $keyVault \
    --resource-group $keyResourceGroup \
    --location $location \
    --enabled-for-template-deployment true

# add password to keyvault
securepassword=$(echo $password | base64)
echo $securepassword

# set the secret in keyvault
az keyvault secret set \
    --name $secretname \
    --vault-name $keyVault \
    --value $securepassword \
    --verbose