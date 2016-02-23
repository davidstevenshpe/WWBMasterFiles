<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />
<fmt:message key="rolesAssignment.scope.tooltip" var="tooltip" bundle="${domain_Messages}" />

<c:if test="${showTooltip eq 'true'}">
	<div title="${tooltip}" style="color:GRAY">${scopeView}</div>
</c:if>
<c:if test="${showTooltip eq 'false'}">
	<div>${scopeView}</div>
</c:if>