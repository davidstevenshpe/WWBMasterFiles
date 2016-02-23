<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:choose>
	<c:when test="${empty redirectViewId}"><c:set var="customizationId" value="${viewId}.browseArtifact.${this.artifactType}"/></c:when>
	<c:otherwise><c:set var="customizationId" value="${redirectViewId}.browseArtifact.${this.artifactType}"/></c:otherwise>
</c:choose>

<%-- For consistency, keep prefix in sync in view/new/edit pages --%>
<syswf:component name="${this.customizedComponent}" prefix="${this.artifactType}" wrap="false">
    <syswf:param name="customizationId" value="${customizationId}" />
    <syswf:param name="title" value="${this.title}"/>
    <syswf:param name="kind" value="browse"/>
</syswf:component>


