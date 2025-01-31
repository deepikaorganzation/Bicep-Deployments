param dataFactoryName string
param location string = resourceGroup().location
// Parameters for Blob Storage

param keyVaultName string
param blobStorageSecretName string


resource adf 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: dataFactoryName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    
    globalParameters: {
      isTrue: {
        type: 'Boolean'
        value: true
      }
      isFalse: {
        type: 'Boolean'
        value: false
      }
      environmentName: {
        type: 'String'
        value: 'Production'
      }
      apiKey: {
        type: 'String'
        value: 'your-api-key-here'
      }
    }
    
    
  }
}

// Linked Service for Azure Key Vault
resource keyVaultLinkedService 'Microsoft.DataFactory/factories/linkedservices@2018-06-01' = {
  name: 'AzureKeyVaultLinkedService'
  parent: adf
  properties: {
    type: 'AzureKeyVault'
    typeProperties: {
      // Referencing the Key Vault Secret
      baseUrl: 'https://${keyVaultName}.vault.azure.net/'
    }
  }
}

// Linked Service for Azure Blob Storage (with Key Vault secret reference)
resource blobStorageLinkedService 'Microsoft.DataFactory/factories/linkedservices@2018-06-01' = {
  name: 'AzureBlobStorageLinkedService'
  parent: adf
  properties: {
    type: 'AzureBlobStorage'
    typeProperties: {
      connectionString: {
        type: 'AzureKeyVaultSecret'
        store: {
          referenceName: 'AzureKeyVaultLinkedService'
          type: 'LinkedServiceReference'
        }
        secretName: blobStorageSecretName
      }
    }
  }
}

output keyVaultLinkedServiceId string = keyVaultLinkedService.id

output dataFactoryId string = adf.id
output blobLinkedServiceId string = blobStorageLinkedService.id
