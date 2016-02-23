<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n" />
<fmt:message var="importDialogTitle" key="uddi.artifact.import.window.title" bundle="${l10n}" />
<fmt:message var="buttonImportCaption" key="uddi.artifact.import.importButton" bundle="${l10n}" />
<fmt:message var="buttonCancelCaption" key="uddi.artifact.cancelButton" bundle="${l10n}" />

<div>
    <c:if test="${canImport}">
        <a href="javascript:void(0);" class="UI Icon Import" id="${prefix}importArtifactLink"><span>Import</span></a>
        
        <syswf:control mode="script" action="initializeImport" caption="${prefix}initializeImport" affects="."/>
        
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function(){
                attachOn('${prefix}importArtifactLink','click',function() {
                    ${prefix}initializeImport();
                }); 
            }); 
        
//]]>
</script>
    </c:if>

    <c:if test="${canExport}">
        <c:if test="${canImport}">&nbsp;|</c:if>
        
        <a href="javascript:void(0);" class="UI Icon EventExported" id="${prefix}exportArtifactLink"><span>Export</span></a>
        
        <syswf:control mode="script" action="initializeExport" caption="${prefix}initializeExport" affects="."/>
        
        <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function(){
            attachOn('${prefix}exportArtifactLink','click',function() {
                ${prefix}initializeExport();
                }); 
            });
        
//]]>
</script>
    </c:if>
    
    <c:if test="${canDelete}">
        <c:if test="${canImport or canExport}">&nbsp;|</c:if>
        
        <a href="javascript:void(0);" class="UI Icon Delete" id="${prefix}deleteArtifactLink"><span>Delete</span></a>   
        
        <syswf:control mode="script" action="initializeDelete" caption="${prefix}initializeDelete" affects="."/>
        
        <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function(){
            attachOn('${prefix}deleteArtifactLink','click',function() {
                ${prefix}initializeDelete();
                }); 
            });
        
//]]>
</script>
    </c:if>
</div>

<c:if test="${not empty openImportDialog}">
    <syswf:control mode="script" action="doImportArtifact" caption="${prefix}importArtifact" loadingMask="true"/>

	<c:set var="importArtifactButtons">
        [{
            text     : '${buttonImportCaption}',            
            handler  : function() {
                ${prefix}importArtifact();
                SPopup.Window.Instance['importArtifactPopup_win'].hide();
            },
            id       : 'importArtifact_okButton'
        },{
            text     : '${buttonCancelCaption}',
            handler  : function(){
                SPopup.Window.Instance['importArtifactPopup_win'].hide();
                return false;
            },
            id       : 'importArtifact_cancelButton'
        }]
    </c:set>
        
    <syswf:component name="/core/window" prefix="importArtifact">
		<syswf:param name="winId" value="importArtifactPopup_win" />
        <syswf:param name="winTitle" value="${importDialogTitle}" />
        <syswf:param name="winComponent" value="/integration2/uddi/artifact/actions/artifactImportWindow"/>
        <syswf:param name="winOpenFunctionName" value="${prefix}jsOpenImportArtifact" />
        <syswf:param name="winCustomButtons" value="${importArtifactButtons}" />
		<syswf:param name="winOkCustomButtonId" value="importArtifact_okButton" />
        <syswf:param name="artifactImportBean" value="${artifactImportBean}" />
        <syswf:param name="artifactName" value="${artifactName}" />
        <syswf:param name="winButtonAlign" value="right" />
        <syswf:param name="winRenderAlways" value="true" />
        <syswf:param name="winWidth" value="500" />
    </syswf:component>

    <script type="text/javascript">
//<![CDATA[

    ${prefix}jsOpenImportArtifact();
    
//]]>
</script>
</c:if>

<c:if test="${not empty openExportDialog}">
    <syswf:control mode="script" action="doExportArtifact" caption="${prefix}exportArtifact" loadingMask="true"/>

	<c:set var="exportArtifactButtons">
        [{
            text     : '${buttonFinishCaption}',            
            handler  : function() {
                ${prefix}exportArtifact();
                SPopup.Window.Instance['exportArtifactPopup_win'].hide();
            },
            id       : 'exportArtifact_okButton'
        },{
            text     : '${buttonCancelCaption}',
            handler  : function(){
                SPopup.Window.Instance['exportArtifactPopup_win'].hide();
                return false;
            },
            id       : 'exportArtifact_cancelButton'
        }]
    </c:set>
    
    <syswf:component name="/core/window" prefix="exportArtifact">
		<syswf:param name="winId" value="exportArtifactPopup_win" />
        <syswf:param name="winTitle" value="${dialogTitle}" />
        <syswf:param name="winComponent" value="/integration2/uddi/artifact/actions/artifactExportWindow"/>
        <syswf:param name="winOpenFunctionName" value="${prefix}jsOpenExportArtifact" />
        <syswf:param name="winCustomButtons" value="${exportArtifactButtons}" />
		<syswf:param name="winOkCustomButtonId" value="exportArtifact_okButton" />
        <syswf:param name="artifactExportBean" value="${artifactExportBean}" /> 
        <syswf:param name="tableSelectionBag" value="${tableSelectionBag}" />       
        <syswf:param name="winButtonAlign" value="right" />
        <syswf:param name="winRenderAlways" value="true" />
        <syswf:param name="winWidth" value="500" />
    </syswf:component>

    <script type="text/javascript">
//<![CDATA[

        ${prefix}jsOpenExportArtifact();
    
//]]>
</script>
</c:if>

<c:if test="${not empty openDeleteDialog}">
    <syswf:control mode="script" action="doDeleteArtifact" caption="${prefix}deleteArtifact" loadingMask="true"/>
    
	<c:set var="deleteArtifactButtons">
        [{
            text     : '${buttonFinishCaption}',            
            handler  : function() {
                ${prefix}deleteArtifact();
                SPopup.Window.Instance['deleteArtifactPopup_win'].hide();
            },
            id       : 'deleteArtifact_okButton'
        },{
            text     : '${buttonCancelCaption}',
            handler  : function(){
                SPopup.Window.Instance['deleteArtifactPopup_win'].hide();
                return false;
            },
            id       : 'deleteArtifact_cancelButton'
        }]
    </c:set>

    <syswf:component name="/core/window" prefix="deleteArtifact">
		<syswf:param name="winId" value="deleteArtifactPopup_win" />
        <syswf:param name="winTitle" value="${dialogTitle}" />
        <syswf:param name="winComponent" value="/integration2/uddi/artifact/actions/artifactExportWindow"/>
        <syswf:param name="winOpenFunctionName" value="${prefix}jsOpenDeleteArtifact" />
        <syswf:param name="winCustomButtons" value="${deleteArtifactButtons}" />
		<syswf:param name="winOkCustomButtonId" value="deleteArtifact_okButton" />
        <syswf:param name="artifactExportBean" value="${artifactExportBean}" /> 
        <syswf:param name="tableSelectionBag" value="${tableSelectionBag}" />       
        <syswf:param name="winButtonAlign" value="right" />
        <syswf:param name="winRenderAlways" value="true" />
        <syswf:param name="winWidth" value="500" />
    </syswf:component>

    <script type="text/javascript">
//<![CDATA[

        ${prefix}jsOpenDeleteArtifact();
    
//]]>
</script>
</c:if>