<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--
Parameters:
   + report [REQUIRED] - instance of ReportArtifact
   + entityType [OPTIONAL] - one of value: Business Entity, Business Service, Binding Template, TModel
   + uddiEntityKey [OPTIONAL] - uddi entity key  
--%>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />
</c:if>

<c:choose>
    <c:when test="${not empty externalLink}">
        <a href="${externalLink}" target="_blank">${uddiEntityKey}</a>        
    </c:when>
    <c:otherwise>
        ${uddiEntityKey}
    </c:otherwise>
</c:choose>