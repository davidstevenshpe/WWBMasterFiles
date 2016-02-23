<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="bundle"/>

<fmt:message var="title" key="manageUIRoles.title" bundle="${bundle}"/>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${title}" />
</syswf:component>

<syswf:component name="/core/table" prefix="uirolelist" wrap="false">
    <syswf:param name="customizationId" value="admin.uirole.browseUIRoleTable" />
    <syswf:param name="title" value="UI Roles"/>
</syswf:component>