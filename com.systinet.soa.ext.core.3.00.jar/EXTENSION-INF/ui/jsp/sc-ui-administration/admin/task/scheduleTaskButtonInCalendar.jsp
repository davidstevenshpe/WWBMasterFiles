<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.generated.artifacts.sys.TaskArtifact"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="isScheduled" type="java.lang.Boolean"--%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>

<c:choose>
    <c:when test="${isScheduled}">
        <fmt:message key="scheduleTaskButton_label" var="label" bundle="${messages}"/>
    </c:when>
    <c:otherwise>
        <fmt:message key="scheduleTaskButtonNoSchedule_label" var="label" bundle="${messages}"/>
    </c:otherwise>
</c:choose>

<a id="${prefix}scheduleTaskButton" href="javascript:void(0);" class="UI Icon Edit">${label}</a>

<syswf:component prefix="scheduleTaskWindow" name="/core/task/scheduleTaskWindow">
    <syswf:param name="taskArtifactUuid" value="${artifact._uuid}"/>
    <syswf:param name="winTitle">${label}</syswf:param>
    <syswf:param name="winOpenFunctionName">${prefix}fnOpenTaskScheduleWin</syswf:param>
    <syswf:param name="reloadPageAfterSave" value="${true}"/>
    <syswf:param name="checkOnStartDate" value="${true}"/>
</syswf:component>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        Ext.get('${prefix}scheduleTaskButton').on('click', ${prefix}fnOpenTaskScheduleWin);
    });

//]]>
</script>
