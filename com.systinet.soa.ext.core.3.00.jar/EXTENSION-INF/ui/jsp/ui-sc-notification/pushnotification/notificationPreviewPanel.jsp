<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.pushnotification.ui.notificationMessages" var="messages"/>
<fmt:message key="notificationPreview.sendLabel" var="sendLabel" bundle="${messages}"/>
<fmt:message key="notificationPreview.recipientsLabel" var="recipientsLabel" bundle="${messages}"/>
<fmt:message key="notificationPreview.additionalRecipientsLabel" var="additionalRecipientsLabel" bundle="${messages}"/>
<fmt:message key="notificationPreview.messageContentLabel" var="messageContentLabel" bundle="${messages}"/>
<fmt:message key="notificationPreview.messageSubjectLabel" var="messageSubjectLabel" bundle="${messages}"/>
<fmt:message key="notificationPreview.mailSectionsLabel" var="mailSectionsLabel" bundle="${messages}"/>
<fmt:message key="notificationPreview.emailsLabel" var="emailsLabel" bundle="${messages}"/>

<%--@elvariable id="previewBean" type="com.hp.systinet.pushnotification.ui.NotificationPreview.Bean"--%>
<%--@elvariable id="previewPanelBean" type="com.hp.systinet.pushnotification.ui.NotificationPreviewPanel.Bean"--%>
<%--@elvariable id="showAllRecipients" type="java.lang.String"--%>
<%--@elvariable id="value" type="java.lang.String"--%>
<%--@elvariable id="recipientsBean" type="com.hp.systinet.pushnotification.ui.NotificationRecipientsSelector.Bean"--%>
<%--@elvariable id="customFieldsList" type="java.util.List"--%>

