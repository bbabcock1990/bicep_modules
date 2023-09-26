//Parameters
param virtual_network_name string
param location string
param address_prefix array
param dns_servers array
param subnets array
param tags object

//Resource
resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: virtual_network_name
  location: location
  tags: tags
  properties: {
    dhcpOptions:{
      dnsServers: dns_servers
    }
    addressSpace: {
      addressPrefixes: address_prefix
    }
    enableVmProtection: false
    enableDdosProtection: false
    subnets: subnets
  }
}


//Outputs
output virtualNetworkId string = vnet.id // output resourceId of virtual network
output virtualNetworkName string = vnet.name // output name of storage account
