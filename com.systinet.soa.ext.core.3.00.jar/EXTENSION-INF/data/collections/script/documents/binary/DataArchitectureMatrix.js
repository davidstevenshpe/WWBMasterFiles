/* ************************************************************************************ */
/* ************************************************************************************ */
/*  The script creates Data Objects usage across Application Services porlet            */
/* ************************************************************************************ */
/* ************************************************************************************ */
/* ************************************************************************************ */
{
  "name": "Data Objects usage across Application Services",
  "id": "scriptsDataObjectsVsApplicationServicesMatrixjs",
  "dataSource": "/scripts/ApplicationServiceToDataObject.xml",
  /* margin for graphic view area */
  "matrixMargin": {
    "top": 180,
    "right": 0,
    "bottom": 20,
    "left": 240
  },
  "colorSchema": {
    "enabledCell": "#08c",
    "disabledCell": "#ccc",
    /* Color of selected row and column title  */
    "selectedTitle": "red"
  },
  /* allow to enable menu on disable cell */
  "showDisabledCellMenu": true,
  "legend": "This report projects how Application Services access Data Objects which helps you analyze the organization of Application Services implementation. Access of same data by services could be a sign of duplication." 
}