<syswf:block className="UI Block Common">
    <div class="Content">
        <table class="UI Table Properties" summary="">
            <col class="LabelCol"/>
            <col/>
            <tbody>
            <c:forEach items="${customFieldsList}" var="customField"
                       varStatus="index">
                <tr>
                    <th>
                        <label class="UI Label Inline"><c:out value="${customField.name}"/></label>
                    </th>
                    <td>
                        <span class="UI IconAlign"><c:out value="${customField.value}"/></span>
                    </td>
                </tr>
            </c:forEach>
            <c:set var="descriptor" value="${previewPanelBean.notificationDescriptor}"/>
            <c:if test="${not empty descriptor.recipientResolvers
                        or not empty previewPanelBean.additionalRecipients
                        or not empty previewPanelBean.emails}">
                <tr>
                    <th>
                        <label class="UI Label Inline"><c:out value="${recipientsLabel}"/></label>
                    </th>
                    <td>
                        <ul class="UI Bullets Condensed First">
                            <c:if test="${not showAllRecipients and not empty descriptor.recipientResolvers}">
                                <c:forEach items="${descriptor.recipientResolvers}" var="recipientResolver"
                                       varStatus="index">
                                    <li>
                                        <c:set var="recipientResolverType"
                                           value="${recipientsBean.recipientResolverTypeMap[recipientResolver.id]}"/>
                                        <label title="${recipientResolver.description}">
                                            <c:out value="${recipientResolver.name}"/>
                                        </label>
                                        <c:if test="${recipientResolverType eq 1}">
                                            <c:set var="recipientBeanMap"
                                                   value="${recipientsBean.recipientBeanMapMap[recipientResolver.id]}"/>
                                            <c:set var="resolverId" value="recipientId${index.index}"/>
                                            <syswf:component prefix="${resolverId}Selector" wrap="false"
                                                             name="/pushnotification/notificationRecipientsSelectorByRole">
                                                <syswf:param name="resolverId" value="${resolverId}"/>
                                                <syswf:param name="recipientBeanMap" value="${recipientBeanMap}"/>
                                                <syswf:param name="recipientsBean" value="${recipientsBean}"/>
                                                <syswf:param name="recipientResolverId" value="${recipientResolver.id}"/>
                                                <syswf:param name="mode" value="view"/>
                                            </syswf:component>
                                        </c:if>
                                    </li>
                                </c:forEach>
                            </c:if>
                            <c:if test="${showAllRecipients and not empty descriptor.recipientResolvers}">
                                <c:forEach items="${descriptor.recipientResolvers}" var="recipientResolver"
                                           varStatus="index">
                                    <li>
                                        <c:set var="recipientResolverType"
                                            value="${recipientsBean.recipientResolverTypeMap[recipientResolver.id]}"/>
                                        <c:choose>
                                            <c:when test="${recipientResolverType eq 1}">
                                                <label><c:out value="${recipientResolver.name}"/></label>
                                            </c:when>
                                            <c:otherwise>
                                                <label><c:out value="${recipientResolver.name}:"/></label>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:if test="${not empty recipientsBean}">
                                            <c:set var="recipientBeanMap"
                                                   value="${recipientsBean.recipientBeanMapMap[recipientResolver.id]}"/>
                                            <c:set var="resolverId" value="recipientId${index.index}"/>
                                            <syswf:component prefix="${resolverId}RecipientDetails" wrap="false"
                                                             name="/pushnotification/notificationRecipientsDetails">
                                                <syswf:param name="resolverId" value="${resolverId}"/>
                                                <syswf:param name="recipientBeanMap" value="${recipientBeanMap}"/>
                                                <syswf:param name="recipientsBean" value="${recipientsBean}"/>
                                                <syswf:param name="recipientResolver" value="${recipientResolver}"/>
                                                <syswf:param name="recipientResolverType" value="${recipientResolverType}"/>
                                                <syswf:param name="mode" value="view"/>
                                            </syswf:component>
                                        </c:if>
                                    </li>
                                </c:forEach>
                            </c:if>
                            <c:if test="${not empty previewPanelBean.additionalRecipients}">
                                <li>
                                    <label>${additionalRecipientsLabel}:</label>
                                    <syswf:component prefix="additionalRecipientsFinderSelector" wrap="false"
                                                     name="/pushnotification/notificationRecipientsList">
                                        <syswf:param name="selectorVariable" value="additionalRecipientsFinder"/>
                                        <syswf:param name="recipientBeanList"
                                                     value="${previewPanelBean.additionalRecipients}"/>
                                        <syswf:param name="separateWithEndash" value="true" />
                                    </syswf:component>
                                </li>
                            </c:if>
                            <c:if test="${not empty previewPanelBean.emails}">
                                <li>
                                    <label>${emailsLabel}</label>
                                    <syswf:component prefix="emailsFinderSelector" wrap="false"
                                                     name="/pushnotification/notificationRecipientsList">
                                        <syswf:param name="selectorVariable" value="emailsFinder"/>
                                        <syswf:param name="recipientBeanList"
                                                     value="${previewPanelBean.emails}"/>
                                        <syswf:param name="separateWithEndash" value="true" />
                                    </syswf:component>
                                </li>
                            </c:if>
                        </ul>
                        <div class="x-clear"></div>
                    </td>
                </tr>
            </c:if>
            <c:if test="${not empty descriptor.relatedDataResolvers}">
                <c:forEach items="${descriptor.relatedDataResolvers}" var="relatedDataResolver">
                    <tr>
                        <th>
                        </th>
                        <td><c:out value="${relatedDataResolver.description}"/></td>
                    </tr>
                </c:forEach>
            </c:if>
            <tr class="SeparatorRow">
                <td></td>
                <td></td>
            </tr>
            <tr class="SeparatorRow">
                <td></td>
                <td></td>
            </tr>
            <tr>
                <th>
                    <label class="UI Label Inline"><c:out value="${messageSubjectLabel}"/></label>
                </th>
                <td>
                    <c:out value="${descriptor.subject}"/>
                </td>
            </tr>
            <tr class="SeparatorRow">
                <td></td>
                <td></td>
            </tr>
            <tr>
                <th>
                    <label class="UI Label Inline"><c:out value="${messageContentLabel}"/></label>
                </th>
                <td>
                    <c:out value="${previewPanelBean.preview.body}" escapeXml="false" />
                </td>
            </tr>
        </table>
    </div>
</syswf:block>
