/* ******************************************************* */
/* ******************************************************* */
/*  The script gets rating data of Artifacts.              */
/* ******************************************************* */
/* ******************************************************  */
/* ******************************************************* */
function getData(artifactType) {
  return Packages.com.hp.systinet.sc.ui.scripting.dataService.RatingReportService.getInstance().getRatingReportInformation(artifactType);
}