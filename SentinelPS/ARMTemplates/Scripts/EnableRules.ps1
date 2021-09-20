{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "location": {
            "type": "string",
            "minLength": 1,
            "defaultValue": "[resourceGroup().location]",
            "metadata": {
                "description": "Resource group to deploy solution resources"
            }
        },
        "workspaceName": {
            "defaultValue": "<Enter Log Analytics Workspace name>",
            "type": "string",
            "metadata": {
                "description": "Workspace name for Log Analytics where Sentinel is setup"
            }
        },
        "dataConnectorsKind": {
            "type": "array",
            "defaultValue": [],
            "metadata": {
                "description": "The kind of data connectors to enable"
            }
        },
        "ruleGuid": {
            "type": "string",
            "defaultValue": "[newGuid()]",
            "metadata": {
                "description": "The unique guid for this scheduled alert rule"
            }
        },
        "enableFusionAlert": {
            "type": "bool",
            "defaultValue": false
        },
        "enableMicrosoftAlerts": {
            "type": "bool",
            "defaultValue": false
        },
        "enableMLAlerts": {
            "type": "bool",
            "defaultValue": false
        }
    },
    "functions": [],
    "variables": {
        "ascRuleId": "[concat('asc', uniqueString(parameters('ruleGuid')))]",
        "mcasRuleId": "[concat('mcas', uniqueString(parameters('ruleGuid')))]",
        "aatpRuleId": "[concat('aatp', uniqueString(parameters('ruleGuid')))]",
        "mdatpRuleId": "[concat('mdatp', uniqueString(parameters('ruleGuid')))]",
        "aadipRuleId": "[concat('aadip', uniqueString(parameters('ruleGuid')))]",
        "o365RuleId": "[concat('o365', uniqueString(parameters('ruleGuid')))]",
        "fusionRuleId": "[concat('fusion', uniqueString(parameters('ruleGuid')))]",
        "mlbaSshRuleId": "[concat('mlSsh',uniqueString(parameters('ruleGuid')))]",
        "mlbaRdpRuleId": "[concat('mlRdp',uniqueString(parameters('ruleGuid')))]"

    },
    "resources": [
        {
            "condition": "[and(contains(parameters('dataConnectorsKind'), 'AzureActiveDirectory'),parameters('enableMicrosoftAlerts'))]",
            "type": "Microsoft.OperationalInsights/workspaces/providers/alertRules",
            "name": "[concat(parameters('workspaceName'),'/Microsoft.SecurityInsights/',variables('aadipRuleId'))]",
            "apiVersion": "2020-01-01",
            "kind": "MicrosoftSecurityIncidentCreation",
            "location": "[parameters('location')]",
            "dependsOn": [],
            "properties": {
                "alertRuleTemplateName": "532c1811-79ee-4d9f-8d4d-6304c840daa1",
                "description": "Create incidents based on Azure Active Directory Identity Protection alerts",
                "displayName": "Create incidents based on all alerts generated in Azure Active Directory Identity Protection",
                "enabled": true,
                "productFilter": "Azure Active Directory Identity Protection"
            }
        },
        {
            "condition": "[and(contains(parameters('dataConnectorsKind'), 'AzureSecurityCenter'),parameters('enableMicrosoftAlerts'))]",
            "type": "Microsoft.OperationalInsights/workspaces/providers/alertRules",
            "name": "[concat(parameters('workspaceName'),'/Microsoft.SecurityInsights/',variables('ascRuleId'))]",
            "apiVersion": "2020-01-01",
            "kind": "MicrosoftSecurityIncidentCreation",
            "location": "[parameters('location')]",
            "dependsOn": [],
            "properties": {
                "alertRuleTemplateName": "90586451-7ba8-4c1e-9904-7d1b7c3cc4d6",
                "description": "Create incidents based on Azure Security Center alerts",
                "displayName": "Create incidents based on all alerts generated in Azure Security Center",
                "enabled": true,
                "productFilter": "Azure Security Center"
            }
        },
        {
            "condition": "[and(contains(parameters('dataConnectorsKind'), 'AzureAdvancedThreatProtection'),parameters('enableMicrosoftAlerts'))]",
            "type": "Microsoft.OperationalInsights/workspaces/providers/alertRules",
            "name": "[concat(parameters('workspaceName'),'/Microsoft.SecurityInsights/',variables('aatpRuleId'))]",
            "apiVersion": "2020-01-01",
            "kind": "MicrosoftSecurityIncidentCreation",
            "location": "[parameters('location')]",
            "dependsOn": [],
            "properties": {
                "alertRuleTemplateName": "40ba9493-4183-4eee-974f-87fe39c8f267",
                "description": "Create incidents based on Azure Advanced Threat Protection alerts",
                "displayName": "Create incidents based on all alerts generated in Azure Advanced Threat Protection",
                "enabled": true,
                "productFilter": "Azure Advanced Threat Protection"
            }
        },
        {
            "condition": "[and(contains(parameters('dataConnectorsKind'), 'MicrosoftCloudAppSecurity'),parameters('enableMicrosoftAlerts'))]",
            "type": "Microsoft.OperationalInsights/workspaces/providers/alertRules",
            "name": "[concat(parameters('workspaceName'),'/Microsoft.SecurityInsights/',variables('mcasRuleId'))]",
            "apiVersion": "2020-01-01",
            "kind": "MicrosoftSecurityIncidentCreation",
            "location": "[parameters('location')]",
            "dependsOn": [],
            "properties": {
                "alertRuleTemplateName": "b3cfc7c0-092c-481c-a55b-34a3979758cb",
                "description": "Create incidents based on Microsoft Cloud App Security alerts",
                "displayName": "Create incidents based on all alerts generated in Microsoft Cloud App Security",
                "enabled": true,
                "productFilter": "Microsoft Cloud App Security"
            }
        },
        {
            "condition": "[and(contains(parameters('dataConnectorsKind'), 'Office365'),parameters('enableMicrosoftAlerts'))]",
            "type": "Microsoft.OperationalInsights/workspaces/providers/alertRules",
            "name": "[concat(parameters('workspaceName'),'/Microsoft.SecurityInsights/',variables('o365RuleId'))]",
            "apiVersion": "2020-01-01",
            "kind": "MicrosoftSecurityIncidentCreation",
            "location": "[parameters('location')]",
            "dependsOn": [],
            "properties": {
                "alertRuleTemplateName": "ee1d718b-9ed9-4a71-90cd-a483a4f008df",
                "description": "Create incidents based on all alerts generated in Office 365 Advanced Threat Protection",
                "displayName": "Create incidents based on Office 365 Advanced Threat Protection alerts",
                "enabled": true,
                "productFilter": "Office 365 Advanced Threat Protection"
            }
        },
        {
            "condition": "[and(contains(parameters('dataConnectorsKind'), 'MicrosoftDefenderAdvancedThreatProtection'),parameters('enableMicrosoftAlerts'))]",
            "type": "Microsoft.OperationalInsights/workspaces/providers/alertRules",
            "name": "[concat(parameters('workspaceName'),'/Microsoft.SecurityInsights/',variables('mdatpRuleId'))]",
            "apiVersion": "2020-01-01",
            "kind": "MicrosoftSecurityIncidentCreation",
            "location": "[parameters('location')]",
            "dependsOn": [],
            "properties": {
                "alertRuleTemplateName": "327cd4ed-ca42-454b-887c-54e1c91363c6",
                "description": "Create incidents based on Microsoft Defender Advanced Threat Protection alerts",
                "displayName": "Create incidents based on all alerts generated in Microsoft Defender Advanced Threat Protection",
                "enabled": true,
                "productFilter": "Microsoft Defender Advanced Threat Protection"
            }
        },
        {
            "condition": "[and(contains(parameters('dataConnectorsKind'), 'Syslog'),parameters('enableMLAlerts'))]",
            "type": "Microsoft.OperationalInsights/workspaces/providers/alertRules",
            "name": "[concat(parameters('workspaceName'),'/Microsoft.SecurityInsights/',variables('mlbaSshRuleId'))]",
            "apiVersion": "2020-01-01",
            "kind": "MLBehaviorAnalytics",
            "location": "[parameters('location')]",
            "dependsOn": [],
            "properties": {
                "enabled": true,
                "alertRuleTemplateName": "fa118b98-de46-4e94-87f9-8e6d5060b60b"
            }
        },
        {
            "condition": "[and(contains(parameters('dataConnectorsKind'), 'SecurityEvents'),parameters('enableMLAlerts'))]",
            "type": "Microsoft.OperationalInsights/workspaces/providers/alertRules",
            "name": "[concat(parameters('workspaceName'),'/Microsoft.SecurityInsights/',variables('mlbaRdpRuleId'))]",
            "apiVersion": "2020-01-01",
            "kind": "MLBehaviorAnalytics",
            "location": "[parameters('location')]",
            "dependsOn": [],
            "properties": {
                "enabled": true,
                "alertRuleTemplateName": "737a2ce1-70a3-4968-9e90-3e6aca836abf"
            }
        },
        {
            "condition": "[and(contains(parameters('dataConnectorsKind'), 'MicrosoftDefenderAdvancedThreatProtection'),parameters('enableMicrosoftAlerts'))]",
            "id": "[concat(resourceId('Microsoft.OperationalInsights/workspaces/providers', parameters('workspace'), 'Microsoft.SecurityInsights'),'/alertRules/2f120180-76dd-4aad-b593-54c5800b2265')]",
            "name": "[concat(parameters('workspace'),'/Microsoft.SecurityInsights/2f120180-76dd-4aad-b593-54c5800b2265')]",
            "type": "Microsoft.OperationalInsights/workspaces/providers/alertRules",
            "kind": "Scheduled",
            "apiVersion": "2021-03-01-preview",
            "properties": {
                "displayName": "Anomalous sign-in location by user account and authenticating application",
                "description": "This query over Azure Active Directory sign-in considers all user sign-ins for each Azure Active \nDirectory application and picks out the most anomalous change in location profile for a user within an \nindividual application. An alert is generated for recent sign-ins that have location counts that are anomalous\nover last day but also over the last 3-day and 7-day periods.\nPlease note that on workspaces with larger volume of Signin data (~10M+ events a day) may timeout when using this default query time period.\nIt is recommended that you test and tune this appropriately for the workspace.",
                "severity": "Medium",
                "enabled": true,
                "query": "let lookBack_long = 7d;\nlet lookBack_med = 3d;\nlet lookBack = 1d;\nlet aadFunc = (tableName:string){\ntable(tableName)\n| where TimeGenerated >= startofday(ago(lookBack_long))\n| extend DeviceDetail = todynamic(DeviceDetail), Status = todynamic(DeviceDetail), LocationDetails = todynamic(LocationDetails)\n| extend locationString = strcat(tostring(LocationDetails.countryOrRegion), \"/\", tostring(LocationDetails.state), \"/\", tostring(LocationDetails.city), \";\") \n| project TimeGenerated, AppDisplayName , UserPrincipalName, locationString \n// Create time series \n| make-series dLocationCount = dcount(locationString) on TimeGenerated in range(startofday(ago(lookBack_long)),now(), 1d) \nby UserPrincipalName, AppDisplayName \n// Compute best fit line for each entry \n| extend (RSquare,Slope,Variance,RVariance,Interception,LineFit)=series_fit_line(dLocationCount) \n// Chart the 3 most interesting lines  \n// A 0-value slope corresponds to an account being completely stable over time for a given Azure Active Directory application\n| where Slope > 0.3\n| top 50 by Slope desc\n| join kind = leftsemi (\ntable(tableName)\n| where TimeGenerated >= startofday(ago(lookBack_med))\n| extend DeviceDetail = todynamic(DeviceDetail), Status = todynamic(DeviceDetail), LocationDetails = todynamic(LocationDetails)\n| extend locationString = strcat(tostring(LocationDetails.countryOrRegion), \"/\", tostring(LocationDetails.state), \"/\", tostring(LocationDetails.city), \";\") \n| project TimeGenerated, AppDisplayName , UserPrincipalName, locationString \n| make-series dLocationCount = dcount(locationString) on TimeGenerated in range(startofday(ago(lookBack_med)) ,now(), 1d) \nby UserPrincipalName, AppDisplayName \n| extend (RSquare,Slope,Variance,RVariance,Interception,LineFit)=series_fit_line(dLocationCount)\n| where Slope > 0.3\n| top 50 by Slope desc\n) on UserPrincipalName, AppDisplayName\n| join kind = leftsemi (\ntable(tableName)\n| where TimeGenerated >= startofday(ago(lookBack))\n| extend DeviceDetail = todynamic(DeviceDetail), Status = todynamic(DeviceDetail), LocationDetails = todynamic(LocationDetails)\n| extend locationString = strcat(tostring(LocationDetails.countryOrRegion), \"/\", tostring(LocationDetails.state), \"/\", tostring(LocationDetails.city), \";\") \n| project TimeGenerated, AppDisplayName , UserPrincipalName, locationString \n| make-series dLocationCount = dcount(locationString) on TimeGenerated in range(startofday(ago(lookBack)) ,now(), 1d) \nby UserPrincipalName, AppDisplayName \n| extend (RSquare,Slope,Variance,RVariance,Interception,LineFit)=series_fit_line(dLocationCount)\n| where Slope > 5\n| top 50 by Slope desc\n// Higher threshold requirement on last day anomaly\n) on UserPrincipalName, AppDisplayName\n| extend timestamp = TimeGenerated, AccountCustomEntity = UserPrincipalName\n};\nlet aadSignin = aadFunc(\"SigninLogs\");\nlet aadNonInt = aadFunc(\"AADNonInteractiveUserSignInLogs\");\nunion isfuzzy=true aadSignin, aadNonInt",
                "queryFrequency": "P1D",
                "queryPeriod": "P14D",
                "triggerOperator": "GreaterThan",
                "triggerThreshold": 0,
                "suppressionDuration": "PT5H",
                "suppressionEnabled": false,
                "tactics": [
                    "InitialAccess"
                ],
                "alertRuleTemplateName": "7cb8f77d-c52f-4e46-b82f-3cf2e106224a",
                "incidentConfiguration": {
                    "createIncident": true,
                    "groupingConfiguration": {
                        "enabled": true,
                        "reopenClosedIncident": false,
                        "lookbackDuration": "PT5H",
                        "matchingMethod": "AllEntities",
                        "groupByEntities": [],
                        "groupByAlertDetails": [],
                        "groupByCustomDetails": []
                    }
                },
                "eventGroupingSettings": {
                    "aggregationKind": "SingleAlert"
                },
                "alertDetailsOverride": null,
                "customDetails": null,
                "entityMappings": [
                    {
                        "entityType": "Account",
                        "fieldMappings": [
                            {
                                "identifier": "FullName",
                                "columnName": "AccountCustomEntity"
                            }
                        ]
                    }
                ]
            }
        },
        {
            "condition": "[and(contains(parameters('dataConnectorsKind'), 'MicrosoftDefenderAdvancedThreatProtection'),parameters('enableMicrosoftAlerts'))]",
            "id": "[concat(resourceId('Microsoft.OperationalInsights/workspaces/providers', parameters('workspace'), 'Microsoft.SecurityInsights'),'/alertRules/9e7dbd35-22e2-4809-b6e3-370f13831b1c')]",
            "name": "[concat(parameters('workspace'),'/Microsoft.SecurityInsights/9e7dbd35-22e2-4809-b6e3-370f13831b1c')]",
            "type": "Microsoft.OperationalInsights/workspaces/providers/alertRules",
            "kind": "Scheduled",
            "apiVersion": "2021-03-01-preview",
            "properties": {
                "displayName": "Attempts to sign in to disabled accounts",
                "description": "Identifies failed attempts to sign in to disabled accounts across multiple Azure Applications.\nDefault threshold for Azure Applications attempted to sign in to is 3.\nReferences: https://docs.microsoft.com/azure/active-directory/reports-monitoring/reference-sign-ins-error-codes\n50057 - User account is disabled. The account has been disabled by an administrator.",
                "severity": "Medium",
                "enabled": true,
                "query": "let threshold = 3;\nlet aadFunc = (tableName:string){\ntable(tableName)\n| where ResultType == \"50057\"\n| where ResultDescription =~ \"User account is disabled. The account has been disabled by an administrator.\"\n| summarize StartTime = min(TimeGenerated), EndTime = max(TimeGenerated), applicationCount = dcount(AppDisplayName), \napplicationSet = make_set(AppDisplayName), count() by UserPrincipalName, IPAddress, Type\n| where applicationCount >= threshold\n| extend timestamp = StartTime, AccountCustomEntity = UserPrincipalName, IPCustomEntity = IPAddress\n};\nlet aadSignin = aadFunc(\"SigninLogs\");\nlet aadNonInt = aadFunc(\"AADNonInteractiveUserSignInLogs\");\nunion isfuzzy=true aadSignin, aadNonInt",
                "queryFrequency": "P1D",
                "queryPeriod": "P1D",
                "triggerOperator": "GreaterThan",
                "triggerThreshold": 0,
                "suppressionDuration": "PT5H",
                "suppressionEnabled": false,
                "tactics": [
                    "InitialAccess"
                ],
                "alertRuleTemplateName": "75ea5c39-93e5-489b-b1e1-68fa6c9d2d04",
                "incidentConfiguration": {
                    "createIncident": true,
                    "groupingConfiguration": {
                        "enabled": true,
                        "reopenClosedIncident": false,
                        "lookbackDuration": "PT5H",
                        "matchingMethod": "AllEntities",
                        "groupByEntities": [],
                        "groupByAlertDetails": [],
                        "groupByCustomDetails": []
                    }
                },
                "eventGroupingSettings": {
                    "aggregationKind": "SingleAlert"
                },
                "alertDetailsOverride": null,
                "customDetails": null,
                "entityMappings": [
                    {
                        "entityType": "Account",
                        "fieldMappings": [
                            {
                                "identifier": "FullName",
                                "columnName": "AccountCustomEntity"
                            }
                        ]
                    },
                    {
                        "entityType": "IP",
                        "fieldMappings": [
                            {
                                "identifier": "Address",
                                "columnName": "IPCustomEntity"
                            }
                        ]
                    }
                ]
            }
        },
        {
            "condition": "[parameters('enableFusionAlert')]",
            "type": "Microsoft.OperationalInsights/workspaces/providers/alertRules",
            "name": "[concat(parameters('workspaceName'),'/Microsoft.SecurityInsights/',variables('fusionRuleId'))]",
            "apiVersion": "2020-01-01",
            "kind": "Fusion",
            "location": "[parameters('location')]",
            "dependsOn": [],
            "properties": {
                "enabled": true,
                "alertRuleTemplateName": "f71aba3d-28fb-450b-b192-4e76a83015c8"
            }
        }
    ],
    "outputs": {
        "ruleId": {
            "type": "string",
            "value": "[parameters('ruleGUID')]"
        }
    }
}
