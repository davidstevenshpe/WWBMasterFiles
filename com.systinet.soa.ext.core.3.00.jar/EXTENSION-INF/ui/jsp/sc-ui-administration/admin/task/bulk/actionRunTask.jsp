<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="canDisplayButton" type="boolean"--%>
<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.generated.artifacts.sys.TaskArtifact"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<c:if test="${canDisplayButton}">
    <fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>
    <fmt:message key="actionRunTask_confirmDialogText" var ="confirmDialogText" bundle="${messages}"/>
    <fmt:message key="browseTaskTable_run" bundle="${messages}" var="title"/>
    <syswf:control mode="script" action="runTaskAction" caption="${prefix}runTask">
        <syswf:param name="selectionBag" value="${selectionBag}"/>
        <syswf:param name="artifact" value="${artifact}"/>
    </syswf:control>
    <syswf:component name="/core/impl/util/dialog" prefix="runTaskConfirmDialog">
        <syswf:param name="handler" value="${prefix}runTask"/>
        <%--@elvariable id="confirmDialogTitle" type="java.lang.String"--%>
        <syswf:param name="heading"><fmt:message key="actionRunTask_confirmDialogHeading"
                                                 bundle="${messages}"/></syswf:param>
        <%--@elvariable id="confirmDialogMessage" type="java.lang.String"--%>
        <syswf:param name="content">${confirmDialogText}</syswf:param>
        <syswf:param name="noUndo" value="false"/>
    </syswf:component>

    <%--if we are not in table, display the link--%>
    <c:if test="${not empty artifact}">
        <%--@elvariable id="currentViewType" type="java.lang.String"--%>
        <c:choose>
            <c:when test="${currentViewType eq 'calendar'}">
                <c:set var="linkIconClass">UI Icon GovernanceStart</c:set>
                <fmt:message key="browseTaskTable_run" bundle="${messages}" var="innerText"/>
            </c:when>
            <c:otherwise>
                <c:set var="linkIconClass">context-button Run</c:set>
                <fmt:message key="browseTaskTable_run" bundle="${messages}" var="title"/>
            </c:otherwise>
        </c:choose>

        <a id="${prefix}runTaskButton" href="javascript:void(0);" class="${linkIconClass}" title="${title}">
        	<c:out value="${innerText}"/>
        </a>
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                Ext.get('${prefix}runTaskButton').on('click', ${prefix}_runTaskConfirmDialog_control);
            });
        
//]]>
</script>
    </c:if>

</c:if>