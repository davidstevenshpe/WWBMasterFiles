<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="notify.editor.previewButton" var="previewButton" bundle="${messages}"/>
<fmt:message key="notify.editor.caption" var="title" bundle="${messages}"/>
<fmt:message key="notify.preview.defaultCaption" var="previewTitle" bundle="${messages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:message bundle="${labels}" key="OK" var="OK" />
<fmt:message bundle="${labels}" key="Cancel" var="Cancel" />

<%--@elvariable id="notificationBean" type="com.hp.systinet.pushnotification.ui.NotificationEditor.Bean"--%>
<%--@elvariable id="eventNotificationBean" type="com.hp.systinet.lifecycle.ui.admin.automaticactionkinds.LifecycleNotificationEditor.Bean"--%>
<%--@elvariable id="sessionStack" type="com.systinet.webfw.CarryBag"--%>

<table class="UI Layout">
    <tr>
        <td class="UI Middle">
            <div class="UI PageIdentity">
                <h1><c:out value="${title}"/></h1>
            </div>

            <syswf:component prefix="notificationEditor" name="/pushnotification/notificationEditorPanel">
                <syswf:param name="notificationBean" value="${notificationBean}"/>
                <syswf:param name="eventNotificationBean" value="${eventNotificationBean}"/>
            </syswf:component>

            <syswf:block className="UI Block Green">
                <div class="Content">
                    <div class="UI Form Controls">
                        <syswf:control mode="postAnchor" action="previewNotification" caption="${previewButton}">
                            <syswf:attribute name="class" value="btn btn-gray" />
                        </syswf:control>
                        <syswf:control mode="postAnchor" action="saveNotification" caption="${OK}">
                            <syswf:attribute name="class" value="btn btn-primary" />
                        </syswf:control>
                        <syswf:control mode="postAnchor" action="cancelNotification" caption="${Cancel}"
                                       targetDepth="${sessionStack.currentDepth-1}">
                            <syswf:attribute name="class" value="btn btn-gray" />
                        </syswf:control>
                    </div>
                </div>
            </syswf:block>
        </td>
    </tr>
</table>
