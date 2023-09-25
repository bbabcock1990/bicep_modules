// Scope
targetScope = 'subscription'

// Parameters
param rgName string
param location string
param tags object

// Resource
resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: rgName
  location: location
  tags: tags
}


// Outputs
output resourceGroupId string = resourceGroup.id // output resourceId of storage account
output resourceGroupName string = resourceGroup.name // output name of storage account
