<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${enableExportToUddi}">
<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n" />
<fmt:message var="title" key="uddi.bulk.export.title" bundle="${l10n}" />
<fmt:message var="buttonExportCaption" key="uddi.bulk.export.buttonExport" bundle="${l10n}" />
<fmt:message var="buttonCancelCaption" key="uddi.bulk.export.buttonCancel" bundle="${l10n}" />

<%-- action control - fires action to check organization unit --%>
<syswf:control mode="script" action="initialize" caption="${prefix}initialize" >
	<syswf:param name="exportingArtifactSelection" value="${selectionBag}" />	
</syswf:control>

<script type="text/javascript">
//<![CDATA[

    var ${controlName} = function(){
        ${prefix}initialize();
    };

//]]>
</script>

<c:if test="${not empty openDialog}">
	<c:set var="bulkExportButton">
		[{
            text     : '${buttonExportCaption}',
            handler	 : function() {
                ${prefix}doExport();
                SPopup.Window.Instance['bulkExportPopup_win'].hide();
            },
            id       : 'bulkExport_okButton'
        },{
            text     : '${buttonCancelCaption}',
            handler  : function(){
                SPopup.Window.Instance['bulkExportPopup_win'].hide();
                return false;
            },
            id       : 'bulkExport_cancelButton'
        }]
	</c:set>

	<%-- action control - fires action after user presses OK --%>
	<syswf:control mode="script" action="doExport" caption="${prefix}doExport" >
	    <syswf:param name="tableSelectionBag" value="${tableSelectionBag}" />
	</syswf:control>
	                
	<syswf:component name="/core/window" prefix="bulkExport">
		<syswf:param name="winId" value="bulkExportPopup_win" />
	    <syswf:param name="winTitle" value="${title}" />
	    <syswf:param name="winComponent" value="/integration2/uddi/bulkExportWindow"/>
	    <syswf:param name="winOpenFunctionName" value="${prefix}openDialog" />
		<syswf:param name="winCustomButtons" value="${bulkExportButton}" />
		<syswf:param name="winOkCustomButtonId" value="bulkExport_okButton" />	    
	    <syswf:param name="exportBean" value="${exportBean}" />
		<syswf:param name="registryList" value="${registryList}" />
	    <syswf:param name="tableSelectionBag" value="${tableSelectionBag}" />		
		<syswf:param name="winButtonAlign" value="right" />
		<syswf:param name="winRenderAlways" value="true" />
		<syswf:param name="winWidth" value="680" />
	</syswf:component>
	
	<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){
    	${prefix}openDialog();
    });
    
//]]>
</script>
</c:if>
</c:if>