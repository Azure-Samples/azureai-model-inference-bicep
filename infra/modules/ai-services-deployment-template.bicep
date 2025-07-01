@description('Name of the Azure AI services account')
param accountName string

@description('Name of the model to deploy')
param modelName string

@description('Version of the model to deploy')
param modelVersion string

@allowed([
  'AI21 Labs'
  'Cohere'
  'Core42'
  'DeepSeek'
  'xAI'
  'Meta'
  'Microsoft'
  'Mistral AI'
  'OpenAI'
])
@description('Model provider')
param modelPublisherFormat string

@allowed([
    'GlobalStandard'
    'DataZoneStandard'
    'Standard'
    'GlobalProvisioned'
    'Provisioned'
])
@description('Model deployment SKU name')
param skuName string = 'GlobalStandard'

@description('Content filter policy name')
param contentFilterPolicyName string = 'Microsoft.DefaultV2'

@description('Model deployment capacity')
param capacity int = 1

resource modelDeployment 'Microsoft.CognitiveServices/accounts/deployments@2024-04-01-preview' = {
  name: '${accountName}/${modelName}'
  sku: {
    name: skuName
    capacity: capacity
  }
  properties: {
    model: {
      format: modelPublisherFormat
      name: modelName
      version: modelVersion
    }
    raiPolicyName: contentFilterPolicyName == null ? 'Microsoft.Nill' : contentFilterPolicyName
  }
}
