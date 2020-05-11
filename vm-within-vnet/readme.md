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
      
