<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
    <c:when test="${empty dataRow}">
        <c:set var="class" value="UI Icon Contact" />
        <c:set var="text" value="${name}" />
    </c:when>

    <c:when test="${dataRow['a._sdmName'] eq 'personArtifact'}">
        <c:set var="class" value="UI Icon Contact" />
        <c:set var="text" value="${dataRow['a.name']}" />
    </c:when>
    
    <c:when test="${dataRow['a._sdmName'] eq 'organizationUnitArtifact'}">
         <c:set var="class" value="UI Icon OrganizationUnit" />
         <c:set var="text" value="${dataRow['a.name']}" />
    </c:when>
</c:choose>

<span class="${class}" >${text}</span>

