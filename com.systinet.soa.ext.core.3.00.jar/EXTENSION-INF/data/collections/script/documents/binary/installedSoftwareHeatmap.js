/* ******************************************************* */
/* ******************************************************* */
/*  The script creates Portlet HeatMap Report.             */
/* ******************************************************* */
/* ******************************************************  */
/* ******************************************************* */
{
  "id": "scriptsInstalledSoftwareHeatmapjs",
  "dataSource": "/scripts/InstalledSoftware.xml",
  "maxNode": 50,
  "costField": "costValue",
  "visualizations": [
    {
      "label": "Background color",
      "items": [
        {
          "type": "EA.portlets.visualization.LifecycleBasedBackgroundColorVisualization",
          "field": "stage",
          "name": "Stage"
        }
      ]
    },
    {
      "label": "Cost value",
      "items": [
        {
          "type": "EA.portlets.visualization.Visualization",
          "field": "costValue",
          "name": "Installations",
          "description": ")* Rectangular surface area determines number of deployments for the given software"
        }
      ]
    }
  ]
}