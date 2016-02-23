<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty linkedArtifacts}">
    <c:forEach var="linkHolder" items="${linkedArtifacts}" varStatus="status">
        <c:choose>
            <c:when test="${not status.last or showMoreLink}" >
                <c:set var="suffix" value="," />
            </c:when>
            <c:otherwise>
                <c:set var="suffix" value="" />
            </c:otherwise>
        </c:choose>
        <syswf:component prefix="l${status.index}" name="/core/impl/util/artifactLinkRenderer" wrap="false">
            <syswf:param name="uuid" value="${linkHolder.uuid}"/>
            <syswf:param name="caption" value="${linkHolder.caption}"/>
            <syswf:param name="sdmName" value="${linkHolder.sdmName}"/>
            <syswf:param name="timeSlice" value="${linkHolder.timeSlice}" />
            <syswf:param name="suffix" value="${suffix}"/>
        </syswf:component>
    </c:forEach>
    <c:if test="${showMoreLink}">
        <syswf:component prefix="more" name="/core/impl/util/artifactLinkRenderer" wrap="false">
            <syswf:param name="uuid" value="${uuid}"/>
            <syswf:param name="caption" value="..."/>
            <syswf:param name="sdmName" value="${sdmName}"/>
        </syswf:component>
    </c:if>
</c:if>
