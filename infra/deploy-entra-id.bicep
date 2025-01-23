@description('Location to create the resources in')
param location string = resourceGroup().location

@description('Name of the resource group to create the resources in')
param resourceGroupName string = resourceGroup().name

@description('Name of the AI Services account to create')
param accountName string = 'azurei-models-dev'

@description('ID of the developers to assign the user role to')
param securityPrincipalId string

module aiServicesAccount 'modules/ai-services-template.bicep' = {
  name: 'aiServicesAccount'
  scope: resourceGroup(resourceGroupName)
  params: {
    accountName: accountName
    location: location
    allowKeys: false
  }
}

module roleAssignmentDeveloperAccount 'modules/role-assignment-template.bicep' = {
  name: 'roleAssignmentDeveloperAccount'
  scope: resourceGroup(resourceGroupName)
  params: {
    roleDefinitionID: 'a97b65f3-24c7-4388-baec-2e87135dc908' // Azure Cognitive Services User
    principalId: securityPrincipalId
  }
}

output endpoint string = aiServicesAccount.outputs.endpointUri
