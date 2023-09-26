//Parameters
param virtual_network_name string
param location string
param virtual_network_address_space array
param virtual_network_dns_servers array
param virtual_network_subnets array
param tags object

//Resource
resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: virtual_network_name
  location: location
  tags: tags
  properties: {
    dhcpOptions:{
      dnsServers: virtual_network_dns_servers
    }
    addressSpace: {
      addressPrefixes: virtual_network_address_space
    }
    enableVmProtection: false
    enableDdosProtection: false
    subnets: virtual_network_subnets
  }
}


//Outputs
output virtualNetworkId string = vnet.id // output resourceId of virtual network
output virtualNetworkName string = vnet.name // output name of storage account
