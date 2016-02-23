/* ******************************************************* */
/* ******************************************************* */
/*  The script creates Structure Map Portlet.              */
/* ******************************************************* */
/* ******************************************************  */
/* ******************************************************* */
{
  "id": "scriptsCapabilityToProjectMappingjs",
  "dataSource": "/scripts/BusinessFunctions.xml",
  "dataSourceExtraParams": {
    "plateauArtifactUuid": "ac4d3412-a45f-474f-b711-be6de01229e7"
    /* optional setting
       maxDepth: number,
       maxResults: number,
       seed: 'uuid seed artifact'
     */
  },
  /* optional setting - default value */
  "layers": {
    "label": "",
    "names": [
      "Level 1",
      "Level 2",
      "Level 3",
      "Level 4"
    ],
    "defaultName": "Level 3"
  },
  "drillDown": true,
  "visualizations": [
    {
      "label": "Background Color",
      "items": [
        {
          "type": "EA.portlets.visualization.MoneyBasedColorVisualization",
          "field": "plannedCost",
          "name": "Project Planned Cost",
          "description": "*) Accumulated planned cost of projects linked to the given business function via 'realizes' relationship",
          "styleSchema": "blue-gradient"
        },
        {
          "type": "EA.portlets.visualization.MoneyBasedColorVisualization",
          "field": "actualCost",
          "name": "Project Actual Cost",
          "description": "*) Accumulated actual cost of projects linked to the given business function via 'realizes' relationship",
          /* styleSchema - optional setting
           * Predefined styleSchemas:
           * 'pastel-colors': yellow, green, sky-blue, sea-blue, orange, pink
           * 'bright-colors': light-green, light-blue, light-pink, light-yellow, light-orange, light-red
           * 'blue-gradient': white to deep blue
           * 'yellow-gradient': white to dark yellow
           */
          "styleSchema": "yellow-gradient"
        },
        {
          "type": "EA.portlets.visualization.LifecycleBasedBackgroundColorVisualization",
          "field": "lastApprovedStage",
          "name": "Lifecycle Stage",
          "description": "*) Shows current lifecycle stage of the business function/capability"
        },
        {
          "type": "EA.portlets.visualization.PlateauBasedBackgroundColorVisualization",
          "field": "tobeArchitectureStage",
          "name": "To Be Architecture Stage"
        },
        {
          "type": "EA.portlets.visualization.CategoryBasedBackgroundColorVisualization",
          "field": "businessFunctionType",
          "name": "Business Function Type",
          "description": "*) Shows business function 'type' property value",
          "styleSchema": {
            "Innovation": {
              "style": "background-color:#FFD800;",
              "desc": "Innovation"
            },
            "Differentiator": {
              "style": "background-color:#49B250;",
              "desc": "Differentiator"
            },
            "Commodity": {
              "style": "background-color:#BEE8FE;",
              "desc": "Commodity"
            },
            "N/A": {
              "style": "background-color:#FFFFFF;",
              "desc": "Not Set"
            }
          }
        }
      ]
    },
    {
      "label": "Frame width",
      "items": [
        {
          "type": "EA.portlets.visualization.CategoryBasedBorderVisualization",
          "field": "businessFunctionStatus",
          "name": "Business Function Status",
          "description": "**) Long term plan for the business function/capability defined by the 'status' property",
          "styleSchema": {
            "Strategic": {
              "style": "border: 4px solid #000;"
            },
            "Maintained": {
              "style": "border: 1px solid #000;"
            },
            "To be Retired": {
              "style": "border: 1px dashed #000;"
            }
          }
        },
        {
          "type": "EA.portlets.visualization.CategoryBasedBorderVisualization",
          "field": "investmentPriority",
          "name": "Investment Priority",
          "description": "**) Current investment plan priority",
          
          /* styleSchema - optional setting
           * Predefined styleSchemas:
           * '2-red-framing': normal border, bold red border
           * '2-line-style': normal line, bold line.
           * '3-line-style': normal line, dashed line, bold line.
           * '4-line-style': dotted-line, dashed line, normal line, bold line
           */
          "styleSchema": {
            "High": {
              "style": "border: 4px solid #000;"
            },
            "Medium": {
              "style": "border: 1px solid #000;"
            },
            "Low": {
              "style": "border: 1px dashed #000;"
            }
          }
        }
      ]
    }
  ]
}