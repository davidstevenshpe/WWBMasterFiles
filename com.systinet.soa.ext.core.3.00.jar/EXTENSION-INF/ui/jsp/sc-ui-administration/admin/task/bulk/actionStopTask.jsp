<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="canDisplayButton" type="boolean"--%>
<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.generated.artifacts.sys.TaskArtifact"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="selectionBag" type="com.hp.systinet.sc.ui.impl.table.SelectionBag<String>"--%>
<%--@elvariable id="confirmDialogMessage" type="java.lang.String"--%>
<c:if test="${canDisplayButton}">
    <fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>

    <c:if test="${empty confirmDialogMessage}">
        <fmt:message key="actionStopTask_confirmDialogText" bundle="${messages}" var="confirmDialogMessage"/>
    </c:if>
    <syswf:control mode="script" action="stopTaskAction" caption="${prefix}stopTask">
        <syswf:param name="selectionBag" value="${selectionBag}"/>
        <syswf:param name="artifact" value="${artifact}"/>
    </syswf:control>
    <syswf:component name="/core/impl/util/dialog" prefix="stopTaskConfirmDialog">
        <syswf:param name="handler" value="${prefix}stopTask"/>
        <syswf:param name="heading"><fmt:message key="actionStopTask_confirmDialogHeading"
                                                 bundle="${messages}"/></syswf:param>
        <syswf:param name="content">${confirmDialogMessage}</syswf:param>
        <syswf:param name="noUndo" value="false"/>
    </syswf:component>

    <%--if we are not in table, display the link--%>
    <c:if test="${empty selectionBag}">
        <%--@elvariable id="linkLabel" type="java.lang.String"--%>
        <c:if test="${empty linkLabel}">
            <fmt:message key="browseTaskTable_stop" bundle="${messages}" var="linkLabel"/>
        </c:if>
        <%--@elvariable id="currentViewType" type="java.lang.String"--%>
        <c:choose>
            <c:when test="${currentViewType eq 'calendar'}">
                <c:set var="linkIconClass">UI Icon GovernanceStop</c:set>
                <c:set var="innerText">${linkLabel}</c:set>
            </c:when>
            <c:otherwise>
                <c:set var="linkIconClass">context-button Stop</c:set>
                <c:set var="title">${linkLabel}</c:set>
            </c:otherwise>
        </c:choose>

        <a id="${prefix}stopTaskButton" href="javascript:void(0);" class="${linkIconClass}" title="${title}">
            <c:out value="${innerText}"/>
        </a>
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                Ext.get('${prefix}stopTaskButton').on('click', ${prefix}_stopTaskConfirmDialog_control);
            });
        
//]]>
</script>
    </c:if>

</c:if>