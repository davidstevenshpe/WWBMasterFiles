<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.systinet.platform.ui.TornadoUIMessages" var="tornadoui_Message"/>
<c:choose>
    <c:when test="${this.value eq 'true'}">
        <c:if test="${not empty this.trueStyle}">
            <span class="${not empty this.trueStyle}">
        </c:if>
        <fmt:message key="yes" bundle="${tornadoui_Message}"/>
        <c:if test="${not empty this.trueStyle}">
            </span>
        </c:if>
    </c:when>
    <c:otherwise>
        <c:if test="${not empty this.falseStyle}">
            <span class="${not empty this.falseStyle}">
        </c:if>
        <fmt:message key="no" bundle="${tornadoui_Message}"/>
        <c:if test="${not empty this.falseStyle}">
            </span>
        </c:if>
    </c:otherwise>
</c:choose>
