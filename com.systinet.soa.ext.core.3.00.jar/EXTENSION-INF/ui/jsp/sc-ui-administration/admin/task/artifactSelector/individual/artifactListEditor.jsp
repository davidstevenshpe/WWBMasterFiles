<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--@elvariable id="editorBean" type="com.hp.systinet.sc.ui.admin.task.artifactSelector.individual.ArtifactListEditorBean"--%>
<%--@elvariable id="tableId" type="java.lang.String"--%>
<%--@elvariable id="availableArtifactTypes" type="java.util.List"--%>
<syswf:component name="/core/table" prefix="table">
    <syswf:param name="customizationId" value="admin.task.artifactSelector.individual.editTable"/>
    <syswf:param name="datasource" value="${editorBean.dataSource}" />
    <syswf:param name="tableId" value="${tableId}"/>
    <syswf:param name="provider" value="${editorBean.resultBeansProvider}"/>
    <syswf:param name="availableArtifactTypes" value="${availableArtifactTypes}"/>
</syswf:component>