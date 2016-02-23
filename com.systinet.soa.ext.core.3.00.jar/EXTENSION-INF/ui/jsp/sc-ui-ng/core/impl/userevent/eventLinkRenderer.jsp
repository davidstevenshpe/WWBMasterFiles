<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.userevent.componentsusereventmessages" var="messages"/>

<%--@elvariable id="eventBean" type="com.hp.systinet.userevent.UserEvent"--%>
<%--@elvariable id="delegateComponent" type="com.hp.systinet.userevent.UserEvent"--%>
<%--@elvariable id="styleClass" type="java.lang.String"--%>
<%--@elvariable id="newFlag" type="java.lang.Boolean"--%>
<%--@elvariable id="showNewFlag" type="java.lang.Boolean"--%>
<c:set var="link">
    <syswf:component prefix="eventLink_${eventBean.id}" name="${delegateComponent}"
                     wrap="false">
        <syswf:param name="eventBean" value="${eventBean}"/>
        <syswf:param name="styleClass" value="${styleClass}"/>
    </syswf:component>
</c:set>
<c:choose>
    <c:when test="${showNewFlag and newFlag}">
        <div class="UI Align">
            <div class="Right"><span class="Text FlagNew IconAlign"><fmt:message key="events.newLabel"
                                                                                 bundle="${messages}"/></span></div>
            <div class="Left NewEventLabel">${link}</div>
        </div>
    </c:when>
    <c:otherwise>${link}</c:otherwise>
</c:choose>

