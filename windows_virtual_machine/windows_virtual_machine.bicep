// Parameters
param virtual_network_name string
param virtual_network_subnet_name string
param virtual_network_resource_group_name string
param vm_image_publisher string
param vm_image_offer string
param vm_windows_os_version string 
param vm_size string
param vm_disk_size int
param vm_name string
param vm_admin_username string
@secure()
param vm_admin_password string
param tags object
param location string
param count int

// Variables
var subnet_id = resourceId(virtual_network_resource_group_name,'Microsoft.Network/virtualNetworks/subnets', virtual_network_name, virtual_network_subnet_name)

// Resources
resource nic 'Microsoft.Network/networkInterfaces@2020-06-01' = [for i in range(0,count): {
  name: '${vm_name}${i}-nic01'
  location: location
  tags: tags
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnet_id
          }
        }
      }
    ]
  }
}]


resource vm 'Microsoft.Compute/virtualMachines@2020-06-01' = [for i in range(0,count): {
  name: '${vm_name}${i}'
  location: location
  tags: tags
  properties: {
    hardwareProfile: {
      vmSize: vm_size
    }
    osProfile: {
      computerName: '${vm_name}${i}'
      adminUsername: vm_admin_username
      adminPassword: vm_admin_password
    }
    storageProfile: {
      imageReference: {
        publisher: vm_image_publisher
        offer: vm_image_offer
        sku: vm_windows_os_version
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        name: '${vm_name}${i}-osdisk'
      }
      dataDisks: [
        {
          diskSizeGB: vm_disk_size
          lun: 0
          createOption: 'Empty'
          name: '${vm_name}${i}-datadisk01'
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic[i].id

        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}]
