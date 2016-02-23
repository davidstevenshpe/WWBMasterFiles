<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.pushnotification.ui.notificationMessages" var="messages"/>
<fmt:message key="notificationPreview.sendLabel" var="sendLabel" bundle="${messages}"/>
<fmt:message key="notificationPreview.backLabel" var="backLabel" bundle="${messages}"/>
<fmt:message key="notificationPreview.caption" var="title" bundle="${messages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:message bundle="${labels}" key="Cancel" var="Cancel" />

<%--@elvariable id="sessionStack" type="com.systinet.webfw.CarryBag"--%>
<%--@elvariable id="previewBean" type="com.hp.systinet.pushnotification.ui.NotificationPreview.Bean"--%>

<table class="UI Layout">
    <tr>
        <td class="UI Middle">
            <div class="UI PageIdentity">
                <h1><c:out value="${title}"/></h1>
            </div>

            <syswf:component prefix="lifecycleNotificationPreview" name="/pushnotification/notificationPreviewPanel">
                <syswf:param name="notificationDescriptor" value="${previewBean.notificationDescriptor}"/>
                <syswf:param name="notificationData" value="${previewBean.notificationData}"/>
                <syswf:param name="customFieldsList" value="${previewBean.customFieldsList}"/>
                <syswf:param name="recipientsBean" value="${previewBean.recipientsBean}"/>
                <syswf:param name="notificationRecipients" value="${previewBean.notificationRecipients}"/>
                <syswf:param name="showAllRecipients" value="${previewBean.showAllRecipients}"/>
            </syswf:component>

            <syswf:block className="UI Block Green">
                <div class="Content">
                    <div class="UI Form Controls">
                        <syswf:control mode="postAnchor" caption="${backLabel}"
                            targetDepth="${sessionStack.currentDepth-1}">
                            <syswf:attribute name="class" value="btn btn-primary"/>
                        </syswf:control>    
                        <syswf:control mode="postAnchor" action="previewSendNotification" caption="${sendLabel}">
                            <syswf:attribute name="class" value="btn btn-primary"/>
                        </syswf:control>
                        <syswf:control mode="postAnchor" action="cancelNotification" caption="${Cancel}"
                                       targetDepth="${sessionStack.currentDepth-2}">
                            <syswf:attribute name="class" value="btn btn-gray" />
                        </syswf:control>
                    </div>
                </div>
            </syswf:block>

        </td>
    </tr>
</table>
