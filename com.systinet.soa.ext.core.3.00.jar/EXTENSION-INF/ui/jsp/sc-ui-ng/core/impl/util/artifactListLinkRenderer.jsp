<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="messages"/>
<fmt:message key="artifactListLinkRenderer.showMore" var="showMore" bundle="${messages}"/>
<fmt:message key="artifactListLinkRenderer.showLess" var="showLess" bundle="${messages}"/>

<%--@elvariable id="artifactNames" type="java.util.List"--%>
<%--@elvariable id="artifactUuids" type="java.util.List"--%>
<%--@elvariable id="artifactTabId" type="java.lang.String"--%>
<%--@elvariable id="defaultShow" type="java.lang.Integer"--%>
<%--@elvariable id="emptyListKey" type="java.lang.String"--%>
<%--@elvariable id="inline" type="java.lang.Boolean"--%>

<%--
This component accepts the following parameters:
* artifactNames - List<String>
* artifactUuids - List<String> or List<Uuid>
* artifactTabId - id of artifact tab that should be selected
* defaultShow - how many items to show by default before more link (1 is default), must be greater or equal than 1
* emptyListKey - L10n key for message when list is empty
* inline - Boolean. When true then span will be used instead of div. Avoids line break.
--%>

<c:if test="${(empty defaultShow) or (defaultShow lt 1)}">
    <c:set var="defaultShow" value="1"/>
</c:if>
<c:choose>
    <c:when test="${not empty inline and inline}">
        <c:set var="outerTag" value="span"/>
    </c:when>
    <c:otherwise>
        <c:set var="outerTag" value="div"/>
    </c:otherwise>
</c:choose>

<${outerTag} id="${prefix}artifactListLink" class="DatagridEditableCell">
<c:choose>
    <c:when test="${(not empty artifactNames) and (not empty artifactUuids)}">
        <c:forEach var="val" varStatus="status" end="${defaultShow-1}" items="${artifactNames}">
             <syswf:component prefix="${prefix}${status.index}v" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                 <syswf:param name="caption" value="${artifactNames[status.index]}"/>
                 <syswf:param name="uuid" value="${artifactUuids[status.index]}"/>
                 <c:if test="${not empty artifactTabId}">
                     <syswf:param name="artifactTabId" value="${artifactTabId}"/>
                 </c:if>
             </syswf:component>
            <c:if test="${not status.last}">,</c:if>
        </c:forEach>

        <c:if test="${fn:length(artifactNames) gt defaultShow}">
            <span class="HiddenOptions">
                <c:forEach var="val" varStatus="status" begin="${defaultShow}" items="${artifactNames}">
                    <c:out value=","/>
                    <syswf:component prefix="${prefix}${status.index}h" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                    <syswf:param name="caption" value="${artifactNames[status.index]}"/>
                    <syswf:param name="uuid" value="${artifactUuids[status.index]}"/>
                    <c:if test="${not empty artifactTabId}">
                        <syswf:param name="artifactTabId" value="${artifactTabId}"/>
                    </c:if>
                 </syswf:component>
                </c:forEach>
            </span>
            <span class="ControlShowMore"> (<a href="javascript:void(0)" onclick="Datagrid.Handler.HiddenDataSwitch('${prefix}artifactListLink');">${fn:length(artifactNames) - defaultShow} ${showMore}</a>)</span>
            <span class="ControlShowLess"> (<a href="javascript:void(0)" onclick="Datagrid.Handler.HiddenDataSwitch('${prefix}artifactListLink');">${showLess}</a>)</span>
        </c:if>
    </c:when>
    <c:otherwise>
        <fmt:message key="${emptyListKey}" bundle="${messages}"/>
    </c:otherwise>
</c:choose>
</${outerTag}>
