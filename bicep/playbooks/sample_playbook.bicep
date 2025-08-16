param location string

// Stub for Logic App (Playbook) - Expand with full Logic App definition as needed
resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: 'SampleTrainingPlaybook'
  location: location
  properties: {
    state: 'Enabled'
    definition: {
      '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
      contentVersion: '1.0.0.0'
      actions: {}
      triggers: {}
    }
  }
}