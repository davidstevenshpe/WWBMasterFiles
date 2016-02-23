<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<syswf:component prefix="leftColumn.contextButtons" name="/core/layout/contextActions" >
    <syswf:param name="customizationId" value="admin.task.browseTaskContextActions"/>
</syswf:component>        	

<syswf:component name="/core/table" prefix="browseTaskTable">
    <syswf:param name="customizationId" value="admin.task.browseTaskTable"/>
    <syswf:param name="datasource" value="${dataSource}"/>
    <syswf:param name="tableId" value="browseTaskTable"/>
</syswf:component>
