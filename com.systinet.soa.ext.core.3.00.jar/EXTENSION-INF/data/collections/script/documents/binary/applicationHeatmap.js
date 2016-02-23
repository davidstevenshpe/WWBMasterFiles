/* ******************************************************* */
/* ******************************************************* */
/*  The script creates Portlet HeatMap Report.             */                                                       
/* ******************************************************* */
/* ******************************************************  */
/* ******************************************************* */
{
  "id": "scriptsApplicationsByCostjs",
  "dataSource": "/scripts/ApplicationCost.xml",
  "costField": "costValue",
  "visualizations": [
    {
      "label": "Background Color",
      "items": [
        {
          "type": "EA.portlets.visualization.BackgroundColorVisualization",
          "field": "density",
          "name": "Entity health",
          "styleSchema": "entity-health",
          "showOnTooltip": false
        }
      ]
    },
    {
      "label": "Annual cost total",
      "items": [
        {
          "type": "EA.portlets.visualization.Visualization",
          "field": "costValue",
          "name": "Application Annual Cost Total",
          "description": ")* Rectangle surface area determines annual application costs",
		  "isCostField": true
        }
      ]
    }
  ]
}