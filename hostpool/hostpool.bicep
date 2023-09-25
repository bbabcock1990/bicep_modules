//Paramaters
param name string
param personal_desktop bool
param hostpool_friendly_name string
param hostpool_description string
param location string
param tags object
param date string = utcNow('yyyy-MM-ddTHH:mm:ss.fffffffZ')

// Variables
var expirationTime = dateTimeAdd(date, 'PT8H')

//Resource
resource hostpool 'Microsoft.DesktopVirtualization/hostpools@2019-12-10-preview' = {
  name: name
  location: location
  tags: tags
  properties: {
   friendlyName: hostpool_friendly_name
   description:  hostpool_description
   hostPoolType: personal_desktop ? 'Personal' : 'Pooled' // If True-->Personal Desktops, else --> Pooled Desktops
   loadBalancerType: personal_desktop ? 'Persistent' : 'DepthFirst' // If Personal Desktop = True-->Persistent, else --> Pooled Desktops Depth First
   preferredAppGroupType: 'Desktop'
   registrationInfo:{
     expirationTime: expirationTime
     token: ''
     registrationTokenOperation: 'Update'
   }
  }
}




//Outputs
output hostpool_name string = hostpool.name // output resourceId of virtual network
output hostpool_token string = hostpool.properties.registrationInfo.token // output resourceId of virtual network
