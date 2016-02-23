<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${disable}">
	<div style="color:GRAY">${scopeView}</div>
</c:if>
<c:if test="${not disable}">
	<div>${scopeView}</div>
</c:if>