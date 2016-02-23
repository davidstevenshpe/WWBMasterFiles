<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n" />
<fmt:message var="title" key="uddi.import.window.title" bundle="${l10n}" />
<fmt:message var="buttonImportCaption" key="uddi.import.importButton" bundle="${l10n}" />
<fmt:message var="buttonCancelCaption" key="uddi.import.importCancel" bundle="${l10n}" />

<c:set var="registryImportButtons">
	[{
	    text     : '${buttonImportCaption}',            
	    handler  : function() {
	        ${prefix}doImport();
	        SPopup.Window.Instance['registryImportPopup_win'].hide();
	    },
	    id: 'registryImport_okButton'
	},{
	    text     : '${buttonCancelCaption}',
	    handler  : function(){
	        SPopup.Window.Instance['registryImportPopup_win'].hide();
	        return false;
	    },
	    id: 'registryImport_cancelButton'
	}]
</c:set>

<%-- action control - fires action after user presses OK --%>
<syswf:control mode="script" action="doImport" caption="${prefix}doImport" >
	<syswf:param name="tableSelectionBag" value="${tableSelectionBag}" />
</syswf:control>
                
<syswf:component name="/core/window" prefix="importFromUddi">
	<syswf:param name="winId" value="registryImportPopup_win" />
    <syswf:param name="winTitle" value="${title}" />
    <syswf:param name="winComponent" value="/integration2/uddi/import/registryImportSelector"/>
    <syswf:param name="winOpenFunctionName" value="${jsOpenWindow}" />
    <syswf:param name="winCustomButtons" value="${registryImportButtons}" />	
	<syswf:param name="winOkCustomButtonId" value="registryImport_okButton" />
    <syswf:param name="registryImportBean" value="${registryImportBean}" />
    <syswf:param name="tableSelectionBag" value="${tableSelectionBag}" />
    <syswf:param name="winWidth" value="630" />
	<syswf:param name="winButtonAlign" value="right" />
	<syswf:param name="winRenderAlways" value="true" />
</syswf:component>
