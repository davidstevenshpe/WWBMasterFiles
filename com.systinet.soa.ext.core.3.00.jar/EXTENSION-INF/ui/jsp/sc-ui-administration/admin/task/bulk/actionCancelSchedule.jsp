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
    <fmt:message key="actionCancelSchedule_confirmDialogText" var="confirmDialogText" bundle="${messages}"/>
    <fmt:message key="browseTaskTable_cancelSchedule" bundle="${messages}" var="title"/>
    <syswf:control mode="script" action="cancelScheduleAction" caption="${prefix}cancelSchedule">
        <syswf:param name="selectionBag" value="${selectionBag}"/>
        <syswf:param name="artifact" value="${artifact}"/>
    </syswf:control>
    <syswf:component name="/core/impl/util/dialog" prefix="cancelScheduleConfirmDialog">
        <syswf:param name="handler" value="${prefix}cancelSchedule"/>
        <%--@elvariable id="confirmDialogTitle" type="java.lang.String"--%>
        <syswf:param name="heading"><fmt:message key="actionCancelSchedule_confirmDialogHeading"
                                                 bundle="${messages}"/></syswf:param>
        <%--@elvariable id="confirmDialogMessage" type="java.lang.String"--%>
        <syswf:param name="content">${confirmDialogText}</syswf:param>
        <syswf:param name="noUndo" value="false"/>
    </syswf:component>

    <%--if we are not in table, display the link--%>
    <c:if test="${not empty artifact}">
        <a id="${prefix}cancelScheduleButton" href="javascript:void(0);" class="context-button CancelSchedule" title="${title}">
        </a>
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                Ext.get('${prefix}cancelScheduleButton').on('click', ${prefix}_cancelScheduleConfirmDialog_control);
            });
        
//]]>
</script>
    </c:if>

</c:if>