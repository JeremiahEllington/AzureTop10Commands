param vnetName string
param location string

resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [ '10.10.0.0/16' ]
    }
    subnets: [
      {
        name: 'snet-app'
        properties: {
          addressPrefix: '10.10.1.0/24'
        }
      }
      {
        name: 'snet-data'
        properties: {
          addressPrefix: '10.10.2.0/24'
        }
      }
    ]
  }
}
