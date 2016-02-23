<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.pushnotification.ui.notificationMessages" var="messages"/>
<fmt:message key="notificationEditor.subjectLabel" var="messageSubjectLabel" bundle="${messages}"/>
<fmt:message key="notificationEditor.sectionLabel" var="sectionLabel" bundle="${messages}"/>
<fmt:message key="notificationEditor.textLabel" var="messageTextLabel" bundle="${messages}"/>
<fmt:message key="notificationEditor.subjectNotNull" var="subjectErrorMessage" bundle="${messages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message key="widget.Required" bundle="${widgetMessages}" var="requiredCaption" />
<fmt:message key="widget.Required.title" bundle="${widgetMessages}" var="requiredTitle" />

<%--@elvariable id="descriptorBean" type="com.hp.systinet.pushnotification.api.NotificationDescriptor"--%>
<%--@elvariable id="applicableDescriptorBean" type="com.hp.systinet.pushnotification.api.NotificationDescriptor"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="subjectError" type="java.lang.Boolean"--%>

<table class="UI Table Properties" summary="">
    <colgroup>
        <col class="LabelCol"/>
        <col/>
    </colgroup>
    <tbody>
    <tr>
        <th>
            <label class="UI Label Required Full"><c:out value="${messageSubjectLabel}"/></label>
            <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
        </th>
        <td>
            <syswf:input id="${prefix}_msgSubject" name="msg_subject" value="${descriptorBean}" property="subject">
                <c:choose>
                    <c:when test="${not subjectError}">
                        <syswf:attribute name="class"> x-form-text x-form-field</syswf:attribute>
                    </c:when>
                    <c:otherwise>
                        <syswf:attribute name="class"> x-form-text x-form-invalid</syswf:attribute>
                    </c:otherwise>
                </c:choose>
            </syswf:input>
            <c:if test="${subjectError}">
                <em class="x-form-invalid-msg UI Invalid">
                    <span>${subjectErrorMessage}</span>
                </em>
            </c:if>
            <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function() {
                    new Ext.HP.Input({
                        applyTo : '<c:out value="${prefix}_msgSubject" />'
                    });
                });
            
//]]>
</script>

        </td>
    </tr>
    <c:if test="${not empty applicableDescriptorBean.mailSections}">
        
        <c:forEach var="mailSection" items="${applicableDescriptorBean.mailSections}">
             <c:if test="${mailSection.public}">
                <c:set var="renderMailSections" value="true" />
             </c:if>
        </c:forEach>
    
        <c:if test="${renderMailSections}">
            <tr>
                <th>
                    <label class="UI Label Inline"><c:out value="${sectionLabel}"/></label>
                </th>
                <td>
                    <ul class="triState">
                        <c:forEach items="${applicableDescriptorBean.mailSections}" var="mailSection" varStatus="index">
                            <c:if test="${mailSection.public}">
                                <li>
                                    <c:set var="value" value=""/>
                                    <c:if test="${fn:contains(descriptorBean.mailSections, mailSection)}">
                                        <c:set var="value" value="${mailSection.id}"/>
                                    </c:if>
                                    <syswf:selectOne name="mailSectionCheckboxes" value="${value}"
                                                     optionValues="${mailSection.id}" optionCaptions="" displayAsRow="true"
                                                     mode="checkbox" id="msg_inc_${index.index}">
                                        <syswf:attribute name="class" value="UI Form Checkbox"/>
                                    </syswf:selectOne>
                                    <label class="label" for="msg_inc_${index.index}_0"
                                           title="${mailSection.description}">
                                        <c:out value="${mailSection.name}"/>
                                    </label>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </td>
            </tr>
        </c:if>
    </c:if>
    <tr>
        <th>
            <label class="UI Label Inline"><c:out value="${messageTextLabel}"/></label>
        </th>
        <td>
            <syswf:textArea name="msg_text" value="${descriptorBean}" property="body" id="msg_text">
                <syswf:attribute name="rows" value="10"/>
                <syswf:attribute name="class" value="UI Form Text Primary Full"/>
            </syswf:textArea>
        </td>
    </tr>
    </tbody>
</table>
