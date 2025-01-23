@description('Specifies the role definition ID used in the role assignment.')
param roleDefinitionID string

@description('Specifies the principal ID assigned to the role.')
param principalId string

@description('Specifies the resource ID of the resource to assign the role to.')
param scopeResourceId string = resourceGroup().id

var roleAssignmentName= guid(principalId, roleDefinitionID, scopeResourceId)
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: roleAssignmentName
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionID)
    principalId: principalId
  }
}

output name string = roleAssignment.name
output resourceId string = roleAssignment.id
