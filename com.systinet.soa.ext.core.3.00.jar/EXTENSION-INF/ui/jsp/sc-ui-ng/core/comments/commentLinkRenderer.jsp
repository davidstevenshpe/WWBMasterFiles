<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
    <c:when test="${not empty artifactTaskUri && not disableLink}">
        <syswf:control mode="anchor" caption="${caption}" hint="${hint}" targetTask="${artifactTaskUri}" targetDepth="${depth}">
            <syswf:param name="view" value="${view}"/>
            <syswf:param name="artifactTabId" value="comments"/>
            <syswf:param name="commentId" value="${commentId}"/>
            <syswf:param name="threadId" value="${threadId}"/>
            <syswf:param name="discussionMode">${viewMode}</syswf:param>
            <syswf:param name="sortInfo">${sort}</syswf:param>
            <c:if test="${not empty class}">
                <syswf:attribute name="class" value="${class}"/>
            </c:if>
        </syswf:control>
    </c:when>
    <c:when test="${not empty caption}">
        ${caption}
    </c:when>
</c:choose>
