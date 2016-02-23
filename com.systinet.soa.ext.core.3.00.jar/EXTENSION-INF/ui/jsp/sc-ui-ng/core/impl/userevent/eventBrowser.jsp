<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="viewId" type="java.lang.String"--%>
<%--@elvariable id="actualLastReadTime" type="java.util.Date"--%>
<syswf:component name="/core/layout/header" prefix="eventBrowserTitle" wrap="false">
    <syswf:param name="title" value="Latest Events"/>
</syswf:component>
<syswf:component name="/core/search/searchQueryList" prefix="eventBrowser">
    <syswf:param name="customizationId" value="shared.userevent.eventBrowser"/>
    <syswf:param name="lastReadTime" value="${actualLastReadTime}"/>
    <syswf:param name="dontCustomize" value="${true}"/>
</syswf:component>
