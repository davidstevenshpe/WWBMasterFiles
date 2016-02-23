<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${not empty location}">
    <c:choose>
        <c:when test="${validArtifact}">
            <c:if test="${empty title}">
                <c:set var="title" value="${location}"/>
            </c:if>
            <a <c:if test="${not empty className}">class="<c:out value="${className}"/>" </c:if>href="${targetUrl}" target="_blank"><c:out value="${title}"/></a>
        </c:when>
        <c:otherwise>
           ${location}
        </c:otherwise>
    </c:choose>
</c:if>