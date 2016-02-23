<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.export.exportmessages" var="messages"/>

<c:set var="bundleKey" value="report.${this.status}" />
<fmt:message bundle="${messages}" key="${bundleKey}" var="statusLabel" />

<c:choose>
    <c:when test="${this.status eq 'CREATED' or this.status eq 'DELETED'}">
        <%-- Deleted happens in undo, where it's OK --%>
        <span class="UI Icon EventApproved"><span>${statusLabel}</span></span>
    </c:when>
    <c:when test="${this.status eq 'FAILED'}">
        <span class="UI Icon EventFailed"><span>${statusLabel}</span></span>
    </c:when>
    <c:when test="${this.status eq 'UPDATED'}">
        <span class="UI Icon EventApproved"><span>${statusLabel}</span></span>
    </c:when>
    <c:when test="${this.status eq 'SKIPPED'}">
        <span class="UI Icon EventInvalid"><span>${statusLabel}</span></span>
    </c:when>
    <c:when test="${this.status eq 'UNDONE'}">
        <span class="UI Icon EventApproved"><span>${statusLabel}</span></span>
    </c:when>
</c:choose>