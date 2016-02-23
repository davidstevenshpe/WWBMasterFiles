<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="caption" type="java.lang.String"--%>
<%--@elvariable id="sourceTypeId" type="java.lang.String"--%>
<%--@elvariable id="uuid" type="com.hp.systinet.repository.sdm.properties.Uuid"--%>
<%--@elvariable id="rendererMap" type="java.util.Map"--%>
<%--@elvariable id="taskInfo" type="com.hp.systinet.usertask.TaskInfo"--%>
<%--@elvariable id="bean" type="com.hp.systinet.usertask.ui.common.renderer.GenericTaskLinkRenderer.GenericTaskLinkRendererBean"--%>
<%--@elvariable id="showArtifactName" type="java.lang.Boolean"--%>

<%--
This renderer requires either taskInfo parameter or caption, uuid and sourceTypeId.
showArtifactName is only accepted if taskInfo is provided.
--%>

<c:choose>
    <c:when test="${not empty bean.taskInfo}">
        <syswf:component prefix="${prefix}_${bean.taskInfo.uuid}_taskName" name="${rendererMap[bean.taskTypeId]}" wrap="false">
            <syswf:param name="taskInfo" value="${bean.taskInfo}"/>
            <syswf:param name="showArtifactName" value="${showArtifactName}"/>
        </syswf:component>
    </c:when>
    <c:otherwise>
        <syswf:component prefix="${prefix}_${sourceTypeId}_${uuid}_taskName" name="${rendererMap[sourceTypeId]}" wrap="false">
            <syswf:param name="caption" value="${caption}"/>
            <syswf:param name="uuid" value="${uuid}"/>
            <syswf:param name="artifactUuid" value="${artifactUuid}"/>
        </syswf:component>
    </c:otherwise>
</c:choose>
