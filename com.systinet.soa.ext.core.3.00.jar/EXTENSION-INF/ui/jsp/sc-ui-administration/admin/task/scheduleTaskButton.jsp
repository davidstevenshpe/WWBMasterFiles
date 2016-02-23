<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="canDisplayButton" type="boolean"--%>
<c:if test="${canDisplayButton}">
    <%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.generated.artifacts.sys.TaskArtifact"--%>
    <%--@elvariable id="prefix" type="java.lang.String"--%>

    <fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>
	<fmt:message key="scheduleTaskButton_label" bundle="${messages}" var="title"/>
    <syswf:component prefix="scheduleTaskWindow" name="/core/task/scheduleTaskWindow">
        <syswf:param name="taskArtifactUuid" value="${artifact._uuid}"/>
        <syswf:param name="winTitle"><fmt:message key="scheduleTaskButton_label" bundle="${messages}"/></syswf:param>
        <syswf:param name="winOpenFunctionName">${prefix}fnOpenTaskScheduleWin</syswf:param>
        <syswf:param name="reloadPageAfterSave" value="${true}"/>
        <syswf:param name="checkOnStartDate" value="${true}"/>
    </syswf:component>

    <a id="${prefix}scheduleTaskButton" href="javascript:void(0);" class="context-button EditSchedule" title="${title}">
    </a>
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
            Ext.get('${prefix}scheduleTaskButton').on('click', ${prefix}fnOpenTaskScheduleWin);
        });
    
//]]>
</script>
</c:if>