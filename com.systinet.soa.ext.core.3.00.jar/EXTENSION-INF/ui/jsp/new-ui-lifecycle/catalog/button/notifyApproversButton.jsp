<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="bean" type="com.hp.systinet.lifecycle.ui.catalog.button.NotifyApproversButton.Bean"--%>
<c:if test="${bean.enabled}">
    <fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
	<div class="EA-right-panel">
	    <a id="NotifyApprovers" href="javascript:void(0);" class="UI PageAction Notify">
	       <span><fmt:message key="notApp_buttonLabel" bundle="${messages}"/></span>
	    </a>
    </div>
    <syswf:control mode="script" caption="notifyApproversPost" action="request"/>

    <syswf:component name="/newUi/lc/common/dialog/messageInput" prefix="msgInput">
        <syswf:param name="title"><fmt:message key="notApp_dialogTitle" bundle="${messages}"/></syswf:param>
        <syswf:param name="subTitle"><fmt:message key="notApp_dialogText" bundle="${messages}"/></syswf:param>
        <syswf:param name="actionCaption"><fmt:message key="notApp_submitLabel" bundle="${messages}"/></syswf:param>
        <syswf:param name="windowId">NotifyApprovers</syswf:param>
        <syswf:param name="submitFunction">notifyApproversPost</syswf:param>
        <syswf:param name="msgBean" value="${bean}"/>
        <syswf:param name="msgProperty">inputText</syswf:param>
        <syswf:param name="maxLength">2000</syswf:param>
    </syswf:component>
<script type="text/javascript">
//<![CDATA[ 
Ext.onReady(function() {
	moveWindow('NotifyApprovers_content','popupWindows');
    });
//]]> 
</script>
</c:if>
