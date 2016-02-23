<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${isAccessGranted}">

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="user_Messages" />
<fmt:message key="editUsers.setUserDefaultDomain_title" bundle="${user_Messages}" var="select_title"/>

<syswf:component name="/core/window" prefix="setUsersDefaultDomainWindow">
    <syswf:param name="winTitle" value="${select_title}" />
    <syswf:param name="winComponent" value="/admin/common/domainSelectorWindow"/>
    <syswf:param name="winOpenFunctionName" value="${controlName}" />
    <syswf:param name="winOkAction" value="${prefix}setUsersDefaultDomain" />
    <syswf:param name="winOkLabel" value="Select" />
    <syswf:param name="selectedDomainHolder" value="${selectedDomainHolder}" />	
	<syswf:param name="winButtonAlign" value="right" />
</syswf:component>
<%-- action control - fires action after user presses OK --%>
<syswf:control mode="script" action="setUsersDefaultDomain" caption="${prefix}setUsersDefaultDomain">
	<syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>

</c:if>