#!/bin/bash
# file to create azure namespace and service bus

if [ $# -eq 2 ]
  then
    echo "No arguments supplied"
    exit 1
fi

RESOURCE_GROUP=$1
NAMESPACE=$2
QUEUE=$3

az group create --name $RESOURCE_GROUP --location eastus
az servicebus namespace create --resource-group $RESOURCE_GROUP --name $NAMESPACE --location eastus
az servicebus queue create --resource-group $RESOURCE_GROUP --namespace-name $NAMESPACE --name $QUEUE


# return connection string
az servicebus namespace authorization-rule keys list --resource-group $RESOURCE_GROUP --namespace-name $NAMESPACE --name RootManageSharedAccessKey --query primaryConnectionString --output tsv
