<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.systinet.webfw.ui.FrameworkJspMessages" var="messages"/>

<fmt:message bundle="${messages}" key="lastKnownLocation_homepageCaption" var="homepageCaption"/>
<c:choose>
    <c:when test="${not empty taskState}">
        <syswf:control mode="anchor" caption="${caption}" id="${id}" targetDepth="${targetDepth}"
                       targetTask="${taskState.taskURI}"
                       params="${taskState.taskParameters}">
            <c:if test="${not empty displayClass}">
                <syswf:attribute name="class" value="${displayClass}"/>
            </c:if>
       </syswf:control>
    </c:when>
    <c:otherwise>
        <syswf:control mode="anchor" caption="${homepageCaption}" id="${id}" targetDepth="0"
                       targetTask="/">
            <c:if test="${not empty displayClass}">
                <syswf:attribute name="class" value="${displayClass}"/>
            </c:if>
       </syswf:control>
    </c:otherwise>
</c:choose>
