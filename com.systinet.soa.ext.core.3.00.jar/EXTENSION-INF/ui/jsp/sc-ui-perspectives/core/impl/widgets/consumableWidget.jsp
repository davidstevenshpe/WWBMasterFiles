<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${this.canBeProvider}">
    <fmt:setBundle basename="com.systinet.platform.ui.TornadoUIMessages" var="tornadoui_Message"/>
    <c:choose>
        <c:when test="${this.consumable}">
            <fmt:message key="yes" bundle="${tornadoui_Message}"/>
        </c:when>
        <c:otherwise>
            <fmt:message key="no" bundle="${tornadoui_Message}"/>
        </c:otherwise>
    </c:choose>
</c:if>

