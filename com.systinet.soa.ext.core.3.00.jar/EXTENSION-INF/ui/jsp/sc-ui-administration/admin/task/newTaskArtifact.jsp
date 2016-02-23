<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="L10nSCAdministration"/>
<%-- TODO - copied from newArtifact.jsp - will be modified --%>
<%--@elvariable id="taskType" type="java.lang.String"--%>
<c:set var="headerTitle">
    <c:choose>
        <c:when test="${taskType == 'artifactSync'}"><fmt:message key="newTaskArtifact_addArtifactSyncTask" bundle="${L10nSCAdministration}"/></c:when>
        <c:when test="${taskType == 'customTask'}"><fmt:message key="newTaskArtifact_addArtifactCustom" bundle="${L10nSCAdministration}"/></c:when>        
        <c:otherwise>${this.bean.artifact.name}</c:otherwise>
    </c:choose>
</c:set>


<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${headerTitle}" />
</syswf:component>


<c:choose>
    <c:when test="${taskType == 'artifactSync'}">
        <div style="font-style:italic;margin:8px">
            <fmt:message key="newTaskArtifact_addArtifactSyncTask_description" bundle="${L10nSCAdministration}"/>
        </div>
    </c:when>
    <c:when test="${taskType == 'customTask'}">
        <div style="font-style:italic;margin:8px">
            <fmt:message key="newTaskArtifact_addArtifactCustom_description" bundle="${L10nSCAdministration}"/>
        </div>
    </c:when>
</c:choose>

<%-- For consistency, keep prefix in sync in view/new/edit pages --%>
<syswf:component name="/core/layout/columns" prefix="props" wrap="false">
    <syswf:param name="customizationId" value="${this.bean.customizationId}" />
    <syswf:param name="artifact" value="${this.bean.artifact}" />
    <syswf:param name="validationReport" value="${this.bean}" />
    <syswf:param name="artifactBean" value="${this.bean}" />
</syswf:component>

<hr />

<syswf:block className="UI Block Green Last">
    <div class="Content">
        <div class="UI Form Controls">
            <%-- TODO REVIEW (Svata, 3/04/2009): HTML mockups use buttons --%>
                    <%-- TODO REVIEW (Svata, 3/04/2009): I18N --%>
            <syswf:control mode="postAnchor" action="save" caption="Save">
                <syswf:attribute name="class" value="btn btn-primary" />
            </syswf:control>
            <%-- TODO REVIEW (Svata, 3/04/2009): I18N --%>
            <syswf:control mode="postAnchor" action="cancel" caption="Cancel" targetDepth="${sessionStack.currentDepth-1}">
                <syswf:attribute name="class" value="btn btn-gray" />
            </syswf:control>
        </div>
    </div>
</syswf:block>
<syswf:component name="/util/stayLoggedIn" prefix="stayLoggedIn" wrap="false" />