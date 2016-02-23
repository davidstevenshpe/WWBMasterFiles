<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="L10nSCAdministration"/>

<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.generated.artifacts.sys.TaskArtifact"--%>
<syswf:block className="UI Block Common">
    <div class="Title">
        <h3><span><fmt:message key="executionHistory_title" bundle="${L10nSCAdministration}"/></span></h3>
    </div>
    <div class="Content">
        <syswf:component name="/core/table" prefix="executionHistoryTable">
            <syswf:param name="customizationId" value="admin.task.executionHistoryTable"/>
            <syswf:param name="datasource" value="${dataSource}"/>
            <syswf:param name="tableId" value="executionHistoryTable"/>
            <syswf:param name="taskArtifact" value="${artifact}"/>
        </syswf:component>
    </div>
</syswf:block>