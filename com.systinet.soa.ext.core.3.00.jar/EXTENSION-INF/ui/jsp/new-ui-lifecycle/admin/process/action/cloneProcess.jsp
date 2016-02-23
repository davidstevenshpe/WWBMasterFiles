<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="process" type="com.hp.systinet.platform.lifecycle.GovernanceProcess"--%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>
<fmt:message var="msgLinkLabel" key="processAction.clone.label" bundle="${bundle}"/>

<syswf:control mode="anchor" action="cloneProcess" caption="">
    <syswf:attribute name="class">context-button Copy</syswf:attribute>
    <syswf:attribute name="title">${msgLinkLabel}</syswf:attribute>
</syswf:control>
