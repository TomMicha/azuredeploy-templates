#!/bin/bash
# create key vault in designated environment

location="eastus"
resourceGroup=ALAS-keyvault
deploymentName=ALAS-keyvault
keyVault=ALAS-keyvault
password=ALASP@55WORD
secretname=vmAdminPassword
echo $password
echo $location
az group create -n $resourceGroup -l $location \
    --verbose

#create key vault
az keyvault create \
    --name $keyVault \
    --resource-group $resourceGroup \
    --location $location \
    --enabled-for-template-deployment true

# add password to keyvault
securepassword=$(printf $password | base64)
echo $securepassword

# set the secret in keyvault
az keyvault secret set \
    --name $secretname \
    --vault-name $keyVault \
    --value $securepassword \
    --verbose

# show subscription info
az account show