//Paramaters
param applicaton_group_name string
param hostpool_name string
param application_group_friendly_name string
param application_group_type string
param location string
param tags object

//Resource
resource application_group 'Microsoft.DesktopVirtualization/applicationgroups@2019-12-10-preview' = {
  name: applicaton_group_name
  location: location
  tags: tags
  properties: {
   applicationGroupType: application_group_type
   friendlyName: application_group_friendly_name 
   hostPoolArmPath: resourceId('Microsoft.DesktopVirtualization/hostpools/', '${hostpool_name}')
  }
}

//Outputs
output application_group_name string = application_group.name
