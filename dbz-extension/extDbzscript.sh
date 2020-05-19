# script shell for databricks external space - redefine subnets add bastion
echo $0
echo $1
echo $2

if [ $1 = dev ]
then 
    echo $1 is running
fi

location="eastus"
networkRG=ALAS-Networking-dev
dbzResourceGroup=ALAS-DataScience-dev
dbzDeployName=ALAS-deploy-DS-dev

template="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/dbz-extension/azuredeploy.json"
templateParams="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/dbz-extension/azuredeploy.parameters.dev.json"

# create extra networking group
az group create -n $networkRG -l $location \
    --verbose

az group create -n $dbzResourceGroup -l $location \
    --verbose

# deploy dbz workspace (without cluster)
az group deployment create \
    --name $dbzDeployName \
    --resource-group $dbzResourceGroup \
    --template-uri $template \
    --parameters $templateParams \
    --debug