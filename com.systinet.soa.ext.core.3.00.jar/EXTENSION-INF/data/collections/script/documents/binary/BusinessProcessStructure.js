{
  "id": "scriptsBusinessProcessStructurejs",
  "dataSource": "/scripts/BusinessProcessStructure.xml",
  
  /* optional setting - default value */
  "layers": {
    "label": "",
    "names": [
      "Level 1",
      "Level 2",
      "Level 3"
    ],
    "defaultName": "Level 3"
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
          "leafValue": [
            "Application Service",
            "Business Service",
            "Application Component"
          ],
          "name": "Type"
        }
      ]
    },
    {
      "label": "Background Color",
      "items": [
        {
          "type": "EA.portlets.visualization.LifecycleBasedBackgroundColorVisualization",
          "field": "lastApprovedStage",
          "name": "Lifecycle Stage"
        }
      ]
    }
  ]
}