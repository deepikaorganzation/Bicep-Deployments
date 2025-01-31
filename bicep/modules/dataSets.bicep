param factoryName string
param datasetName string
param linkedServiceName string
param containerName string
param fileName string

// Create the Azure Data Factory JSON Dataset
resource jsonDataset 'Microsoft.DataFactory/factories/datasets@2018-06-01' = {
  name: '${factoryName}/${datasetName}'
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

output datasetId string = jsonDataset.id
output datasetName string = jsonDataset.name
