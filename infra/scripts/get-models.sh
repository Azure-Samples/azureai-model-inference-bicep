accountName=$(az cognitiveservices account list | jq -r 'first | .name')
resourceGroupName=$(az cognitiveservices account list | jq -r 'first | .resourceGroup')

#<list-models>
# Gets the last version of each model definition available in the GlobalStandard SKU
az cognitiveservices account  list-models --name $accountName --resource-group  $resourceGroupName | jq '[.[] | select(.skus | any(.name == "GlobalStandard"))] | group_by(.name) | map_values(last) | sort_by(.format) | [.[] | { name, version, provider: .format, sku: .skus[0].name }]'
#</list-models>
