this should deploy network secuirty group, vnet, storage account (regular)

current resources:
NSG
VNET ( 4 subnets, main one associated with NSG )
storage account
+sql server (save password to keyvault for retrieval during deployment)
+sql database
+storage (datalake)
Deploy storage in new 2nd Resource group (add RG in bash script)


Add storage account (data lake) + Sql database + server

issues:
cant seem to add additional security rules for PL and Allyson IP's
says Ruls cannot have same Priority and Direction even though they do not..

Validate:
az deployment validate --location $location --parameters paramsfile.json --template-uri "github//"

GET RESOURCE PROVIDER APIS (IMPORTANT FOR TEMPLATES):
Display all resource types for the network resource provider.
        az provider list --query [?namespace=='Microsoft.Network'].resourceTypes[].resourceType
        -----OR----
az provider show -n "Microsoft.Storage/storageAccounts"
        -----OR----
az provider show --namespace Microsoft.Batch --query "resourceTypes[?resourceType=='batchAccounts'].apiVersions | [0]" --out table

POWERSHELL ---OR----
((Get-AzureRmResourceProvider -ProviderNamespace Microsoft.Network).ResourceTypes | Where-Object ResourceTypeName -eq virtualNetworks).ApiVersions

Reference Key Vault secrets how:
"adminPassword": {
        "reference": {
          "keyVault": {
          "id": "/subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.KeyVault/vaults/<vault-name>"
          },
          "secretName": "ExamplePassword"
        }
        ## within parameters/deploy files ##
        [resourceId(subscription().subscriptionId, parameters('keyVaultGroup'), 'Microsoft.KeyVault/vaults',parameters('vaultName'))]