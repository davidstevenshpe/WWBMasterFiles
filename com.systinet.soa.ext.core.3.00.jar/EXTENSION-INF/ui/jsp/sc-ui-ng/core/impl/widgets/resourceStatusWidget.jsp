<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<c:set var="bundleKey" value="resourceStatus.${this.resourceStatus}"/>
<fmt:message var="resourceStatusLabel" key="${bundleKey}" bundle="${widgetMessages}"/>

<c:choose>
    <c:when test="${this.resourceStatus eq 'WARNING'}">
        <span class="UI Icon Warning"><span>${resourceStatusLabel}</span></span>
    </c:when>
    <c:when test="${this.resourceStatus eq 'ERROR'}">
        <span class="UI Icon Error"><span>${resourceStatusLabel}</span></span>
    </c:when>
    <c:when test="${this.resourceStatus eq 'OK'}">
        <span class="UI Icon Completed"><span>${resourceStatusLabel}</span></span>
    </c:when>
    
    <c:when test="${this.resourceStatus eq 'RESTORED'}">
        <span class="UI Icon Completed"><span>${resourceStatusLabel}</span></span>
    </c:when>
    <c:when test="${this.resourceStatus eq 'PURGED'}">
        <span class="UI Icon Completed"><span>${resourceStatusLabel}</span></span>
    </c:when>
    <c:when test="${this.resourceStatus eq 'FAILED'}">
        <span class="UI Icon Error"><span>${resourceStatusLabel}</span></span>
    </c:when>
</c:choose>