this should deploy network secuirty group, vnet, storage account (regular)

current resources:
NSG
VNET ( 4 subnets, main one associated with NSG )
storage account
+sql server (save password to keyvault for retrieval during deployment)
+sql database
+storage (datalake) add service endpoint,subnet and vnet to template
Deploy storage in new 2nd Resource group (add RG in bash script)
( "resourceGroup": "[resourceId(subscription().subscriptionId,'Microsoft.Resources/resourceGroups',parameters('storageResourceGroup'))]",)


Add storage account (data lake) + Sql database + server
Delete password out put check****^^^)^&^2

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



&&&&&&&&&&&&&& scripts to help build database from backup $$$$$$$$$$$$$$$$$$$&&&&&&&&

az sql db import --resource-group "<resourceGroupName>" --server "<serverName>" --name "<databaseName>" `
    --storage-key-type "StorageAccessKey" --storage-key "<storageAccountKey>" `
    --storage-uri "https://myStorageAccount.blob.core.windows.net/importsample/sample.bacpac" `
    -u "<userId>" -p $(ConvertTo-SecureString -String "<password>" -AsPlainText -Force).n

    # Import bacpac to database with an S3 performance level
$importRequest = New-AzSqlDatabaseImport -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -DatabaseName $databaseName `
    -DatabaseMaxSizeBytes "53687091200" `
    -StorageKeyType "StorageAccessKey" `
    -StorageKey $(Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -StorageAccountName $storageAccountName).Value[0] `
    -StorageUri "https://$storageaccountname.blob.core.windows.net/$storageContainerName/$bacpacFilename" `
    -Edition "Standard" `
    -ServiceObjectiveName "S3" `
    -AdministratorLogin "$adminSqlLogin" `
    -AdministratorLoginPassword $(ConvertTo-SecureString -String $password -AsPlainText -Force)

# AZ CLI COMMANDS TO GEN SAS KEY AND THEN IMPORT DB
az storage blob generate-sas --account-name rawpassportbackupdev -c pbacpac -n DIAData.bacpac \
    --permissions r --expiry 2020-03-22T06:00:00Z

az sql db import -s rawpassport-sqlserver-dev -n ALAS-importdb1 -g $RESGROUP -p ALASserver99 -u thanos \
    --storage-key "se=2020-03-22T06%3A00%3A00Z&sp=rw&sv=2018-11-09&sr=b&sig=yl6RBE5fRj4u2hh8/MFTmrEd4YMNFwt4pIoyMIl8%2ByY%3D" \
    --storage-key-type SharedAccessKey \
    --storage-uri https://rawpassportbackupdev.blob.core.windows.net/myContainer/DIAData.bacpac

# AZ CLI WITH STORAGE KEY
az sql db import --resource-group rawpassport-src-dev --server rawpassport-sqlserver-dev --name ALAS-importdb1 \
    --storage-key-type "StorageAccessKey" --storage-key $STORAGKEY \
    --storage-uri "https://rawpassportbackupdev.blob.core.windows.net/pbacpac/DIAData.bacpac" \
    -u thanos -p ALASserver99