<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.comments.commentsmessages" var="commentsMessages"/>

<fmt:message bundle="${commentsMessages}" key="atomLink.hint" var="hint"/>
<fmt:message bundle="${commentsMessages}" key="atomLink.caption" var="caption"/>

<c:if test="${not common}">
	<c:set value="EA-left-panel" var="className"/>
    <div class="${className}">
        <a class="UI PageAction CommentFeed" title="${hint}" href="${atomLink}"><span>${caption}</span></a>
    </div>
</c:if>
<c:if test="${common}">
    <c:set value="AJAXContainer" var="className"/>
    <div class="${className}">
        <a class="context-button CommentFeed" title="${caption} (${hint})" href="${atomLink}"> </a>
    </div>
</c:if>

