<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>
<fmt:message bundle="${messages}" key="editCustomTask.schedule" var="scheduleLabel" />
<fmt:message bundle="${messages}" key="editTask.setSchedule" var="setScheduleLabel" />

<syswf:component prefix="scheduleTaskWindow" name="/core/task/scheduleTaskWindow">
    <syswf:param name="taskArtifact" value="${artifact}"/>
    <syswf:param name="updateArtifact" value="${false}"/>
    <syswf:param name="checkOnStartDate" value="${true}"/>
    <syswf:param name="winTitle"><fmt:message key="scheduleTaskButton_label" bundle="${messages}"/></syswf:param>
    <syswf:param name="winOpenFunctionName">${prefix}fnOpenTaskScheduleWin</syswf:param>
    <syswf:param name="reloadComponent">${prefix}</syswf:param>    
</syswf:component>

<table class="UI Table Properties">
<col class="LabelCol">
<col>
    <tbody>
        <tr>
            <td><label class="UI Label Inline"><syswf:out value="${scheduleLabel}" context="HtmlBody"/>:</label>
            </td>
            <td> 
            
                <c:choose>
                    <c:when test="${noSchedule}">
                        <span class="IconAlign"><fmt:message bundle="${messages}" key="editTask.noSchedule" /></span><br/>
                    </c:when>
                    <c:otherwise>
                        <table class="UI Table Properties">
                            <col class="LabelCol"/>
                            <col/>                    
                            <tr>
                                <th><label class="UI Label Inline">
                                    <fmt:message key="scheduledWidget_nextRun" bundle="${messages}"/>:
                                </label></th>
                                <td>
                                    <syswf:component prefix="taskTime" name="/admin/task/scheduledRunTime" wrap="false">
                                        <syswf:param name="scheduled" value="${artifact.scheduled}"/>
                                    </syswf:component>
                                </td>
                            </tr>
                            <tr>
                                <th><label class="UI Label Inline">
                                    <fmt:message key="scheduledWidget_recurrence" bundle="${messages}"/>:
                                </label></th>
                                <td><span class="IconAlign"><syswf:out value="${recurrence}" context="HtmlBody"/></span></td>
                            </tr>
                        </table>     
                    </c:otherwise>                                                       
                </c:choose>
                             
                <syswf:control mode="button" caption="${setScheduleLabel}"  onSubmit="${prefix}fnOpenTaskScheduleWin"></syswf:control>
            </td>
        </tr>
    </tbody>
</table>
