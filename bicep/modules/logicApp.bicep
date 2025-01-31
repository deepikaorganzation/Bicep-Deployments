param logicAppName string
param location string = resourceGroup().location

param definition object

resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: logicAppName
  location: location
  properties: {
    definition: definition
  }
}

output logicAppId string = logicApp.id
output logicAppName string = logicApp.name
