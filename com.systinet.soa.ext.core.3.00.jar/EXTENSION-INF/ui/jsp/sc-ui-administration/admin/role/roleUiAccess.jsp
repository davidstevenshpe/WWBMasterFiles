<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage" var="roleMsg" />

<c:choose>
	<c:when test="${not empty uiAccess}">
		<c:out value="${uiAccess}"></c:out>
	</c:when>
	<c:otherwise>
		<fmt:message key="role.noAccess" bundle="${roleMsg}" />									
	</c:otherwise>
</c:choose>
