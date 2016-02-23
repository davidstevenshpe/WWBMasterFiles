<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="bulk.setGovernanceProcess.action.heading" var="setGovernanceProcessTitle" bundle="${messages}"/>
<fmt:message key="bulk.setGovernanceProcess.setButton.label" var="setLabel" bundle="${messages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:message key="Cancel" var="Cancel" bundle="${labels}" />

<syswf:control mode="script" action="prepareDialogSetProcess" caption="${controlName}">
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>

<syswf:control mode="script" action="setGovernanceProcess" caption="${prefix}setGovernanceProcess">
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>

<syswf:control mode="script" action="reset" caption="${prefix}cancel" />

<c:set var="bulkSetGovernanceProcessButtons">
	[{
	    text     : '${setLabel}',
	    disabled : true,
	    handler  : function() {
	        ${prefix}setGovernanceProcess();
	        SPopup.Window.Instance['bulkSetGovernanceProcessPopup_win'].hide();
	    },
	    id: 'bulkSetGovernanceProcess_okButton'
	},{
	    text     : '${Cancel}',
	    handler  : function(){
	        ${prefix}cancel();
	        SPopup.Window.Instance['bulkSetGovernanceProcessPopup_win'].hide();
	        return false;
	    },
	    id: 'bulkSetGovernanceProcess_cancelButton'
	}]
</c:set>

<c:if test="${not empty setProcessSettings.processSelectorBean.artifactsSdmNames}">
    <syswf:component name="/core/window" prefix="setGovernanceProcess">
		<syswf:param name="winId" value="bulkSetGovernanceProcessPopup_win" />
        <syswf:param name="winTitle">${setGovernanceProcessTitle}</syswf:param>
        <syswf:param name="winComponent" value="/newUi/lc/bulk/bulkSetGovernanceProcessWindow"/>
        <syswf:param name="winOpenFunctionName" value="${prefix}open" />
        <syswf:param name="winCustomButtons" value="${bulkSetGovernanceProcessButtons}" />               
        <syswf:param name="winRenderAlways" value="true" />        
        <syswf:param name="selectorBean" value="${setProcessSettings.processSelectorBean}" />
    </syswf:component>
    
    <script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        ${prefix}open();
    })
    
//]]>
</script>
</c:if>
