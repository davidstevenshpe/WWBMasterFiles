/* ******************************************************* */
/* ******************************************************* */
/*  The script creates Portlet HeatMap Report.             */                                                       
/* ******************************************************* */
/* ******************************************************  */
/* ******************************************************* */
{
  "id": "scriptsProjectsByCostjs",
  "dataSource": "/scripts/ProjectCost.xml",
  "costField": "costValue",
  "visualizations": [
    {
      "label": "Background color",
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
      "label": "Projects By Cost",
      "items": [
        {
          "type": "EA.portlets.visualization.Visualization",
          "field": "costValue",
          "name": "Planned Cost",
          "description": ")* Rectangular surface area determines planned project costs",
		  "isCostField": true
        }
      ]
    }
  ]
}