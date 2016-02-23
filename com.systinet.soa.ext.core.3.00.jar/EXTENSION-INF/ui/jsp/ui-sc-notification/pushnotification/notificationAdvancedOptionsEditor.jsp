<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.pushnotification.ui.notificationMessages" var="messages"/>

<%--@elvariable id="descriptorBean" type="com.hp.systinet.pushnotification.api.NotificationDescriptor"--%>
<%--@elvariable id="applicableDescriptorBean" type="com.hp.systinet.pushnotification.api.NotificationDescriptor"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<c:if test="${not empty applicableDescriptorBean.relatedDataResolvers}">
    <syswf:block className="UI Block Common">
        <div class="Content">
            <syswf:wrap template="../sc-ui-ng/templates/advancedOptions.jsp">
                <table class="UI Table Properties" summary="">
                    <col class="LabelCol"/>
                    <col/>
                    <tbody>
                    <tr>
                        <th>
                        </th>
                        <td>
                            <ul class="triState">
                                <c:forEach items="${applicableDescriptorBean.relatedDataResolvers}" var="relatedDataResolver"
                                           varStatus="index">
                                    <li>
                                        <c:set var="value" value=""/>
                                        <c:if test="${fn:contains(descriptorBean.relatedDataResolvers, relatedDataResolver)}">
                                            <c:set var="value" value="${relatedDataResolver.id}"/>
                                        </c:if>
                                        <syswf:selectOne name="relatedDataResolverCheckboxes" value="${value}"
                                                         optionValues="${relatedDataResolver.id}" optionCaptions=""
                                                         displayAsRow="true"
                                                         mode="checkbox" id="adv_opt_${index.index}">
                                        </syswf:selectOne>
                                        <label class="label" for="adv_opt_${index.index}_0"
                                               title="${relatedDataResolver.description}">
                                            <c:out value="${relatedDataResolver.name}"/>
                                        </label>
                                    </li>
                                </c:forEach>
                            </ul>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </syswf:wrap>
        </div>
    </syswf:block>
</c:if>