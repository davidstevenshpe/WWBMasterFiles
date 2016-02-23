<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%--parameter "resolverId"          - unique identifier for the recipient resolver section --%>
<%--parameter "recipientBeanMap"    - map of recipients for the recipient resolver --%>
<%--parameter "recipientsBean"      - bean of notification recipient resolver --%>
<%--parameter "recipientResolverId" - id of recipient resolver --%>
<%--parameter "mode"                - "edit" for editor, "view" for preview --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--@elvariable id="recipientsBean" type="com.hp.systinet.pushnotification.ui.NotificationRecipientsSelector.Bean"--%>
<%--@elvariable id="resolverId" type="java.lang.String"--%>
<%--@elvariable id="recipientResolverId" type="java.lang.String"--%>
<%--@elvariable id="mode" type="java.lang.String"--%>
<%--@elvariable id="recipientBeanMap" type="java.util.Map"--%>
<%--@elvariable id="recipientRoleBean" type="com.hp.systinet.pushnotification.ui.NotificationRecipientsSelectorByRole.Bean"--%>

<c:if test="${mode eq 'edit'}">

    <c:if test="${not empty recipientsBean.rolesSelectionStatus}">
        <ul>
            <c:forEach items="${recipientsBean.rolesSelectionStatus}" var="roleStatus" varStatus="index">
                <li>
                    <c:set var="roleId" value="${resolverId}selectedRole${index.index}"/>
                    <c:set var="valueRole" value=""/>
                    <c:if test="${roleStatus.selected}">
                        <c:set var="valueRole" value="${roleStatus.roleKey}"/>
                    </c:if>
                    <syswf:selectOne name="selectedRole"
                                     value="${valueRole}"
                                     optionValues="${roleStatus.roleKey}"
                                     optionCaptions=""
                                     displayAsRow="true"
                                     mode="checkbox" id="selectedRole${roleId}">
                    </syswf:selectOne>
                    <label class="label" for="selectedRole${roleId}_0"><c:out value="${roleStatus.roleName}"/></label>
                </li>
            </c:forEach>
        </ul>
    </c:if>

    <c:if test="${not empty recipientBeanMap}">
        <c:set var="selectedRolesSet" value="${recipientsBean.recipientResolverInfoSelectionMap[recipientResolverId]}"/>
        <ul>
            <c:forEach items="${recipientRoleBean.sortedKeys}" var="roleName" varStatus="index">
                <li>
                    <c:set var="roleId" value="${resolverId}Role${index.index}"/>
                    <c:set var="valueRole" value=""/>
                    <c:if test="${not empty selectedRolesSet and fn:contains(selectedRolesSet, roleName)}">
                        <c:set var="valueRole" value="${roleName}"/>
                    </c:if>
                    <syswf:selectOne name="selectByRoleCheckboxes"
                                     value="${valueRole}"
                                     optionValues="${roleName}"
                                     optionCaptions=""
                                     displayAsRow="true"
                                     mode="checkbox" id="${roleId}">
                    </syswf:selectOne>
                    <label class="label" for="${roleId}_0"><c:out value="${roleName}:"/></label>
                    <syswf:component prefix="${resolverId}recipientsList${roleName}" wrap="false"
                                     name="/pushnotification/notificationRecipientsList">
                        <syswf:param name="selectorVariable" value="${roleId}Selector"/>
                        <syswf:param name="recipientBeanList" value="${recipientBeanMap[roleName]}"/>
                        <syswf:param name="separateWithEndash" value="true"/>
                    </syswf:component>
                </li>
            </c:forEach>
        </ul>
    </c:if>
</c:if>

<c:if test="${mode eq 'view'}">
    <c:set var="contactList" value="${recipientRoleBean.sortedKeys}"/>
    <c:set var="selectedRolesSet"
           value="${recipientsBean.recipientResolverInfoSelectionMap[recipientResolverId]}"/>
    <c:if test="${not empty contactList and not empty selectedRolesSet}">
        <ul class="UI Bullets First">
            <c:forEach items="${contactList}" var="roleName" varStatus="index">
                <c:set var="roleId" value="${resolverId}Role${index.index}"/>
                <c:if test="${(not empty selectedRolesSet and fn:contains(selectedRolesSet, roleName))}">
                    <li>
                        <label class="label"><c:out value="${roleName}:"/></label>
                        <syswf:component prefix="${resolverId}recipientsList${roleName}" wrap="false"
                                         name="/pushnotification/notificationRecipientsList">
                            <syswf:param name="selectorVariable" value="${roleId}Selector"/>
                            <syswf:param name="recipientBeanList"
                                         value="${recipientBeanMap[roleName]}"/>
                            <syswf:param name="separateWithEndash" value="true"/>
                        </syswf:component>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
    </c:if>
    <%--<c:if test="${not empty recipientsBean.rolesSelectionStatus}">--%>
        <ul class="UI Bullets First">
            <c:forEach items="${recipientsBean.rolesSelectionStatus}" var="roleStatus">
                <c:if test="${roleStatus.selected}">
                    <li>
                        <label class="label"><c:out value="${roleStatus.roleName}"/></label>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
    <%--</c:if>--%>
</c:if>
