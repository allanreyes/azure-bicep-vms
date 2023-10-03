param location string = resourceGroup().location
param vmName string
param vnetName string
param nicName string
param pipName string
param nsgName string

module sshKey './modules/sshKey.bicep' = {
  name: 'sshKey'
  params:{
    sshKeyName: 'vmallanreyes-key'
    location: location
  }
}

module vnet './modules/vnet.bicep' = {
  name: 'vnet'
  params:{
    vnetName: vnetName
    location: location
  }
}

module nsg './modules/nsg.bicep' = {
  name: 'nsg'
  params:{
    nsgName: nsgName
    location: location
  }
}

// Creates 3 VMs with the same name but different suffixes

module vmNumber './modules/vm.bicep' = [for i in range(1, 3): {
  name: 'vm-${i}'
  params:{
    location: location
    nicName: '${nicName}-${i}'
    nsgId: nsg.outputs.nsgId
    pipName: '${pipName}-${i}'
    sshKeyPublicKey: sshKey.outputs.sshKey
    subnetId: vnet.outputs.subnetId
    vmName: '${vmName}-${i}'
  }
}]

// Creates 3 VMs with different names

var environment = [ 'dev', 'uat', 'prod' ]

module vm './modules/vm.bicep' = [for i in environment: {
  name: 'vm-${i}'
  params:{
    location: location
    nicName: '${nicName}-${i}'
    nsgId: nsg.outputs.nsgId
    pipName: '${pipName}-${i}'
    sshKeyPublicKey: sshKey.outputs.sshKey
    subnetId: vnet.outputs.subnetId
    vmName: '${vmName}-${i}'
  }
}]
