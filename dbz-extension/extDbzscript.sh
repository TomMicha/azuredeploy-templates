# script shell for databricks external space - redefine subnets add bastion
echo Starting databricks extension script with networking configurations

case $1 in 
    'dev')
        echo Provided input, $1 is running
        templateParams="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/dbz-extension/azuredeploy.parameters.dev.json"
        ;;
    'prod')
        echo Provided input, $1 is running
        templateParams="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/dbz-extension/azuredeploy.parameters.prod.json"
        ;;
    *)
        echo Invalid input, must choose dev or prod parameters
        exit 1
        ;;
esac


location="eastus"
networkRG=ALAS-Networking-dev
dbzResourceGroup=ALAS-DataScience-dev
dbzDeployName=ALAS-deploy-DS-dev

template="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/dbz-extension/azuredeploy.json"


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