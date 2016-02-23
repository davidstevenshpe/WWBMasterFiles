/* ******************************************************* */
/* ******************************************************* */
/*  The script creates Portlet HeatMap:                    */
/*  Application Cloud Transformation                       */
/* ******************************************************* */
/* ******************************************************  */
/* ******************************************************* */
{
    "id": "scriptAppCloudTrans",
    "dataSource": "/scripts/ApplicationCloudTransformation.xml",
    "maxNode": 50,
    "densityVisualization": "Size",
    "specifiedTabId": "cloudMigration",
    "visualizations": [
    {
        "label": "Size",
        "items": [
            {
                "type": "EA.portlets.visualization.Visualization",
                "field": "totalCost",
                "name": "Total Cost",
                "description": ")* Size displays Annual Cost Total property in the financial profile",
                "isCostField": true
            },
            {
                "type": "EA.portlets.visualization.Visualization",
                "field": "transformationCost",
                "name": "Transformation Cost",
                "description": ")* Size displays Cost of Transformation (Cost property in the financial profile)",
                "isCostField": true
            },
            {
                "type": "EA.portlets.visualization.Visualization",
                "field": "annualCostHw",
                "name": "Hardware Cost",
                "description": ")*  Size displays Cost of Hardware (Cost property in the financial profile)",
                "isCostField": true
            },
            {
                "type": "EA.portlets.visualization.Visualization",
                "field": "overalAlignment",
                "name": "Overall Score",
                "description": ")*  Size displays Overall Alignment Score of application component",
                "init": function(item, raw) {
                    var n = 0, overalAlignment = 0;
                    if(raw.financialAlignment) {
                        overalAlignment += raw.financialAlignment;
                        n++;
                    }
                    if(raw.technicalAlignment) {
                        overalAlignment += raw.technicalAlignment;
                        n++;
                    }
                    if(raw.businessAlignment) {
                        overalAlignment += raw.businessAlignment;
                        n++;
                    }
                    if(n > 0) {
                        item.overalAlignment = Math.round(overalAlignment/n);
                    }
                    if(raw.minEstimatedHwCost) {
                        if(raw.annualCostHw) {
                            item.savingOpportunity = raw.annualCostHw - raw.minEstimatedHwCost;
                        } else if(raw.currentHwCostEstimate) {
                            item.savingOpportunity = raw.currentHwCostEstimate - raw.minEstimatedHwCost;
                        }
                    } else {
                        item.savingOpportunity = 0;
                    }

                    if(raw.transformationCost & item.savingOpportunity > 0) {
                        item.ROI = 100 * (item.savingOpportunity * 5  - raw.transformationCost) / raw.transformationCost;
                    } else {
                        item.savingOpportunity = 0;
                        item.ROI = 0;
                    }
                    raw.savingOpportunity = item.savingOpportunity;
                    item.ROI = Number(item.ROI).toFixed(2);
                    raw.ROI = item.ROI;
                }
            },
            {
                "type": "EA.portlets.visualization.Visualization",
                "field": "financialAlignment",
                "name": "Financial Score",
                "description": ")* Size displays Financial Alignment Score of application component"
            },
            {
                "type": "EA.portlets.visualization.Visualization",
                "field": "businessAlignment",
                "name": "Business Score",
                "description": ")* Size displays Business Alignment Score of application component"
            },
            {
                "type": "EA.portlets.visualization.Visualization",
                "field": "technicalAlignment",
                "name": "Technical Score",
                "description": ")* Size displays Technical Alignment Score of application component"
            },
            {
                "type": "EA.portlets.visualization.Visualization",
                "field": "minEstimatedHwCost",
                "name": "Min Est. Hardware Cost",
                "description": ")* Size displays the sum of all server costs for each infrastructure service (deployment) of the application component where for each deployment the cost of the cheapest data center is chosen. If there are no deployments/infrastructure services available we will use number of servers property and server class relationship for the value calculation.",
                "isCostField": true
            },
            {
                "type": "EA.portlets.visualization.Visualization",
                "field": "currentHwCostEstimate",
                "name": "Current Est. Hardware Cost",
                "description": ")* Size displays the sum of the costs of deployment into the current data center for all infrastructure services/deployments. (It is the sum of values from UI - Cloud Transformation/ Financial Alignment/Deployment Costs/Current Costs). If no infrastructure services are available, estimate from number of servers property and server class is taken.",
                "isCostField": true
            },
            {
                "type": "EA.portlets.visualization.Visualization",
                "field": "ROI",
                "name": "ROI (5 years)",
                "description": ")* Size displays ROI for the next 5 years"
            },{
                "type": "EA.portlets.visualization.Visualization",
                "field": "savingOpportunity",
                "name": "Savings Opportunity",
                "description": ")* Size displays potential Savings Opportunity if the application is deployed into the cheapest datacenter"
            }
        ]
    },
    {
        "label": "Color",
        "items": [
            {
                "type": "EA.portlets.visualization.SchemaLogicBasedVisualization",
                "field": "overalAlignment",
                "name": "Cloud Migration Compatibility",
                "description": "Cloud Migration Compatibility (calculated based on assessment overall score, migrated are those having a service design):",
                "styleSchema": {
                    "<b>Done:</b> Migrated": {
                        "style": "background-color:#3b8dd5;",
                        "conditions": " == value && node.get('hasServiceDesign') != 0 "
                    },
                    "<b>N/A:</b> Evaluate": {
                        "style": "background-color:#e7ebee;",
                        "conditions": " == null"
                    },
                    "<B>Unsuitable:</B> Re-architect": {
                        "style": "background-color:#f76c51;",
                        "conditions": " < 33 "
                    },
                    "<B>Candidate:</B> Adapt": {
                        "style": "background-color:#ffe554;",
                        "conditions": [" >= 33"," < 66 "]
                    },
                    "<B>Ready:</B> Transform": {
                        "style": "background-color:#00a276;",
                        "conditions": " >= 66"
                    }
                }
            },
            {
                "type": "EA.portlets.visualization.SchemaLogicBasedVisualization",
                "field": "overalAlignment",
                "name": "Overall Score",
                "description": "Recommendation calculated based on Overall Score:",
                "styleSchema": {
                    "Not Evaluated": {
                        "style": "background-color:#e7ebee;",
                        "conditions": " == null"
                    },
                    "<B>Unsuitable:</B> Re-architect": {
                        "style": "background-color:#f76c51;",
                        "conditions": " < 33 "
                    },
                    "<B>Candidate:</B> Adapt": {
                        "style": "background-color:#ffe554;",
                        "conditions": [" >= 33"," < 66 "]
                    },
                    "<B>Ready:</B> Transform": {
                        "style": "background-color:#00a276;",
                        "conditions": " >= 66"
                    }
                }
            },

            {
                "type": "EA.portlets.visualization.SchemaLogicBasedVisualization",
                "field": "financialAlignment",
                "name": "Financial Score",
                "description": "Recommendation calculated based on Financial Score:",
                "styleSchema": {
                    "<b>N/A:</b> Evaluate": {
                        "style": "background-color:#e7ebee;",
                        "conditions": " == null "
                    },
                    "<B>Unsuitable:</B> Re-architect": {
                        "style": "background-color:#f76c51;",
                        "conditions": " < 33 "
                    },
                    "<B>Candidate:</B> Adapt": {
                        "style": "background-color:#ffe554;",
                        "conditions": [" >= 33"," < 66 "]
                    },
                    "<B>Ready:</B> Transform": {
                        "style": "background-color:#00a276;",
                        "conditions": " >= 66"
                    }
                }
            },
            {
                "type": "EA.portlets.visualization.SchemaLogicBasedVisualization",
                "field": "businessAlignment",
                "name": "Business Score",
                "description": "Recommendation calculated based on Business Score:",
                "styleSchema": {
                    "<b>N/A:</b> Evaluate": {
                        "style": "background-color:#e7ebee;",
                        "conditions": " == null "
                    },
                    "<B>Unsuitable:</B> Re-architect": {
                        "style": "background-color:#f76c51;",
                        "conditions": " < 33 "
                    },
                    "<B>Candidate:</B> Adapt": {
                        "style": "background-color:#ffe554;",
                        "conditions": [" >= 33"," < 66 "]
                    },
                    "<B>Ready:</B> Transform": {
                        "style": "background-color:#00a276;",
                        "conditions": " >= 66"
                    }
                }
            },
            {
                "type": "EA.portlets.visualization.SchemaLogicBasedVisualization",
                "field": "technicalAlignment",
                "name": "Technical Score",
                "description": "Recommendation calculated based on Technical Score:",
                "styleSchema": {
                    "<b>N/A:</b> Evaluate": {
                        "style": "background-color:#e7ebee;",
                        "conditions": " == null "
                    },
                    "<B>Unsuitable:</B> Re-architect": {
                        "style": "background-color:#f76c51;",
                        "conditions": " < 33 "
                    },
                    "<B>Compatible:</B> Adapt": {
                        "style": "background-color:#ffe554;",
                        "conditions": [" >= 33"," < 66 "]
                    },
                    "<B>Ready:</B> Transform": {
                        "style": "background-color:#00a276;",
                        "conditions": " >= 66"
                    }
                }
            },
            {
                "type": "EA.portlets.visualization.MoneyBasedColorVisualization",
                "field": "totalCost",
                "name": "Total Cost",
                "description": "Application Total Cost:",
                "empty": "N/A",
                "styleSchema": "blue-gradient"
            },
            {
                "type": "EA.portlets.visualization.MoneyBasedColorVisualization",
                "field": "transformationCost",
                "name": "Transformation Cost",
                "description": "Application Transformation Cost:",
                "empty": "N/A",
                "styleSchema": "blue-gradient"
            },
            {
                "type": "EA.portlets.visualization.MoneyBasedColorVisualization",
                "field": "annualCostHw",
                "name": "Hardware Cost",
                "description": "Application Hardware Cost (from financial profile):",
                "empty": "N/A",
                "styleSchema": "blue-gradient"
            }
        ]
    },
    {
        "label": "Background Pattern",
        "items": [
            {
                "type": "EA.portlets.visualization.SchemaLogicBasedVisualization",
                "field": "transformationStrategy",
                "name": "Transformation Strategy",
                "description": "Transformation Strategy (Keep as-is includes all states except 'Transform'):",
                "styleSchema": {
                    "<b>Transform</b>": {
                        style: "border:none;",
                        class: "pattern diagonal-2",
                        "conditions": " == 123 || node.get('transformationStrategy')=='Transform'"
                    },
                    "<b>Keep as-is</b>": {
                        style: "",
                        "conditions": " == 123 || node.get('transformationStrategy')!='Transform'"
                    },
                }
            },

            {
                "type": "EA.portlets.visualization.CategoryBasedBorderVisualization",
                "field": "transformationStrategy",
                "showOnTooltip": false,
                "name": "N/A",
                "styleSchema": [{
                    style: "", hidden: true
                },{
                    style: "", hidden: true
                },{
                    style: "", hidden: true
                },{
                    style: "", hidden: true
                },{
                    style: "", hidden: true
                },{
                    style:"", hidden: true
                }]
            }]
    }
]
}