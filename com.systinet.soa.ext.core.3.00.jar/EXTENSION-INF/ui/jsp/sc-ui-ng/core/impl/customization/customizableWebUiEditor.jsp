<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${this.canCustomize}">
    <%--Set Locale form globalSession. --%>
    <c:if test="${not empty globalSession['userName']}">
        <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
    </c:if>

    <%--Set Bundle. --%>
    <fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="cust_Message"/>

    <%-- Get Message --%>
    <fmt:message key="customize_caption" var="customize_caption" bundle="${cust_Message}"/>
    <fmt:message key="discard_caption" var="discard_caption" bundle="${cust_Message}"/>
    <fmt:message key="save_caption" var="save_caption" bundle="${cust_Message}"/>
    <fmt:message key="cancel_caption" var="cancel_caption" bundle="${cust_Message}"/>

    <c:if test="${not empty this.customizationException}">
        <c:out value="${this.customizationException}"/>
    </c:if>

    <syswf:component name="/core/impl/edit/popupTextEditor" prefix="customizationEditor" wrap="false">
        <syswf:param name="bean" value="${this.textEditorBean}" />

        <syswf:param name="openPopupButtonLabel" value="${customize_caption}" />
        <syswf:param name="openPopupButtonClass" value="UI Customize Icon" />
        <syswf:param name="saveButtonLabel" value="${save_caption}" />
        <syswf:param name="cancelButtonLabel" value="${cancel_caption}" />
        <syswf:param name="saveListener" value="${this}" />
    </syswf:component>

    <c:if test="${this.changed}">
        | <syswf:control mode="anchor" action="discard" caption="${discard_caption}" />
    </c:if>
    
</c:if>