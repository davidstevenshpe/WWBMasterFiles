<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:control id="${prefix}storeStages" mode="script" action="storeStages" affects="." caption="${prefix}storeStages" />
<syswf:input id="${prefix}selectedStagesCsv" name="selectedStagesCsv" value="" mode="hidden"/>

<script type="text/javascript">
//<![CDATA[

    function ${controlName}(){
        getSelectedStagesCsv('${prefix}selectedStagesCsv');

        //inline action
        if (Ext.get('${prefix}selectedStagesCsv').dom.value == ""){
        	Ext.get('${prefix}selectedStagesCsv').dom.value = Ext.get('editStageId').dom.value;
        }
        
        ${prefix}storeStages();
    }

//]]>
</script>
