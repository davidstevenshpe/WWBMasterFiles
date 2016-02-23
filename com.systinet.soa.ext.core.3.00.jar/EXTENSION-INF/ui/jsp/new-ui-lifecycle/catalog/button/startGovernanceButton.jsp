<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${this.canStartGovernance}">

    <fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
    <fmt:message key="startGov_buttonLabel" var="startGov_buttonLabel" bundle="${messages}"/>
    <fmt:message key="startGov_dialogTitle" var="startGov_dialogTitle" bundle="${messages}"/>
    <fmt:message key="startGov_dialogText" var="startGov_dialogText" bundle="${messages}"/>

    <fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
    <fmt:message bundle="${labels}" key="OK" var="OK" />
    <fmt:message bundle="${labels}" key="Cancel" var="Cancel" />

    <syswf:control mode="script" caption="startDefaultGovernancePost" action="startDefaultGovernanceAction"/>

    <c:set var="icon">Ext.MessageBox.INFO</c:set>    
    <c:set var="startGovernanceButtons">
        [{
            text     : '${OK}',
            disabled : true,
            handler  : function() {
                startGovernancePost();
                SPopup.Window.Instance['startGovernancePopup_win'].hide();
            },
            id: 'startGovernance_okButton'
        },{
            text     : '${Cancel}',
            handler  : function(){
                SPopup.Window.Instance['startGovernancePopup_win'].hide();
                return false;
            },
            id: 'startGovernance_cancelButton'
        }]
    </c:set>
    <syswf:component name="/core/window" prefix="catMgm">
        <syswf:param name="winId" value="startGovernancePopup_win" />
        <syswf:param name="winTitle">${startGov_dialogTitle}</syswf:param>
        <syswf:param name="winComponent" value="/newUi/lc/catalog/button/startGovernance"/>
        <syswf:param name="winCustomButtons" value="${startGovernanceButtons}" />
        <syswf:param name="winOpenFunctionName" value="StartGovernance_open" />
        <syswf:param name="winWidth" value="400" />
        <syswf:param name="artifactUuid" value="${uuid}" />
		<syswf:param name="hasDefaultProcess" value="${this.hasDefaultProcess}" />
        <syswf:param name="winRenderContents" value="true" />
        <syswf:param name="winForceRefresh" value="false" />
    </syswf:component>
	<div class="EA-right-panel">
	    <a id="StartGovernance_handler" href="javascript:void(0);" class="UI PageAction StartGovernance">
	       <span><c:out value="${startGov_buttonLabel}"/></span>
	    </a>
	</div>    
    <script type="text/javascript">
//<![CDATA[
Ext.onReady(function() {
    attachOn('StartGovernance_handler','click',function() {
        <c:if test="${not this.hasDefaultProcess}">
            StartGovernance_open();
            StartGovernance_enableOk();    
        </c:if>
        <c:if test="${this.hasDefaultProcess}">
            startDefaultGovernancePost();
        </c:if>
    });
    // moveWindow('startGovernancePopup_win','popupWindows');
});
//]]>
</script>
</c:if>
