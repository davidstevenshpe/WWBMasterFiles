<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="bean" type="com.hp.systinet.lifecycle.ui.catalog.button.RequestApprovalButton.Bean"--%>
<c:if test="${bean.enabled}">
    <fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

	<c:if test="${insideTaskBox eq 'false' }">
		<c:set value="EA-right-panel" var="className"/>
	</c:if>

	<div class="${className}">
	    <a id="RequestApproval" href="javascript:void(0);" class="UI PageAction ApprovalRequest">
	       <span><fmt:message key="reqApp_buttonLabel" bundle="${messages}"/></span>
	    </a>
	</div>
	
    <syswf:control mode="script" caption="requestApprovalPost" action="request"/>

    <syswf:component name="/newUi/lc/common/dialog/messageInput" prefix="msgInput">
        <syswf:param name="title"><fmt:message key="reqApp_dialogTitle" bundle="${messages}"/></syswf:param>
        <syswf:param name="subTitle"><fmt:message key="reqApp_dialogText" bundle="${messages}"/></syswf:param>
        <syswf:param name="actionCaption"><fmt:message key="reqApp_submitLabel" bundle="${messages}"/></syswf:param>
        <syswf:param name="windowId">RequestApproval</syswf:param>
        <syswf:param name="submitFunction">requestApprovalPost</syswf:param>
        <syswf:param name="msgBean" value="${bean}"/>
        <syswf:param name="msgProperty">inputText</syswf:param>
        <syswf:param name="maxLength">2000</syswf:param>
    </syswf:component>
    <script type="text/javascript">
//<![CDATA[
Ext.onReady(function() {
    <c:if test="${not empty callbackFunction}">
    	${callbackFunction}();  
	</c:if>
    });
//]]>
</script>
   
</c:if>
