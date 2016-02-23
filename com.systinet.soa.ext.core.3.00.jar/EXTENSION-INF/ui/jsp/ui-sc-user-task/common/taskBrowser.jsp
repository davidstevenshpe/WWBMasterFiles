<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.usertask.ui.UserTaskUiL10n" var="messages"/>
<fmt:message var="userTasksTitle" key="usertasks.taskBrowser.title" bundle="${messages}"/>

<syswf:component name="/core/layout/header" prefix="taskBrowserTitle" wrap="false">
    <syswf:param name="title" value="${userTasksTitle}"/>
</syswf:component>
<syswf:component name="/core/search/searchQueryList" prefix="taskBrowser">
    <syswf:param name="customizationId" value="common.usertask.taskBrowser"/>
</syswf:component>
