<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<c:choose>
    <c:when test="${this.read and not this.write}">
        <div class="UI Icon ReadOnly">
            <span>
                <fmt:message key="acl.read" bundle="${widgetMessages}" />
            </span>
        </div>
    </c:when>
    <c:when test="${not this.read and this.write}">
        <div class="UI Icon Edit">
            <span>
                <fmt:message key="acl.write" bundle="${widgetMessages}" />
            </span>
        </div>
    </c:when>
    <c:when test="${this.read and this.write}">
        <div class="UI Icon Edit">
            <span>
                <fmt:message key="acl.readWrite" bundle="${widgetMessages}" />
            </span>
        </div>
    </c:when>
    <c:otherwise>
        <div class="UI Icon Delete">
            <span>
                <fmt:message key="acl.none" bundle="${widgetMessages}" />
            </span>
        </div>
    </c:otherwise>
</c:choose>