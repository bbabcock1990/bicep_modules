// Scope
targetScope = 'subscription'

// Parameters
param rgName string
param location string
param tags object

// Resource
resource resource_group 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: rgName
  location: location
  tags: tags
}


// Outputs
output resourceGroupId string = resource_group.id // output resourceId of storage account
output resourceGroupName string = resource_group.name // output name of storage account
