<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${not empty description and fn:length(description) > 0}">
<div>
	<i>
		<c:out value="${description}" escapeXml="fasle"/>
	</i>	
</div>
</c:if>