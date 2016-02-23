<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%--@elvariable id="viewId" type="java.lang.String"--%>
<%--@elvariable id="dataSource" type=""--%>
<div class="UI Block Container">
<syswf:component name="/core/table" prefix="eventBrowser">
    <syswf:param name="customizationId" value="shared.userevent.artifactEventBrowser.allTable"/>
    <syswf:param name="viewId" value="${viewId}"/>
    <syswf:param name="datasource" value="${dataSource}" />
</syswf:component>
</div>
