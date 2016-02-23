<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="L10nSCAdministration"/>

<%--@elvariable id="artifactSelector" type="com.hp.systinet.sc.tool.ArtifactSelector"--%>
<c:if test="${not empty artifactSelector}">
    <syswf:block className="UI Block Common">
        <c:choose>
            <c:when test="${not empty artifactSelector.searchSelector}">
                <fmt:message key="viewTask.artifactSearchSection" bundle="${L10nSCAdministration}" var="title"/>
            </c:when>
            <c:otherwise>
                <fmt:message key="viewTask.artifactListSection" bundle="${L10nSCAdministration}" var="title"/>
            </c:otherwise>
        </c:choose>
        <div class="Title">
            <h3><span><c:out value="${title}"/></span></h3>
        </div>

        <div class="Content">
            <syswf:component prefix="artifactSelectorViewer" name="/admin/task/artifactSelector/selectorViewer">
                <syswf:param name="selector" value="${artifactSelector}"/>
            </syswf:component>
        </div>
    </syswf:block>
</c:if>