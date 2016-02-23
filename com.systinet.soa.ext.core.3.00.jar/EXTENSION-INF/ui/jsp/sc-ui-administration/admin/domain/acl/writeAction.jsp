<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />
<c:choose>
	<c:when test="${actionCheck.action eq 'WRITE'}">
		<fmt:message key="defaultAcl.table.action.yes.label" bundle="${domain_Messages}" />
	</c:when>
	<c:otherwise>
		<fmt:message key="defaultAcl.table.action.no.label" bundle="${domain_Messages}" />
	</c:otherwise>
</c:choose>
