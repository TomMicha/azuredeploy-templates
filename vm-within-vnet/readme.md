# ALAS-5-05-20-dataplatform-template 

!!this should deploy VMs with network secuirty group, inside vnet, storage account (regular)

current resources:
NSG (attached to subnet1 and vnet)
VNET ( already created )
storage account
Public IPs
Network Interface


# Instructions
refactor resourceId pulling from each template vs 
maybe remove vnet rules in storage

# REMOVE NETWORK SECURITY RULES ACLS
resourceId(parameters('existingNetworkRG'),'Microsoft.Network/virtualNetworks/',
resourceId(parameters('existingNetworkRG'),'Microsoft.Network/networkSecurityGroups',
      
# Need to enable (accept) for Marketplace Image for Data science
Get-AzMarketplaceterms -Publisher "microsoft-ads" -Product "windows-data-science-vm" -Name "windows2016"
$agreementTerms=Get-AzMarketplaceterms -Publisher "microsoft-ads" -Product "windows-data-science-vm" -Name "windows2016"

Set-AzMarketplaceTerms -Publisher "microsoft-ads" -Product "windows-data-science-vm" -Name "windows2016" -Terms $agreementTerms -Accept

list extras:
reference(resourceId(parameters('existingNetworkRG'),'Microsoft.Network/virtualNetworks/subnets', parameters('existingVnetID'), variables('subnet1')),variables('vNetApiVersion'))

"type": "Microsoft.Compute/disks",
            "apiVersion": "2019-07-01",
            "name": "[variables('vmOSDiskName')]",
            "location": "eastus",
            "tags": {
                "created": "tom",
                "purpose": "vmdisk"
            },
            "sku": {
                "name": "Premium_LRS",
                "tier": "Premium"
            },
            "properties": {
              "osType": "Windows",
                "hyperVGeneration": "V1",
                "creationData": {
                    "createOption": "FromImage",
                    "imageReference": {
                        "id": "/Subscriptions/ba09e5b6-8d5c-4216-bcdc-ce0b594cc034/Providers/Microsoft.Compute/Locations/eastus/Publishers/microsoft-dsvm/ArtifactTypes/VMImage/Offers/dsvm-win-2019/Skus/server-2019/Versions/20.04.23"
                    }
                },
                "diskSizeGB": 128,
                "diskIOPSReadWrite": 500,
                "diskMBpsReadWrite": 100,
                "encryption": {
                    "type": "EncryptionAtRestWithPlatformKey"
                }
            }
    
      },