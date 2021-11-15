# Create a resource group
az group create --location eastus2 --name branching-strategy-rg

# Create an app service plan of type Linux
az appservice plan create -g branching-strategy-rg -n branching-strategy-sp

# Create an App Service from the plan 
az webapp create -g branching-strategy-rg -p branching-strategy-sp -n bs-sample-api --runtime "DOTNET|5.0"