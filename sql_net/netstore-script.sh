#!/bin/bash
# create key vault in designated environment
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
securepassword=$(printf $password | base64)
echo $securepassword

# set the secret in keyvault
az keyvault secret set \
    --name $secretname \
    --vault-name $keyVault \
    --value $securepassword \
    --verbose

#create resource group and template links to resources
#location="eastus"
resourceGroup=test-vnet-storage-mix
databaseResourceGroup=ALAS-databases-dev
DeployName=test-vnet-storage-mix
networkgroup=test-vnet-storage-mix
template="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/sql_net/azuredeploy.json"
templateParams="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/sql_net/azuredeploy.parameters.json"

echo $location
az group create -n $resourceGroup -l $location \
    --verbose
az group create -n $databaseResourceGroup -l $location \
    --verbose

# create template deployment
az group deployment create \
    --name $DeployName \
    --resource-group $resourceGroup \
    --template-uri $template \
    --parameters $templateParams \
    --debug

# show subscription info
