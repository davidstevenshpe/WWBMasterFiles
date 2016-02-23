<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.systinet.platform.ui.integration.IntegrationL10n" var="messages"/>

<syswf:control mode="script" action="markAsAction" caption="${prefix}markAsRogue">
    <syswf:param name="selectionBag" value="${selectionBag}"/>
</syswf:control>
<syswf:component name="/core/impl/util/dialog" prefix="markAsRogueDialog">
    <syswf:param name="handler" value="${prefix}markAsRogue"/>
    <%--@elvariable id="confirmDialogTitle" type="java.lang.String"--%>
    <syswf:param name="heading">${confirmDialogTitle}</syswf:param>
    <%--@elvariable id="confirmDialogMessage" type="java.lang.String"--%>
    <syswf:param name="content">${confirmDialogMessage}</syswf:param>
    <syswf:param name="noUndo" value="false"/>
</syswf:component>
