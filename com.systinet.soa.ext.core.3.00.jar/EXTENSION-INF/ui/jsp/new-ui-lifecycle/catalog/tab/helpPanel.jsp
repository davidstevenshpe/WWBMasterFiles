<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="artifactLifecycleData" type="com.hp.systinet.lifecycle.ui.common.ArtifactLifecycleData"--%>

<c:choose>
    <c:when test="${artifactLifecycleData.governed and artifactLifecycleData.underSameProcessSinceRevision}">
        <c:choose>
            <c:when test="${artifactLifecycleData.inLastRevision and artifactLifecycleData.root}">
                <c:set var="customizationId" value="catalog.lifecycle.pageHelp.rootArtifactHelp"/>
            </c:when>
            <c:when test="${artifactLifecycleData.inLastRevision and not artifactLifecycleData.root}">
                <c:set var="customizationId" value="catalog.lifecycle.pageHelp.subArtifactHelp"/>
            </c:when>
            <c:otherwise>
                <c:set var="customizationId" value="catalog.lifecycle.pageHelp.oldRevisionHelp"/>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${artifactLifecycleData.governed and not artifactLifecycleData.underSameProcessSinceRevision}">
        <c:set var="customizationId" value="catalog.lifecycle.pageHelp.differentProcessHelp"/>
    </c:when>
    <c:when test="${not artifactLifecycleData.governed and artifactLifecycleData.governedInRevision}">
        <c:set var="customizationId" value="catalog.lifecycle.pageHelp.governedInRevisionHelp"/>
    </c:when>
    <c:when test="${not artifactLifecycleData.governed and not artifactLifecycleData.inLastRevision}">
        <c:set var="customizationId" value="catalog.lifecycle.pageHelp.nonGovernedInRevisionHelp"/>
    </c:when>
    <c:otherwise>
        <c:set var="customizationId" value="catalog.lifecycle.pageHelp.nonGovernedHelp"/>
    </c:otherwise>
</c:choose>

<syswf:component prefix="help" name="/core/help/pageHelp">
    <syswf:param name="customizationId" value="${customizationId}"/>
</syswf:component>