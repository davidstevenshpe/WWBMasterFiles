<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage" 
	var="role_Messages" />
	
<c:choose>
	<c:when test="${not empty contains}">
		<c:out value="${contains}"></c:out>
	</c:when>
	<c:otherwise>
		<span class="Comment" style="color:GRAY">
			<fmt:message key="role.nocontains" bundle="${role_Messages}"/>
		</span>
	</c:otherwise>
</c:choose>
