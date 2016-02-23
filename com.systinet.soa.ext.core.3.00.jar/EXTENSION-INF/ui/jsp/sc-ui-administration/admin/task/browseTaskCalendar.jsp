<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>
<fmt:message key="taskCalendar.title" var="title" bundle="${messages}"/>
<fmt:message key="taskCalendar.runningNow" var="runningNow" bundle="${messages}"/>
<fmt:message key="taskCalendar.thisMonth" var="thisMonth" bundle="${messages}"/>
<fmt:message key="taskCalendar.thisWeek" var="thisWeek" bundle="${messages}"/>
<fmt:message key="taskCalendar.scheduled" var="scheduled" bundle="${messages}"/>
<fmt:message key="taskCalendar.noSchedule" var="noSchedule" bundle="${messages}"/>
<fmt:message key="taskCalendar.today" var="today" bundle="${messages}"/>
<fmt:message key="taskCalendar.noTasks" var="noTasks" bundle="${messages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels"/>
<fmt:message key="pageHelp.moreLink" var="moreLink" bundle="${labels}"/>

<%--@elvariable id="bean" type="com.hp.systinet.sc.ui.admin.task.BrowseTaskCalendar.Bean"--%>
<%--@elvariable id="deploymentUrl" type="java.lang.String"--%>
<%--@elvariable id="LIMIT" type="java.lang.Integer"--%>

<c:set var="limit" value="4"/>

<syswf:component prefix="leftColumn.contextButtons" name="/core/layout/contextActions" >
    <syswf:param name="customizationId" value="admin.task.browseTaskContextActions"/>
</syswf:component>

<c:if test="${bean.nothingToShow}">
    <syswf:out value="${noTasks}" context="HtmlBody"/>
</c:if>
<c:if test="${not empty bean.runningTasks}">
    <syswf:block className="UI Block Green">
        <div class="Title">
            <h3><span><syswf:out value="${runningNow}" context="HtmlBody"/></span></h3>
        </div>
        <div class="Content">
            <table class="UI Table Grid">
                <col>
                <col>
                <col>
                <c:forEach items="${bean.runningTasks}" var="taskBean" varStatus="status">
                    <c:if test="${status.index % limit == 0}"><tr></c:if>
                    <td>
                        <syswf:component prefix="runningTask${status.index}" name="/admin/task/taskCalendarItem"
                                         wrap="false">
                            <syswf:param name="taskBean" value="${taskBean}"/>
                        </syswf:component>
                    </td>
                    <c:if test="${(status.count % limit == 0) || status.last}"></tr></c:if>
                </c:forEach>
            </table>

        </div>
    </syswf:block>
</c:if>
<c:if test="${not empty bean.todayTasks or not empty bean.weekTasks or not empty bean.monthTasks}">
    <syswf:block className="UI Block Common">
        <div class="Title">
            <h3><span><syswf:out value="${scheduled}" context="HtmlBody"/></span></h3>
        </div>
        <div class="Content">
            <c:if test="${not empty bean.todayTasks}">
                <div class="Title"><h4><syswf:out value="${today}" context="HtmlBody"/></h4></div>
                <table class="UI Table Grid">
                    <col>
                    <col>
                    <col>
                    <c:forEach items="${bean.todayTasks}" var="taskBean" varStatus="status">
                        <c:if test="${status.index % limit == 0}"><tr></c:if>
                        <td>
                            <syswf:component prefix="todayTask${status.index}" name="/admin/task/taskCalendarItem"
                                             wrap="false">
                                <syswf:param name="taskBean" value="${taskBean}"/>
                            </syswf:component>
                        </td>
                        <c:if test="${(status.count % limit == 0) || status.last}"></tr></c:if>
                    </c:forEach>
                </table>
            </c:if>
            <c:if test="${not empty bean.weekTasks}">
                <div class="Title"><h4><syswf:out value="${thisWeek}" context="HtmlBody"/></h4></div>
                <table class="UI Table Grid">
                    <col>
                    <col>
                    <col>
                    <c:forEach items="${bean.weekTasks}" var="taskBean" varStatus="status">
                        <c:if test="${status.index % limit == 0}"><tr></c:if>
                        <td>
                            <syswf:component prefix="weekTask${status.index}" name="/admin/task/taskCalendarItem"
                                             wrap="false">
                                <syswf:param name="taskBean" value="${taskBean}"/>
                            </syswf:component>
                        </td>
                        <c:if test="${(status.count % limit == 0) || status.last}"></tr></c:if>
                    </c:forEach>
                </table>
            </c:if>
            <c:if test="${not empty bean.monthTasks}">
                <div class="Title"><h4>${thisMonth}</h4></div>
                <table class="UI Table Grid">
                    <col>
                    <col>
                    <col>
                    <c:forEach items="${bean.monthTasks}" var="taskBean" varStatus="status">
                        <c:if test="${status.index % limit == 0}"><tr></c:if>
                        <td>
                            <syswf:component prefix="monthTask${status.index}" name="/admin/task/taskCalendarItem"
                                             wrap="false">
                                <syswf:param name="taskBean" value="${taskBean}"/>
                            </syswf:component>
                        </td>
                        <c:if test="${(status.count % limit == 0) || status.last}"></tr></c:if>
                    </c:forEach>
                </table>
            </c:if>
        </div>
    </syswf:block>
</c:if>
<c:if test="${not empty bean.noScheduleTasks}">
    <syswf:block className="UI Block Common">
        <div class="Title">
            <h3><span><syswf:out value="${noSchedule}" context="HtmlBody"/></span></h3>
        </div>
        <div class="Content">
            <table class="UI Table Grid">
                <col>
                <col>
                <col>
                <c:forEach items="${bean.noScheduleTasks}" var="taskBean" varStatus="status">
                    <c:if test="${status.index % limit == 0}"><tr></c:if>
                    <td>
                        <syswf:component prefix="noSchedTask${status.index}" name="/admin/task/taskCalendarItem"
                                         wrap="false">
                            <syswf:param name="taskBean" value="${taskBean}"/>
                        </syswf:component>
                    </td>
                    <c:if test="${(status.count % limit == 0) || status.last}"></tr></c:if>
                </c:forEach>
            </table>
        </div>
    </syswf:block>
</c:if>
