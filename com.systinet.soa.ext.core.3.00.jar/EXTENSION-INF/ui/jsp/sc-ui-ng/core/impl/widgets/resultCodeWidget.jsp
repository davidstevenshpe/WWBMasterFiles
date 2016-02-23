<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<c:set var="bundleKey" value="resultCode.${this.resultCode}"/>
<fmt:message var="resultCodeLabel" key="${bundleKey}" bundle="${widgetMessages}"/>

<c:choose>
    <c:when test="${this.resultCode.warning}">
        <span class="UI Icon EventRejected"><span>${resultCodeLabel}</span></span>
    </c:when>
    <c:when test="${this.resultCode.error}">
        <span class="UI Icon EventFailed"><span>${resultCodeLabel}</span></span>
    </c:when>
    <c:otherwise>
        <span class="UI Icon EventApproved"><span>${resultCodeLabel}</span></span>
    </c:otherwise>
</c:choose>
