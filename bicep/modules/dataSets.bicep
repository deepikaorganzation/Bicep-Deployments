param factoryName string
param linkedServiceName string
param containerName string
param fileName string

// Create the Azure Data Factory JSON Dataset
resource jsonDataset1 'Microsoft.DataFactory/factories/datasets@2018-06-01' = {
  name: '${factoryName}/JsonDataset1'
  properties: {
    linkedServiceName: {
      referenceName: linkedServiceName
      type: 'LinkedServiceReference'
    }
    annotations: []
    type: 'Json'
    typeProperties: {
      location: {
        type: 'AzureBlobStorageLocation'
        fileName: fileName
        container: containerName
      }
    }
    schema: {
      type: 'Object'
      properties: {
        Name: {
          type: 'string'
        }
        Company: {
          type: 'string'
        }
      }
    }
  }
}

// Create the Azure Data Factory JSON Dataset
resource jsonDataset2 'Microsoft.DataFactory/factories/datasets@2018-06-01' = {
  name: '${factoryName}/JsonDataset2'
  properties: {
    linkedServiceName: {
      referenceName: linkedServiceName
      type: 'LinkedServiceReference'
    }
    annotations: []
    type: 'Json'
    typeProperties: {
      location: {
        type: 'AzureBlobStorageLocation'
        container: containerName
      }
    }
    schema: {}  // Empty schema as per the JSON provided
  }
}
output datasetId1 string = jsonDataset1.id
output datasetName1 string = jsonDataset1.name
output datasetId2 string = jsonDataset2.id
output datasetName2 string = jsonDataset2.name
