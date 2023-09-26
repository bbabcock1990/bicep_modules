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
output resource_group_id string = resource_group.id
output resource_group_name string = resource_group.name
output resource_group_location string = resource_group.location
