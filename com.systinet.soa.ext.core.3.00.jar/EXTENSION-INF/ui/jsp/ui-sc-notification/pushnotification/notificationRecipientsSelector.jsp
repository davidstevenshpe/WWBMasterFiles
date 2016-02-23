<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.pushnotification.ui.notificationMessages" var="messages"/>
<fmt:message key="notificationEditor.recipientsLabel" var="recipientsLabel" bundle="${messages}"/>
<fmt:message key="notificationEditor.addRecipientButton" var="addRecipientButton" bundle="${messages}"/>
<fmt:message key="notificationEditor.removeEmailLabel" var="removeEmailLabel" bundle="${messages}"/>
<fmt:message key="notificationEditor.removeEmailHint" var="removeEmailHint" bundle="${messages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message key="widget.Required" bundle="${widgetMessages}" var="requiredCaption" />
<fmt:message key="widget.Required.title" bundle="${widgetMessages}" var="requiredTitle" />

<%--@elvariable id="applicableDescriptorBean" type="com.hp.systinet.pushnotification.api.NotificationDescriptor"--%>
<%--@elvariable id="descriptorBean" type="com.hp.systinet.pushnotification.api.NotificationDescriptor"--%>
<%--@elvariable id="recipientsBean" type="com.hp.systinet.sc.ui.pushnotification.NotificationRecipientsSelector.Bean"--%>
<%--@elvariable id="hideRoleWithNoMembers" type="java.lang.Boolean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="controlName" type="java.lang.String"--%>

<tr>
    <th>
        <label class="UI Label Required Full"><c:out value="${recipientsLabel}"/></label>
        <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
    </th>
    <td>
        <ul class="triState">
            <c:forEach items="${applicableDescriptorBean.recipientResolvers}" var="recipientResolver" varStatus="index">
                <c:set var="value"/>
                <c:set var="separator"/>
                <c:if test="${fn:contains(descriptorBean.recipientResolvers, recipientResolver)}">
                    <c:set var="value" value="${recipientResolver.id}"/>
                </c:if>
                <c:set var="resolverId" value="recipientId${index.index}"/>
                <c:set var="recipientResolverType"
                       value="${recipientsBean.recipientResolverTypeMap[recipientResolver.id]}"/>
                <c:set var="recipientBeanMap"
                       value="${recipientsBean.recipientBeanMapMap[recipientResolver.id]}"/>
                <c:set var="labelTooltip" value="${recipientResolver.description}"/>
                <c:set var="hideRole" value="${hideRoleWithNoMembers and empty recipientBeanMap}"/>
                <c:if test="${not hideRole}">
                    <li>
                        <c:choose>
                            <c:when test="${recipientResolverType eq 1}">
                                <h3><c:out value="${recipientResolver.name}"/></h3>
                            </c:when>
                            <c:otherwise>
                                <syswf:selectOne name="recipientResolverCheckboxes" value="${value}"
                                                 optionValues="${recipientResolver.id}" optionCaptions="" displayAsRow="true"
                                                 mode="checkbox" id="${resolverId}"/>
                                <label class="label" for="${resolverId}_0" title="${labelTooltip}">
                                    <c:out value="${recipientResolver.name}:"/>
                                </label>
                            </c:otherwise>
                        </c:choose>
                        <syswf:component prefix="${resolverId}RecipientDetails" wrap="false"
                                         name="/pushnotification/notificationRecipientsDetails">
                            <syswf:param name="resolverId" value="${resolverId}"/>
                            <syswf:param name="recipientBeanMap" value="${recipientBeanMap}"/>
                            <syswf:param name="recipientsBean" value="${recipientsBean}"/>
                            <syswf:param name="recipientResolver" value="${recipientResolver}"/>
                            <syswf:param name="recipientResolverType" value="${recipientResolverType}"/>
                            <syswf:param name="mode" value="edit"/>
                        </syswf:component>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
        <div class="x-clear"></div>
        <script type="text/javascript">
//<![CDATA[

            $(document).ready(function() {
                $('ul.triState', '').tristate({
                    heading: 'h3'
                });
            });
        
//]]>
</script>

        <c:if test="${not empty recipientsBean.emails}">
            <br/>
            <table class="shrTableHolder shrNoWrap">
                <colgroup>
                    <col/>
                    <col class="shrOneActionCol"/>
                </colgroup>
                <tbody>
                <c:forEach items="${recipientsBean.emails}" var="email">
                    <tr>
                        <td>
                            <div class="shrNoWrap">
                                <c:out value="${email}"/>
                            </div>
                        </td>
                        <td>
                            <div class="shrItemActionEdit">
                                <syswf:control mode="postAnchor" caption="${removeEmailLabel}"
                                               hint="${removeEmailHint}" action="removeEmail">
                                    <syswf:param name="emailToRemove" value="${email}"/>
                                </syswf:control>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
        <br/>

        <syswf:component name="/pushnotification/notificationAdditionalRecipients" prefix="additionalRecipients" wrap="true">
            <syswf:param name="recipientsBean" value="${recipientsBean}"/>
        </syswf:component>
    </td>
</tr>
