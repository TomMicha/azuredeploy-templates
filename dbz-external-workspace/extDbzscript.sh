# script shell for databricks external space - redefine subnets add bastion

location="eastus"
dbzResourceGroup=ALAS-DS-Workspace-dev
dbzDeployName=ALAS-deploy-DS-dev

template="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/dbz-external-workspace/azuredeploy.json"
templateParams="https://raw.githubusercontent.com/TomMicha/azuredeploy-templates/master/dbz-external-workspace/azuredeploy.parameters.json"

az group create -n $dbzResourceGroup -l $location \
    --verbose

# deploy dbz workspace (without cluster)
az group deployment create \
    --name $dbzDeploymentName \
    --resource-group $dbzResourceGroup \
    --template-uri $template \
    --parameters $templateParams \
    --debug