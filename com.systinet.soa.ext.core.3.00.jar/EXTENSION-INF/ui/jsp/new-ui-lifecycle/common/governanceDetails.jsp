<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<c:if test="${not empty this.stageName}">
    <c:choose>
        <c:when test="${this.stageApproved}">
            <fmt:message key="governanceDetails_stageApproved" bundle="${messages}">
                <fmt:param><syswf:out value="${this.stageName}" context="HtmlBody"/></fmt:param>
            </fmt:message>
        </c:when>
        <c:otherwise>
            <c:out value="${this.stageName}" />
        </c:otherwise>
    </c:choose>

</c:if>