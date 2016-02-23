<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.usertask.ui.UserTaskUiL10n" var="messages"/>
<fmt:message bundle="${messages}" key="usertasks.lifecycleTasks.feed.hint" var="hint"/>
<fmt:message bundle="${messages}" key="usertasks.lifecycleTasks.feed.caption" var="caption"/>

<c:if test="${not empty atomLink}">
	<a class="UI PageAction RSS" title="${hint}" href="${atomLink}" ></a>
</c:if>