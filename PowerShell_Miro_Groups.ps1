$Bearer = Read-Host -Prompt 'Please paste your SCIM Api token:'
Invoke-RestMethod -Method Get -Uri "https://miro.com/api/v1/scim/Groups" -ContentType "application/json" -Headers @{Authorization = "Bearer $bearer "} | select Resources  -ExpandProperty Resources | select displayName,id

$Team = Read-Host -Prompt 'Copy/Paste or type the ID that you want to decouple:'
$Name = Read-Host -Prompt 'Type and match your Azure AD security group name:'

$body = @"
{
  "schemas": [
    "urn:ietf:params:scim:api:messages:2.0:PatchOp"
  ],
  "Operations": [
    {
      "op": "Replace",
      "path": "displayName",
      "value": "$Name"
    }
  ]
}
"@
Invoke-RestMethod -Method Patch -Uri "https://miro.com/api/v1/scim/Groups/$Team" -ContentType "application/json" -Headers @{Authorization = "$Bearer"} -body $body
