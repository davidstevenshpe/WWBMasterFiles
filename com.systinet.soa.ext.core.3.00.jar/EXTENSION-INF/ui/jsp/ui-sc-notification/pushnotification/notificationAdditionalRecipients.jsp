<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.pushnotification.ui.notificationMessages" var="messages"/>
<fmt:message key="notificationEditor.addOtherRecipients" var="addOtherRecipients" bundle="${messages}"/>

<%--@elvariable id="recipientsBean" type="com.hp.systinet.pushnotification.ui.NotificationRecipientsSelector.Bean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<c:choose>
    <c:when test="${empty recipientsBean.innerPrincipals}">
        <syswf:component name="/pushnotification/action/addRecipientsAction" prefix="addRecipientsActionPrefix">
            <syswf:param name="datasource" value="${recipientsBean.datasource}"/>
            <syswf:param name="controlName" value="${prefix}invokeSelector"/>
            <syswf:param name="updateRegionId" value="${prefix}"/>
        </syswf:component>
        <syswf:control mode="postAnchor" caption="${addOtherRecipients}" onSubmit="${prefix}invokeSelector">
            <syswf:attribute name="class" value="UI Icon Add"/>
        </syswf:control>
    </c:when>
    <c:otherwise>
        <syswf:component name="/core/table" prefix="editApproversTable">
            <syswf:param name="customizationId" value="shared.pushnotification.additionalRecipients"/>
            <syswf:param name="datasource" value="${recipientsBean.datasource}"/>
            <syswf:param name="updateRegionId" value="${prefix}"/>
        </syswf:component>
    </c:otherwise>
</c:choose>
