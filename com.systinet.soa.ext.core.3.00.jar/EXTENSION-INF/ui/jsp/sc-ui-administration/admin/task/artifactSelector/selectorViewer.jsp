<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--@elvariable id="selector" type="com.hp.systinet.sc.tool.ArtifactSelector"--%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>

<%--@elvariable id="mode" type="com.hp.systinet.sc.ui.admin.task.artifactSelector.SelectorMode"--%>
<div>
    <c:choose>
        <c:when test="${mode.name eq 'SEARCH'}">
            <syswf:component prefix="search" name="/core/search/util/searchViewer">
                <syswf:param name="value" value="${selector.searchSelector}"/>
                <syswf:param name="criteriaCustomizationId" value="admin.task.artifactSelector.search.criteria"/>
            </syswf:component>
        </c:when>
        <c:when test="${mode.name eq 'INDIVIDUAL'}">
            <syswf:component prefix="search" name="/admin/task/artifactSelector/individual/artifactListViewer">
                <syswf:param name="selector" value="${selector.individualArtifactSelector}"/>
            </syswf:component>
        </c:when>
    </c:choose>
</div>



