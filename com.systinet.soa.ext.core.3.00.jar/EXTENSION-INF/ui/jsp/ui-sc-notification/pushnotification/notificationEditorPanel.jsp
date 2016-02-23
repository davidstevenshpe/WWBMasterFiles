<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="notificationBean" type="com.hp.systinet.pushnotification.ui.NotificationEditor.Bean"--%>
<%--@elvariable id="eventNotificationBean" type="com.hp.systinet.lifecycle.ui.admin.automaticactionkinds.LifecycleNotificationEditor.Bean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<syswf:block className="UI Block Common">
    <div class="Content">
        <table class="UI Table Properties" summary="">
            <col class="LabelCol"/>
            <col/>
            <tbody>
                <c:if test="${notificationBean.showEventSelector}">
                    <syswf:component prefix="selectEvent" name="/newUi/lc/admin/automaticaction/eventSelector">
                        <syswf:param name="esBean" value="${eventNotificationBean.eventBean}"/>
                    </syswf:component>
                </c:if>

                <syswf:component prefix="selectRecipients" name="/pushnotification/notificationRecipientsSelector">
                    <syswf:param name="descriptorBean" value="${notificationBean.descriptor}"/>
                    <syswf:param name="applicableDescriptorBean" value="${notificationBean.applicableDescriptor}"/>
                    <syswf:param name="recipientsBean" value="${notificationBean.recipientsBean}"/>
                    <syswf:param name="hideRoleWithNoMembers" value="${notificationBean.showAllRecipients}"/>
                </syswf:component>
            </tbody>
        </table>
    </div>
</syswf:block>

<syswf:component prefix="notificationEditor_selectAdvancedOptions" name="/pushnotification/notificationAdvancedOptionsEditor">
    <syswf:param name="descriptorBean" value="${notificationBean.descriptor}"/>
    <syswf:param name="applicableDescriptorBean" value="${notificationBean.applicableDescriptor}"/>
</syswf:component>

<syswf:block className="UI Block Common">
    <div class="Content">
        <syswf:component prefix="message" name="/pushnotification/notificationMessageEditor">
            <syswf:param name="descriptorBean" value="${notificationBean.descriptor}"/>
            <syswf:param name="applicableDescriptorBean" value="${notificationBean.applicableDescriptor}"/>
        </syswf:component>
    </div>
</syswf:block>

