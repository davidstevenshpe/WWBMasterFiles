<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="rendererMap" type="java.util.Map"--%>
<%--@elvariable id="myTasksBoxPrefix" type="java.lang.String"--%>
<%--@elvariable id="bean" type="com.hp.systinet.usertask.ui.common.renderer.GenericMyTasksItemRenderer.GenericMyTasksItemRendererBean"--%>

<%--
This renderer requires taskInfo parameter.
--%>

<syswf:component prefix="${prefix}_${bean.taskInfo.uuid}_taskName" name="${rendererMap[bean.taskTypeId]}" wrap="false">
    <syswf:param name="taskInfo" value="${bean.taskInfo}"/>
    <syswf:param name="myTasksBoxPrefix" value="${myTasksBoxPrefix}"/>
    <syswf:param name="class" value="UI Icon Task"/>
</syswf:component>
