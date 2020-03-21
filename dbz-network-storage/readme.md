# ALAS-3-20-20-dataplatform-template

!!this should deploy network secuirty group, vnet, storage account (regular), data lake gen2, databricks workspace with dedicated subnets

current resources:
NSG (attached to subnet1 and vnet)
VNET ( 4 subnets, 2 dedicated to databricks
storage account
data lake storage 
++data bricks workspace (injected in vnet)

# Instructions
modify variables in parameters file and scripts to point to template artifact URI
run bash script