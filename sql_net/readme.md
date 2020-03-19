this should deploy network secuirty group, vnet, storage account (regular)

current resources:
NSG
VNET ( 4 subnets, main one associated with NSG )
storage account
+sql server 
+sql database
+storage (datalake)


Add storage account (data lake) + Sql database + server

issues:
cant seem to add additional security rules for PL and Allyson IP's
says Ruls cannot have same Priority and Direction even though they do not..