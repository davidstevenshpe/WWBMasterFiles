<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="notify.renderer.recipients" var="recipientsLabel" bundle="${messages}"/>
<fmt:message key="notify.renderer.additionalRecipients" var="additionalRecipientsLabel" bundle="${messages}"/>
<fmt:message key="notify.renderer.include" var="includeLabel" bundle="${messages}"/>
<fmt:message key="notify.renderer.eventLabel" var="eventLabel" bundle="${messages}"/>
<fmt:message key="notify.renderer.advancedOptions" var="advancedOptionsLabel" bundle="${messages}"/>
<fmt:message key="expandLink.label" var="expandLinkLabel" bundle="${messages}" />
<fmt:message key="automaticActionSection.edit" var="editLabel" bundle="${messages}"/>
<fmt:message key="automaticActionSection.remove" var="removeLabel" bundle="${messages}" />
<fmt:message key="automaticActionSection.deletePopupTitle" var="deletePopupTitle" bundle="${messages}" />
<fmt:message key="automaticActionSection.deleteQuestion" var="deleteQuestion" bundle="${messages}" />
<fmt:message key="eventSelector.days" var="days" bundle="${messages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:message bundle="${labels}" key="OK" var="OK" />
<fmt:message bundle="${labels}" key="Cancel" var="Cancel" />


<%--@elvariable id="notificationBean" type="com.hp.systinet.lifecycle.ui.admin.automaticactionkinds.renderer.NotificationRowRenderer.Bean"--%>
<%--@elvariable id="metadata" type="com.hp.systinet.platform.lifecycle.automaticaction.AutomaticActionMetadata"--%>
<%--@elvariable id="configData" type="com.hp.systinet.lifecycle.ui.admin.automaticaction.AutomaticActionsBean.ConfigData"--%>
<%--@elvariable id="contactRolesData" type="java.lang.Integer"--%>
<%--@elvariable id="automaticActionsBean" type="java.util.List<com.hp.systinet.lifecycle.ui.admin.automaticaction.AutomaticActionsBean>"--%>

<c:set var="descriptor" value="${notificationBean.notificationDescriptor}"/>

<table class="UI Table Properties">
    <col class="FormSelectCol">
    <col class="LongLabelCol">
    <col>
    <col class="ControlCol">
    <col class="SpacerCol">
        <tr>
            <td><a id="aaction_${prefix}_switch"
                class="UI Icon Expand" href="javascript:void(0)"><span>${expandLinkLabel}</span></a></td>
            <td><a class="IconAlign" href="javascript:void(0)"><span>${metadata.name}</span></a></td>
            <td>
                <span><c:out value="${descriptor.subject}"/></span>
            </td>
            <td>
                <div class="Text RightAlign">
                    <syswf:control mode="postanchor" targetTask="/admin/lifecycle/automaticactionkinds/lifecycleNotificationEditorTask" caption="${editLabel}" wrapper="false">
                        <syswf:attribute name="class" value="UI Icon Edit"/>
                        <syswf:param name="metadata" value="${metadata}"/>
                        <syswf:param name="automaticActionId" value="${metadata.id}"/>
                        <syswf:param name="automaticActionsBean" value="${automaticActionsBean}"/>
                        <syswf:param name="configData" value="${configData}"/>
                    </syswf:control> &nbsp;
                    <a id="aaction_del_${prefix}" class="UI Icon Delete" href="javascript:void(0)">
                        <span>${removeLabel}</span>
                    </a>
                    <div id="RemoveAas${prefix}_content" class="x-hidden">
                        <div class="x-window-header">${deletePopupTitle}</div>
                        <div class="x-window-body">
                            <p class="Warning">${deleteQuestion}</p>
                        </div>
                    </div>
                </div>
            </td>
            <td></td>
        </tr>
</table>
<div id="aaction_${prefix}_comment" class="Comment x-hidden">
    <table class="UI Table Properties">
        <col class="FormSelectCol"/>
        <col/>
        <tr>
            <td></td>
            <td>
                <p class="Comment Plain">
                    <strong>${eventLabel}</strong>
                    <c:out value="${notificationBean.eventCaption}"/>
                    <c:if test="${notificationBean.delayInDays ge 0}">
                        ${notificationBean.delayInDays} ${days}
                    </c:if>
                    <c:if test="${not empty descriptor.recipientResolvers}">
                        <br>
                        <strong>${recipientsLabel}</strong>
                        <c:forEach items="${descriptor.recipientResolvers}" var="recipientResolver" varStatus="index">
                        <c:out value="${recipientResolver.name}"/>
                            <c:if test="${recipientResolver.class.name eq 'com.hp.systinet.pushnotification.impl.resolver.recipient.ContactsRecipientResolver' and (not empty contactRolesData)}">
                                (<syswf:out value="${contactRolesData}" context="HtmlBody"/>)
                            </c:if>
                            <c:if test="${not index.last}">
                                ,
                            </c:if>
                        </c:forEach>
                    </c:if>
                    <c:if test="${not empty notificationBean.innerPrincipals}">
                        <br>
                        <strong>${additionalRecipientsLabel}</strong>
                        <c:forEach var="additionalRecipient" varStatus="index" items="${notificationBean.innerPrincipals}">
                            <syswf:component prefix="al${index.index}${prefix}"
                                             name="/core/impl/util/principalLinkRenderer" wrap="false">
                                <syswf:param name="principal" value="${additionalRecipient}"/>
                                <syswf:param name="showIcon" value="${true}"/>
                            </syswf:component>
                            <c:if test="${not index.last}">
                                ,
                            </c:if>
                        </c:forEach>
                    </c:if>
                    <c:if test="${not empty descriptor.relatedDataResolvers}">
                        <br>
                        <strong>${advancedOptionsLabel}</strong>
                        <c:forEach items="${descriptor.relatedDataResolvers}" varStatus="index" var="relatedDataResolver">
                            <c:out value="${relatedDataResolver.name}"/>
                            <c:if test="${not index.last}">
                                ,
                            </c:if>
                        </c:forEach>
                    </c:if>
                    <c:if test="${not empty notificationBean.publicMailSections}">
                        <br>
                        <strong>${includeLabel}</strong>
                        <c:forEach items="${notificationBean.publicMailSections}" var="mailSection" varStatus="index">
                        <c:out value="${mailSection.name}"/><c:if
                                test="${not index.last}">,</c:if>
                        </c:forEach>
                    </c:if>
                    <br>
                    <c:out value="${metadata.description}"/>
                </p>
            </td>
        </tr>
    </table>
</div>
<script type="text/javascript">
//<![CDATA[

    Ext.get('aaction_${prefix}_switch').on('click',function(){
        AdvancedOptions.Comment.Switch('aaction_${prefix}_switch','aaction_${prefix}_comment');
    });

    Ext.onReady(function() {
        SPopup.Window.init('aaction_del_${prefix}','RemoveAas${prefix}_content', {
            autoHeight: true,
            resizable: true,
            shadow: false,
            centerOnScreen:true,
            buttonAlign: 'center',
            width:400,
            buttons:[
                {
                    text: '${OK}',
                    id: 'RemoveAas${prefix}Confirm',
                    handler: function(){ deleteAutomaticAction('${configData.id}'); }
                },
                {
                    text: '${Cancel}',
                    handler: function(){ SPopup.Window.Instance.aaction_del_${prefix}.hide(); }
                }
            ]
        });
    });
    //]]>
</script>

