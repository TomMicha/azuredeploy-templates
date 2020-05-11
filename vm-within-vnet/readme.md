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