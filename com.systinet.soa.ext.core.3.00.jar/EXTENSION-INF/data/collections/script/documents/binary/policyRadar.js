/* ******************************************************* */
/* ******************************************************* */
/*  The script creates Policy Radar Chart.                 */
/* ******************************************************* */
/* ******************************************************  */
/* ******************************************************* */
function getConfig(){
	var config = {};
  
	/* CUSTOM Policy Reports  */
	config.reports = [];
  	//config.reports = ['Uuid of Policy Report 1', 'Uuid of Policy Report 2', 'Uuid of Policy Report ...'];

	config.id="policyRadarChart";

	config.label="Policy Radar";

	/* CUSTOM STYLE  */
	config.height =405;

	/* theme: "Category1" to "Category6", default is "Base" */
	
	//config.theme = "Category1";

	/* show markers: default is true */
	
	//config.showMarkers = false;
  
	return config;
}