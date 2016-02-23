<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>

<%--@elvariable id="dataSource" type="com.hp.systinet.sc.datasource.DataSource"--%>

<syswf:component name="/core/table" prefix="table">
    <syswf:param name="customizationId" value="admin.task.artifactSelector.individual.viewTable"/>
    <syswf:param name="datasource" value="${dataSource}" />
</syswf:component>