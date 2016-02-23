<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="artifactLifecycleData" type="com.hp.systinet.lifecycle.ui.common.ArtifactLifecycleData"--%>
<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.ArtifactBase"--%>
<%--@elvariable id="generalUpdateRegions" type="java.util.Set"--%>
<syswf:component prefix="columns" name="/newUi/lc/catalog/tab/lifecycleTabContents">
    <syswf:param name="artifactUuid" value="${artifact._uuid}"/>
    <syswf:param name="artifactLifecycleData" value="${artifactLifecycleData}"/>
    <syswf:param name="generalUpdateRegions" value="${generalUpdateRegions}"/>
</syswf:component>
