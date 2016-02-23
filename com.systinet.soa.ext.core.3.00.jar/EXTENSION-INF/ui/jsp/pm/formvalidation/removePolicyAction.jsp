<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="controlName" type="java.lang.String"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<fmt:setBundle basename="com.hp.systinet.policy.ui.UiPolicyL10n" var="bundle"/>
<fmt:message var="msgConfirmTitle" key="formValidation.removePolicy.confirmTitle" bundle="${bundle}"/>
<fmt:message var="msgConfirmMessage" key="formValidation.removePolicy.confirmMessage" bundle="${bundle}"/>

<%-- (can't use AJAX as we need to post also table's selectionBag) --%>
<syswf:control mode="script" action="removePolicies" caption="${prefix}fnRemoveTps">
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>

<syswf:component prefix="removeConfirmDialog" name="/core/impl/util/dialog">
    <syswf:param name="controlName" value="${controlName}"/>
    <syswf:param name="handler" value="${prefix}fnRemoveTps"/>
    <syswf:param name="heading">${msgConfirmTitle}</syswf:param>
    <syswf:param name="content">${msgConfirmMessage}</syswf:param>
    <syswf:param name="noUndo" value="yes"/>
</syswf:component>

