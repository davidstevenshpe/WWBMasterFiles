<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setBundle basename="com.hp.systinet.report.ui.lifecycle.LifecycleReportMessages" var="messages"/>
<fmt:message key="validatedTasksRenderer.showMore" var="showMore" bundle="${messages}"/>
<fmt:message key="validatedTasksRenderer.showLess" var="showLess" bundle="${messages}"/>

<%--@elvariable id="validatedTaskNames" type="java.util.List"--%>
<%--@elvariable id="defaultShow" type="java.lang.Integer"--%>

<%--
This component accepts the following parameters:
* validatedTaskNames - List<String>
* defaultShow - how many items to show by default before more link (1 is default), must be greater or equal than 1
--%>

<c:if test="${(empty defaultShow) or (defaultShow lt 1)}">
    <c:set var="defaultShow" value="1"/>
</c:if>

<c:if test="${not empty validatedTaskNames}">
    <div id="${prefix}validatedTasks" class="DatagridEditableCell">
        <c:forEach var="val" varStatus="status" end="${defaultShow-1}" items="${validatedTaskNames}">
            <c:out value="${validatedTaskNames[status.index]}"/>
            <c:if test="${not status.last}">,</c:if>
        </c:forEach>

        <c:if test="${fn:length(validatedTaskNames) gt defaultShow}">
            <span class="HiddenOptions">
                <c:forEach var="val" varStatus="status" begin="${defaultShow}" items="${validatedTaskNames}">
                    <c:out value=","/>
                    <c:out value="${validatedTaskNames[status.index]}"/>
                </c:forEach>
            </span>
            <span class="ControlShowMore"> (<a href="javascript:void(0)" onclick="Datagrid.Handler.HiddenDataSwitch('${prefix}validatedTasks');">${fn:length(validatedTaskNames) - defaultShow} ${showMore}</a>)</span>
            <span class="ControlShowLess"> (<a href="javascript:void(0)" onclick="Datagrid.Handler.HiddenDataSwitch('${prefix}validatedTasks');">${showLess}</a>)</span>
        </c:if>
    </div>
</c:if>
