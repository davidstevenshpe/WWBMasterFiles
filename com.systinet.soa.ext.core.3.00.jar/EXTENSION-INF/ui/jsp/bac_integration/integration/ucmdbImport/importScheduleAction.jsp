<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.systinet.platform.ui.bacintegration.BacIntegrationUiL10n" var="bacIntegrationUiL10n"/>
<fmt:message key="import.action.scheduleAutomaticImport" var="scheduleImport" bundle="${bacIntegrationUiL10n}"/>
<fmt:message key="import.action.editSchedule" var="editSchedule" bundle="${bacIntegrationUiL10n}"/>
<fmt:message key="import.action.cancelSchedule" var="cancelSchedule" bundle="${bacIntegrationUiL10n}"/>

<%--@elvariable id="taskArtifact" type="com.hp.systinet.repository.sdm.generated.artifacts.sys.TaskArtifact"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<c:if test="${not empty taskArtifact}">
    <c:choose>
        <%--@elvariable id="isScheduled" type="boolean"--%>
        <c:when test="${empty notPageAction}">
            <div class="Content">
                <syswf:component prefix="scheduleTaskWindow" name="/core/task/scheduleTaskWindow">
                    <syswf:param name="taskArtifactUuid" value="${taskArtifact._uuid}"/>
                    <syswf:param name="winTitle">${scheduleImport}</syswf:param>
                    <syswf:param name="winOpenFunctionName">fnOpenDiscoveryTaskScheduleWin</syswf:param>
                    <syswf:param name="reloadPageAfterSave" value="${true}"/>
                </syswf:component>
                <script type="text/javascript">
                    //<![CDATA[

                    Ext.onReady(function() {
                        Ext.get('${prefix}scheduleTaskButton').on('click', fnOpenDiscoveryTaskScheduleWin);
                    });
                    //]]>
                </script>
                <c:choose>
                    <c:when test="${not isScheduled}">
                        <a id="${prefix}scheduleTaskButton" href="javascript:void(0);" class="UI PageAction ScheduleImport">
                            <span><syswf:out value="${scheduleImport}" context="HtmlBody"/></span>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a id="${prefix}scheduleTaskButton" href="javascript:void(0);" class="UI PageAction ScheduleImport">
                            <span><syswf:out value="${editSchedule}" context="HtmlBody"/></span>
                        </a>

                        <syswf:component name="/admin/task/bulk/actionCancelSchedule" prefix="cancelSchedule">
                            <syswf:param name="artifact" value="${taskArtifact}"/>
                        </syswf:component>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:when>
        <c:otherwise>
            <syswf:component prefix="scheduleTaskWindow" name="/core/task/scheduleTaskWindow" wrap="false">
                <syswf:param name="taskArtifactUuid" value="${taskArtifact._uuid}"/>
                <syswf:param name="winTitle">${scheduleImport}</syswf:param>
                <syswf:param name="winOpenFunctionName">fnOpenDiscoveryTaskScheduleWin</syswf:param>
                <syswf:param name="reloadPageAfterSave" value="${true}"/>
            </syswf:component>
            <script type="text/javascript">
                //<![CDATA[
                Ext.onReady(function() {
                    Ext.get('${prefix}scheduleTaskButton').on('click', fnOpenDiscoveryTaskScheduleWin);
                });
                //]]>
            </script>
            <c:choose>
                <c:when test="${not isScheduled}">
                    <a id="${prefix}scheduleTaskButton" href="javascript:void(0);">
                        <span><syswf:out value="${scheduleImport}" context="HtmlBody"/></span>
                    </a>
                </c:when>
                <c:otherwise>
                    <a id="${prefix}scheduleTaskButton" href="javascript:void(0);">
                        <span><syswf:out value="${editSchedule}" context="HtmlBody"/></span>
                    </a>
                    <syswf:component name="/admin/task/bulk/actionCancelSchedule" prefix="cancelSchedule" wrap="false">
                        <syswf:param name="artifact" value="${taskArtifact}"/>
                    </syswf:component>
                </c:otherwise>
            </c:choose>
        </c:otherwise>
    </c:choose>
</c:if>
