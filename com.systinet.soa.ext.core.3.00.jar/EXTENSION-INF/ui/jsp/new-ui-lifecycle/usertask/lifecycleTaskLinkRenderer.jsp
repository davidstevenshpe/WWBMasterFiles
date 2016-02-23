<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--
This component produces a link to artifact page where the user task may be completed.
It accepts either parameters caption & uuid or the taskInfo. When taskInfo is supplied it
also supports displaying artifact name after task name (parameter showArtifactName).
--%>

<%--@elvariable id="bean" type="com.hp.systinet.lifecycle.ui.usertask.LifecycleTaskLinkRenderer.LifecycleTaskLinkRendererBean"--%>

<%-- Lifecycle Request & Task User Task link points to lifecycle tab of artifact page--%>
<syswf:component prefix="${prefix}taskLink" name="/core/impl/util/artifactLinkRenderer" wrap="false">
    <syswf:param name="caption" value="${bean.caption}"/>
    <syswf:param name="uuid" value="${bean.uuid}"/>
    <syswf:param name="artifactTabId" value="lifecycle"/>
    <syswf:param name="class" value="${class}"/>
</syswf:component>
