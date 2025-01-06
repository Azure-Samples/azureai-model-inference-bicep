@description('Location to create the resources in')
param location string = resourceGroup().location

@description('Name of the resource group to create the resources in')
param resourceGroupName string = resourceGroup().name

@description('Name of the AI Services account to create')
param accountName string = 'azurei-models-dev'

@description('Path to a JSON file with the list of models to deploy. Each model is a JSON object with the following properties: name, version, provider')
var models = json(loadTextContent('models.json'))

module aiServicesAccount 'modules/ai-services-template.bicep' = {
  name: 'aiServicesAccount'
  scope: resourceGroup(resourceGroupName)
  params: {
    accountName: accountName
    location: location
  }
}

@batchSize(1)
module modelDeployments 'modules/ai-services-deployment-template.bicep' = [
  for (item, i) in models: {
    name: 'deployment-${item.name}'
    scope: resourceGroup(resourceGroupName)
    params: {
      accountName: accountName
      modelName: item.name
      modelVersion: item.version
      modelPublisherFormat: item.provider
      skuName: item.sku
    }
    dependsOn: [
      aiServicesAccount
    ]
  }
]

output endpoint string = aiServicesAccount.outputs.endpointUri
