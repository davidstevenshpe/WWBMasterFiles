<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n" />
<fmt:message var="title" key="uddi.taxonomy.import.title" bundle="${l10n}" />
<fmt:message var="buttonImportCaption" key="uddi.taxonomy.import.buttonImport" bundle="${l10n}" />
<fmt:message var="buttonCancelCaption" key="uddi.taxonomy.buttonCancel" bundle="${l10n}" />

<c:if test="${canImport}">
	<div class="EA-right-panel">
		<a id="ImportArtifact" href="javascript:void(0);" class="UI PageAction Import"><span><syswf:out value="${title}" context="HtmlBody"/></span></a>
	</div>
	<c:set var="importButtons">
        [{
            text     : '${buttonImportCaption}',
            handler	 : function() {
                ${prefix}doImport();
                SPopup.Window.Instance['importTaxonomyPopup_win'].hide();
            },
            id       : 'importTaxonomy_okButton'
        },{
            text     : '${buttonCancelCaption}',
            handler  : function(){
                SPopup.Window.Instance['importTaxonomyPopup_win'].hide();
                return false;
            },
            id       : 'importTaxonomy_cancelButton'
        }]
    </c:set>
	
	<%-- action control - fires action after user presses OK --%>
	<syswf:control mode="script" action="doImport" caption="${prefix}doImport" />
	                
	<syswf:component name="/core/window" prefix="taxonomyImport">
		<syswf:param name="winId" value="importTaxonomyPopup_win" />
	    <syswf:param name="winTitle" value="${title}" />
	    <syswf:param name="winComponent" value="/integration2/uddi/taxonomy/taxonomyImportWindow"/>
	    <syswf:param name="winOpenFunctionName" value="${prefix}openDialog" />
	    <syswf:param name="winCustomButtons" value="${importButtons}" />
		<syswf:param name="winOkCustomButtonId" value="importTaxonomy_okButton" />
	    <syswf:param name="importExportBean" value="${importExportBean}" />
	    <syswf:param name="selectionBag" value="${selectionBag}" />		
	    <syswf:param name="isImporting" value="1" />	
		<syswf:param name="winButtonAlign" value="right" />
		<syswf:param name="winRenderAlways" value="true" />
		<syswf:param name="winWidth" value="610" />		
	</syswf:component>
	
	<script type="text/javascript">
//<![CDATA[

		attachOn('ImportArtifact','click',${prefix}openDialog);
	
//]]>
</script>
</c:if>

