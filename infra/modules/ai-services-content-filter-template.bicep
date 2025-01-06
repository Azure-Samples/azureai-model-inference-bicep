@description('Name of the Azure AI Services account where the policy will be created')
param accountName string

@description('Name of the policy to be created')
param policyName string

@allowed(['Asynchronous_filter', 'Blocking', 'Default', 'Deferred'])
param mode string = 'Default'

@description('Base policy to be used for the new policy')
param basePolicyName string = 'Microsoft.DefaultV2'

param contentFilters array = [
  {
      name: 'Violence'
      severityThreshold: 'Medium'
      blocking: true
      enabled: true
      source: 'Prompt'
  }
  {
      name: 'Hate'
      severityThreshold: 'Medium'
      blocking: true
      enabled: true
      source: 'Prompt'
  }
  {
      name: 'Sexual'
      severityThreshold: 'Medium'
      blocking: true
      enabled: true
      source: 'Prompt'
  }
  {
      name: 'Selfharm'
      severityThreshold: 'Medium'
      blocking: true
      enabled: true
      source: 'Prompt'
  }
  {
      name: 'Jailbreak'
      blocking: true
      enabled: true
      source: 'Prompt'
  }
  {
      name: 'Indirect Attack'
      blocking: true
      enabled: true
      source: 'Prompt'
  }
  {
      name: 'Profanity'
      blocking: true
      enabled: true
      source: 'Prompt'
  }
  {
      name: 'Violence'
      severityThreshold: 'Medium'
      blocking: true
      enabled: true
      source: 'Completion'
  }
  {
      name: 'Hate'
      severityThreshold: 'Medium'
      blocking: true
      enabled: true
      source: 'Completion'
  }
  {
      name: 'Sexual'
      severityThreshold: 'Medium'
      blocking: true
      enabled: true
      source: 'Completion'
  }
  {
      name: 'Selfharm'
      severityThreshold: 'Medium'
      blocking: true
      enabled: true
      source: 'Completion'
  }
  {
      name: 'Protected Material Text'
      blocking: true
      enabled: true
      source: 'Completion'
  }
  {
      name: 'Protected Material Code'
      blocking: false
      enabled: true
      source: 'Completion'
  }
  {
      name: 'Profanity'
      blocking: true
      enabled: true
      source: 'Completion'
  }
]

resource raiPolicy 'Microsoft.CognitiveServices/accounts/raiPolicies@2024-06-01-preview' = {
    name: '${accountName}/${policyName}'
    properties: {
        mode: mode
        basePolicyName: basePolicyName
        contentFilters: contentFilters
    }
}
