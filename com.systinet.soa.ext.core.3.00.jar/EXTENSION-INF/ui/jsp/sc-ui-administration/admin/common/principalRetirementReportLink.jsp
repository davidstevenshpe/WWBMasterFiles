<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${category == 'ROLE' or category == 'GROUP' or category == 'USER'}">
        <syswf:component name="/core/impl/util/principalLinkRenderer" prefix="principalLink">
            <syswf:param name="customName" value="${caption}"/>
            <syswf:param name="principal" value="${resourceId}" />
        </syswf:component>
    </c:when>
    <c:when test="${category == 'ARTIFACT'}">
        <syswf:component name="/core/impl/util/artifactLinkRenderer" prefix="artifactLink">
            <syswf:param name="caption" value="${caption}" />
            <syswf:param name="uuid" value="${resourceId}" />
        </syswf:component>
    </c:when>
    <c:when test="${category == 'CONFIGURATION'}">
    	<c:out value="${resourceId}"/>
    </c:when>
    <c:otherwise>
        <c:out value="${caption}"/>
    </c:otherwise>
</c:choose>

