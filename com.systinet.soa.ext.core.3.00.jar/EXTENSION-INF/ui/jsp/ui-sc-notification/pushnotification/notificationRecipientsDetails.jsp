<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%-- parameter "recipientResolverType"  - 1 = contact --%>
<%-- parameter "resolverId"             - generated resolver id --%>
<%-- parameter "recipientBeanMap"       - map of recipients for the recipient resolver --%>
<%-- parameter "recipientsBean"         - bean of notification recipient selector --%>
<%-- parameter "recipientResolver"      - recipient resolver --%>
<%-- parameter "mode"                   - "edit" for editor, "view" for preview --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="recipientResolverType" type="java.lang.Integer"--%>
<%--@elvariable id="resolverId" type="java.lang.String"--%>
<%--@elvariable id="recipientBeanMap" type="java.util.Map"--%>
<%--@elvariable id="recipientsBean" type="com.hp.systinet.pushnotification.ui.NotificationRecipientsSelector.Bean"--%>
<%--@elvariable id="recipientResolver" type="com.hp.systinet.pushnotification.api.resolver.recipient.RecipientResolver"--%>
<%--@elvariable id="mode" type="java.lang.String"--%>

<c:choose>
    <c:when test="${recipientResolverType eq 1}">
        <%--contacts--%>
        <syswf:component prefix="${resolverId}Selector" wrap="false"
                         name="/pushnotification/notificationRecipientsSelectorByRole">
            <syswf:param name="resolverId" value="${resolverId}"/>
            <syswf:param name="recipientBeanMap" value="${recipientBeanMap}"/>
            <syswf:param name="recipientsBean" value="${recipientsBean}"/>
            <syswf:param name="recipientResolverId" value="${recipientResolver.id}"/>
            <syswf:param name="mode" value="${mode}"/>
        </syswf:component>
    </c:when>
    <c:otherwise>
        <%--all others--%>
        <syswf:component prefix="${resolverId}Selector" wrap="false"
                         name="/pushnotification/notificationRecipientsList">
            <syswf:param name="selectorVariable" value="${resolverId}"/>
            <syswf:param name="recipientBeanList" value="${recipientBeanMap['DUMMY_KEY']}" />
            <syswf:param name="separateWithEndash" value="true" />
        </syswf:component>
    </c:otherwise>
</c:choose>
