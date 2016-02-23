<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="addApprover.approvedBy" var="approvedByLabel" bundle="${messages}"/>

<syswf:component name="/core/table" prefix="editApproversTable">
    <syswf:param name="customizationId" value="admin.lifecycle.responsibilities.editApproversTable"/>
    <syswf:param name="datasource" value="${dataSource}" />
    <syswf:param name="process" value="${process}" />
    <syswf:param name="parentComponent" value="${prefix}" />
</syswf:component>