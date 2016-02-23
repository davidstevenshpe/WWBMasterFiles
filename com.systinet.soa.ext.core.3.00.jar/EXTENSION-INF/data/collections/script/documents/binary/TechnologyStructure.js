{
  "id": "scriptsCapabilitiesToComponentsMappingjs",
  "dataSource": "/scripts/BusinessFunctionsWithComponents.xml",
  "transformData": {
    "type": "EA.portlets.transformation.LastLevelTransformation",
    "field": "_sdmName",
    "value": "applicationComponentArtifact"
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
    "defaultName": "Level 4"
  },
  "drillDown": true,
  "visualizations": [
    {
      "label": "Box Type",
      "hideMenu": true,
      "items": [
        {
          "type": "EA.portlets.visualization.LeafNodeVisualization",
          "field": "sdmName",
          /* extra information should show on node label */
          "leafValue": "Application Component",
          "extraProperty": "sdmName",
          "name": "Type"
        }
      ]
    },
    {
      "label": "System Software Lifecycle",
      "hideMenu": true,
      "showOnTooltip": false,
      "items": [
        {
          "type": "EA.scripts.SystemSoftwareLifecycleVisualization",
          "field": "systemSoftware",
          "name": "Software Lifecycle"
        }
      ]
    },
    {
      "label": "Background Color",
      "items": [
        {
          "type": "EA.portlets.visualization.CategoryBasedBackgroundColorVisualization",
          "field": "businessFunctionType",
          "name": "Business Function Type",
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
        },
        {
          "type": "EA.portlets.visualization.LifecycleBasedBackgroundColorVisualization",
          "field": "lastApprovedStage",
          "name": "Lifecycle Stage"
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