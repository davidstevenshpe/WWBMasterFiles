<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n" />
<fmt:message var="title" key="uddi.taxonomy.export.title" bundle="${l10n}" />
<fmt:message var="buttonExportCaption" key="uddi.taxonomy.export.buttonExport" bundle="${l10n}" />
<fmt:message var="buttonCancelCaption" key="uddi.taxonomy.buttonCancel" bundle="${l10n}" />

<c:if test="${canExport}">
	<div class="EA-right-panel">
		<a id="ExportArtifact" href="javascript:void(0);" class="UI PageAction Export"><span><syswf:out value="${title}" context="HtmlBody"/></span></a>
	</div>
	<c:set var="exportButtons">
        [{
            text     : '${buttonExportCaption}',            
            handler  : function() {
                ${prefix}doExport();
                SPopup.Window.Instance['exportTaxonomyPopup_win'].hide();
            },
            id       : 'exportTaxonomy_okButton'
        },{
            text     : '${buttonCancelCaption}',
            handler  : function(){
                SPopup.Window.Instance['exportTaxonomyPopup_win'].hide();
                return false;
            },
            id       : 'exportTaxonomy_cancelButton'
        }]
    </c:set>
	
	<%-- action control - fires action after user presses OK --%>
	<syswf:control mode="script" action="doExport" caption="${prefix}doExport" >
		<syswf:param name="selectionBag" value="${selectionBag}" />
	</syswf:control>
	                
	<syswf:component name="/core/window" prefix="taxonomyExport">
		<syswf:param name="winId" value="exportTaxonomyPopup_win" />
	    <syswf:param name="winTitle" value="${title}" />
	    <syswf:param name="winComponent" value="/integration2/uddi/taxonomy/taxonomyImportWindow"/>
	    <syswf:param name="winOpenFunctionName" value="${prefix}openDialog" />
		<syswf:param name="winCustomButtons" value="${exportButtons}" />
		<syswf:param name="winOkCustomButtonId" value="exportTaxonomy_okButton" />	    
	    <syswf:param name="importExportBean" value="${importExportBean}" />
	    <syswf:param name="selectionBag" value="${selectionBag}" />		
	    <syswf:param name="isImporting" value="0" />
		<syswf:param name="winButtonAlign" value="right" />
		<syswf:param name="winRenderAlways" value="true" />
		<syswf:param name="winWidth" value="610" />		
	</syswf:component>
	
	<script type="text/javascript">
//<![CDATA[

		attachOn('ExportArtifact','click',${prefix}openDialog);
	
//]]>
</script>
</c:if>

