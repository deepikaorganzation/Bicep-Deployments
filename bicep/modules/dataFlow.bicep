param factoryName string
param dataFlowName string
param sourceDataset string
param sinkDataset string

// Create the Azure Data Factory Mapping Data Flow
resource dataFlow 'Microsoft.DataFactory/factories/dataflows@2018-06-01' = {
  name: '${factoryName}/${dataFlowName}'
  properties: {
    type: 'MappingDataFlow'
    typeProperties: {
      sources: [
        {
          dataset: {
            referenceName: sourceDataset
            type: 'DatasetReference'
          }
          name: 'source1'
        }
      ]
      sinks: [
        {
          dataset: {
            referenceName: sinkDataset
            type: 'DatasetReference'
          }
          name: 'sink1'
        }
      ]
      transformations: []  // You can add your transformations here
      scriptLines: []
    }
  }
}

output dataFlowId string = dataFlow.id
output dataFlowName string = dataFlow.name
