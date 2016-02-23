<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="canDisplayComponent" type="boolean"--%>
<c:if test="${canDisplayComponent}">
    <syswf:component name="/core/layout/header" prefix="processBrowserTitle" wrap="false">
        <syswf:param name="title" value="Lifecycle Processes"/>
    </syswf:component>
    <syswf:component name="/core/search/searchQueryList" prefix="processBrowser">
        <syswf:param name="customizationId" value="admin.lifecycle.process.processBrowser"/>
    </syswf:component>
</c:if>