@description('Name of the hub where the connection will be created')
param hubName string

@description('Name of the connection')
param name string

@description('Category of the connection')
param category string = 'AIServices'

@allowed(['AAD', 'ApiKey', 'ManagedIdentity', 'None'])
param authType string = 'AAD'

@description('The endpoint URI of the connected service')
param endpointUri string

@description('The resource ID of the connected service')
param resourceId string = ''

@secure()
param key string = ''


resource connection 'Microsoft.MachineLearningServices/workspaces/connections@2024-04-01-preview' = {
  name: '${hubName}/${name}'
  properties: {
    category: category
    target: endpointUri
    authType: authType
    isSharedToAll: true
    credentials: authType == 'ApiKey' ? {
      key: key
    } : null
    metadata: {
      ApiType: 'Azure'
      ResourceId: resourceId
    }
  }
}
