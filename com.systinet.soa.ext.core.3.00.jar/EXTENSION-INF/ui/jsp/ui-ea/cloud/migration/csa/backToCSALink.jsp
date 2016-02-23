<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${not empty baseUrl}">
		<li class="csa-icon back"><a class="csa-icon back ${styleClass}" href="${baseUrl}${emPath}"></a></li>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>
