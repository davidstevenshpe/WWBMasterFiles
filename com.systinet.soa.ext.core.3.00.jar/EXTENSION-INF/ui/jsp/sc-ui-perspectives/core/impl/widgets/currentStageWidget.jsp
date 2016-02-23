<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<fmt:setBundle basename="com.systinet.webfw.UIFramework" var="UIMessage"/>

<c:choose>
    <c:when test="${this.approved}">
        <syswf:out value="${this.currentStage}" context="HtmlBody"/> (<fmt:message key="MESSAGE_Approved" bundle="${UIMessage}" />)
    </c:when>
    <c:otherwise>
        <syswf:out value="${this.currentStage}" context="HtmlBody"/>
    </c:otherwise>
</c:choose>