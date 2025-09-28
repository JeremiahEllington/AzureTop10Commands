// Resource Group is usually created outside Bicep (deployment target)
// Example of deploying a tag standardization policy assignment at RG scope

param location string = resourceGroup().location
param policyDisplayName string = 'Enforce Required Tags'

var requiredTags = [ 'env', 'owner', 'costCenter' ]

resource tagPolicy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'enforce-required-tags-example'
  properties: {
    policyType: 'Custom'
    mode: 'Indexed'
    displayName: policyDisplayName
    description: 'Ensures that required tags are set on resources.'
    metadata: {
      category: 'Tags'
    }
    parameters: {
      tagList: {
        type: 'Array'
        metadata: {
          displayName: 'Required Tags'
        }
      }
    }
    policyRule: {
      if: {
        anyOf: [
          for tagName in requiredTags: {
            field: '[concat(''tags['', tagName, '']'')]' // dynamic tag field
            exists: 'false'
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}

resource tagPolicyAssignment 'Microsoft.Authorization/policyAssignments@2022-06-01' = {
  name: 'require-standard-tags'
  properties: {
    displayName: policyDisplayName
    policyDefinitionId: tagPolicy.id
    parameters: {
      tagList: {
        value: requiredTags
      }
    }
  }
}
