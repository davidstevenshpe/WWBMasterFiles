<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="notify.preview.defaultCaption" var="title" bundle="${messages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:message bundle="${labels}" key="Close" var="Close" />

<%--@elvariable id="sessionStack" type="com.systinet.webfw.CarryBag"--%>
<%--@elvariable id="notificationDescriptor" type="com.hp.systinet.pushnotification.api.NotificationDescriptor"--%>
<%--@elvariable id="notificationData" type="java.lang.Object"--%>
<%--@elvariable id="customFieldsList" type="java.util.List"--%>

<table class="UI Layout">
    <tr>
        <td class="UI Middle">
            <div class="UI PageIdentity">
                <h1><c:out value="${title}"/></h1>
            </div>

            <syswf:component prefix="lifecycleNotificationPreview" name="/pushnotification/notificationPreviewPanel">
                <syswf:param name="notificationDescriptor" value="${notificationDescriptor}"/>
                <syswf:param name="notificationData" value="${notificationData}"/>
                <syswf:param name="customFieldsList" value="${customFieldsList}"/>
            </syswf:component>

            <syswf:block className="UI Block Green">
                <div class="Content">
                    <div class="UI Form Controls">
                        <syswf:control mode="postAnchor" caption="${Close}"
                            targetDepth="${sessionStack.currentDepth-1}">
                            <syswf:attribute name="class" value="btn btn-gray"/>
                        </syswf:control>
                    </div>
                </div>
            </syswf:block>

        </td>
    </tr>
</table>
