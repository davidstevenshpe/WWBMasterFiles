<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${(mode eq 'view') and (not empty this.value)}">
    <a href="${this.targetUrl}" target="_blank"><c:out value="${this.value}" /></a>
</c:if>