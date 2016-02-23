<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.pushnotification.ui.notificationMessages" var="messages"/>
<fmt:message key="notificationEditor.selectRecipientsTitle" var="selectRecipientsTitle" bundle="${messages}"/>

<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="controlName" type="java.lang.String"--%>
<%--@elvariable id="recipientsHolder" type="com.hp.systinet.pushnotification.ui.action.AddRecipients.RecipientsHolder"--%>

<syswf:component name="/core/principal/selector" prefix="addApproverPricipalSelector">
    <syswf:param name="jsOpenFunction" value="${prefix}openSelectorAddRecipients"/>
    <syswf:param name="windowTitle" value="${selectRecipientsTitle}"/>
    <syswf:param name="overrideselectionModel" value="multiple"/>
    <syswf:param name="holder" value="${recipientsHolder}"/>
</syswf:component>

<syswf:control mode="script" caption="${controlName}" onSubmit="${prefix}openSelectorAddRecipients" affects=".."/>