this should deploy network secuirty group, vnet, storage account (regular)

current resources:
NSG
VNET ( 4 subnets, main one associated with NSG )
storage account
+sql server (save password to keyvault for retrieval during deployment)
+sql database
+storage (datalake)


Add storage account (data lake) + Sql database + server

issues:
cant seem to add additional security rules for PL and Allyson IP's
says Ruls cannot have same Priority and Direction even though they do not..


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