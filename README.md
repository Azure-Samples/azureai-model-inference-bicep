# Deploy and configure Azure AI Foundry Models

This repository shows how you can use Bicep to deploy flagship models in Azure AI Foundry.

## Features

This project framework provides the following features:

* Deploy multiple models from the Azure AI catalog into standard global deployments in Azure AI Foundry Models.
* Deploy multiple models in Azure AI Foundry resources and provision/configure a project to run inference from Azure AI Foundry Models.
* Configure Content filters for the model deployments.

## Getting Started

### Prerequisites

- Download and install it from the [Azure CLI installation page](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).
- Verify the installation:

  ```bash
  az --version
  ```

- An Azure subscription.
- Sign in to your Azure account to deploy resources.

    ```bash
    az login
    ```

- The `jq` tool.

  ```bash
  sudo apt install jq
  ```

### Quickstart

Clone the project:

```bash
git clone https://github.com/Azure-Samples/azureai-model-inference-bicep`
cd azureai-model-inference-bicep/infra
```

Inspect the file `models.json` and configure the models you are interested on deploying. The file is an array of JSON objects with the properties `provider`, `name`, and version. By default, this repository contains all the model definitions available for pay-as-you-go:

```JSON
{
    "provider": "Microsoft",
    "name": "Phi-3.5-vision-instruct",
    "version": "2",
    "sku": "GlobalStandard"
}
```

Ensure you are in the right subscription:

```bash
az account set --subscription "<subscription-id>"
```

Configure the deployment

```bash
RESOURCE_GROUP="azureai-models-dev"
LOCATION="eastus2"
```

#### Deploy all the models in Azure AI Foundry Models supporting standard global deployments

Run the deployment:

```bash
az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --template-file deploy.bicep
```


#### Deploy all the models and configure an AI project/hub

Run the deployment:

```bash
az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --template-file deploy-with-project.bicep
```

## Resources

- [Azure AI Foundry Models](https://aka.ms/aiservices/inference)
- [Azure Machine Learning resource management reference](https://learn.microsoft.com/azure/templates/microsoft.machinelearningservices/workspaces)
