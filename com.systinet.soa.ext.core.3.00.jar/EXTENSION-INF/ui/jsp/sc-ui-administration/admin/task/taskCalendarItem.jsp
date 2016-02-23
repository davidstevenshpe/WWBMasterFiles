<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="taskBean" type="com.hp.systinet.sc.ui.admin.task.BrowseTaskCalendar.TaskBean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="deploymentUrl" type="java.lang.String"--%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>
<fmt:message key="taskCalendar.runningSinceLabel" var="runningSinceLabel" bundle="${messages}"/>
<fmt:message key="taskCalendar.nextRunLabel" var="nextRunLabel" bundle="${messages}"/>
<fmt:message key="taskCalendar.taskPaused" var="taskPaused" bundle="${messages}"/>

<c:set var="style" value="background-image: url(${deploymentUrl}/artifactIcon?type=taskArtifact&amp;format=large)"/>


    <ul style="${style}" class="UI GridItem">
        <li class="Name">
            <syswf:component prefix="taskName" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                <syswf:param name="uuid" value="${taskBean.taskUuid}"/>
                <syswf:param name="caption" value="${taskBean.taskArtifact.name}"/>
                <syswf:param name="sdmName" value="taskArtifact"/>
                <syswf:param name="mode" value="anchor"/>
            </syswf:component>
        </li>
        <c:choose>
            <c:when test="${taskBean.taskRunning}">
                <c:if test="${taskBean.taskPaused}">
                    <li class="Schedule">
                        ${taskPaused}
                    </li>
                </c:if>
                <li class="Schedule">
                    ${runningSinceLabel}
                    <syswf:component prefix="taskStartedAt" name="/core/impl/util/enhancedDateRenderer" wrap="false">
                        <syswf:param name="dateValue" value="${taskBean.taskStartedAt}"/>
                    </syswf:component>
                </li>
                <li class="Controls">
                    <syswf:component prefix="runStop" name="/admin/task/runStopTaskComponent" wrap="false">
                        <syswf:param name="artifact" value="${taskBean.taskArtifact}"/>
                        <syswf:param name="currentViewType" value="calendar"/>
                    </syswf:component>
                </li>
                
                <syswf:control mode="script" action="refreshRunningTask" formName="ContentForm" caption="reload${prefix}" affects=".." />                                
                                        
                <div id="divreload${prefix}">
                        <%-- do AJAX call --%>
                    <script type="text/javascript">
//<![CDATA[

                        setInterval("callFunction('reload${prefix}')", getRandomLoadingInterval()); 
                    
//]]>
</script>
                </div>
            </c:when>
            <c:otherwise>
                <li class="Schedule">
                    ${nextRunLabel}
                    <syswf:component prefix="taskTime" name="/admin/task/scheduledRunTime" wrap="false">
                        <syswf:param name="scheduledEnabled" value="${taskBean.scheduleEnabled}"/>
                        <syswf:param name="scheduledRunTime" value="${taskBean.scheduleTime}"/>
                    </syswf:component>
                </li>
                <c:if test="${taskBean.scheduleEnabled}">
                    <li class="Schedule">
                        <fmt:message key="taskCalendar.recurrence" bundle="${messages}">
                            <fmt:param value="${taskBean.recurrenceType}"/>
                        </fmt:message>
                    </li>
                </c:if>
                <li class="Controls">
                    <syswf:component prefix="runStop" name="/admin/task/runStopTaskComponent" wrap="false">
                        <syswf:param name="artifact" value="${taskBean.taskArtifact}"/>
                        <syswf:param name="currentViewType" value="calendar"/>
                    </syswf:component> |
                    <syswf:component prefix="editSchedule" name="/admin/task/scheduleTaskButtonInCalendar" wrap="false">
                        <syswf:param name="artifact" value="${taskBean.taskArtifact}"/>
                        <syswf:param name="isScheduled" value="${taskBean.scheduleEnabled}"/>
                    </syswf:component>
                </li>
            </c:otherwise>
        </c:choose>
    </ul>
    <c:if test="${taskBean.taskRunning}">
        <div class="com_simplechart TaskProgress">
            <div class="ChartCanvas">
                <div style="width: 20%;" title="Progress: 20%" class="ChartFill"></div>
            </div>
        </div>
    </c:if>

