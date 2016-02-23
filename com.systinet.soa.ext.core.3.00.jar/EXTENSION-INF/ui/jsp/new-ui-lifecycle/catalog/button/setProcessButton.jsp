<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${this.buttonEnabled}">

    <fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
    <fmt:message key="setProcess_buttonLabel" var="setProcess_buttonLabel" bundle="${messages}"/>
    <fmt:message key="setProcess_buttonSetLabel" var="setProcess_buttonSetLabel" bundle="${messages}"/>
    <fmt:message key="setProcess_dialogTitle" var="setProcess_dialogTitle" bundle="${messages}"/>

    <fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
    <fmt:message bundle="${labels}" key="Cancel" var="Cancel" />

    <c:set var="icon">Ext.MessageBox.INFO</c:set>
    <c:set var="setProcessButtons">
        [{
            text     : '${setProcess_buttonSetLabel}',
            disabled : true,
            handler  : function() {
                setProcessPost();
                SPopup.Window.Instance['setProcessPopup_win'].hide();
            },
            id: 'setProcess_okButton'
        },{
            text     : '${Cancel}',
            handler  : function(){
                cancelProcessPost();
                SPopup.Window.Instance['setProcessPopup_win'].hide();
                return false;
            },
            id: 'setProcess_cancelButton'
        }]
    </c:set>
    <syswf:component name="/core/window" prefix="catMgm">
        <syswf:param name="winId" value="setProcessPopup_win" />
        <syswf:param name="winTitle">${setProcess_dialogTitle}</syswf:param>
        <syswf:param name="winComponent" value="/newUi/lc/common/dialog/setProcess"/>
        <syswf:param name="winCustomButtons" value="${setProcessButtons}" />
        <syswf:param name="winOpenFunctionName" value="SetProcess_open" />
        <syswf:param name="winWidth" value="400" />
        <syswf:param name="artifactUuid" value="${uuid}" />
        <syswf:param name="winRenderContents" value="true" />
        <syswf:param name="winForceRefresh" value="false" />
        <syswf:param name="setProcessBean" value="${bean}" />
    </syswf:component>
	
	<div class="EA-right-panel">
	    <a id="SetProcess_handler" href="javascript:void(0);" class="UI PageAction Edit">
	       <span><c:out value="${setProcess_buttonLabel}"/></span>
	    </a>
	</div>
	
    <script type="text/javascript">
//<![CDATA[
Ext.onReady(function() {
    attachOn('SetProcess_handler','click',function() {
        SetProcess_open();
        StartGovernance_enableOk();
    });
    moveWindow('setProcessPopup_win','popupWindows');
});

    
//]]>
</script>

</c:if>
