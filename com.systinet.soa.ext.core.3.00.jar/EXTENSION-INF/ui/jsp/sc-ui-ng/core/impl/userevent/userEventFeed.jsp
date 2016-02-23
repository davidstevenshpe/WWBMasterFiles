<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.userevent.componentsusereventmessages" var="messages"/>
<fmt:message key="events.feedTitle" var="feedTitle" bundle="${messages}"/>

<a class="UI PageAction RSS" href="${feedLink}" title="${feedTitle}"></a>