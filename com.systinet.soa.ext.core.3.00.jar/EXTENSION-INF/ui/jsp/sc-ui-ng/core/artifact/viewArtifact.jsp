<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not this.redirect}">
	    <syswf:component name="/core/layout/header" prefix="header" wrap="false">
	        <syswf:param name="title" value="${this.artifact.name}" />
	        <syswf:param name="domainLabel" value="${domainLabel}" />
	        <syswf:param name="subtitle" value="${this.subtitle}" />
	        <syswf:param name="lifecycleInformation" value="${lifecycleInformation }"/>
	        <c:choose>
	             <c:when test="${userStatus eq 'S1'}">
	                 <syswf:param name="subtitleClass" value="UI Icon Contact" />
	             </c:when>
	             <c:when test="${userStatus eq 'S2'}">
	                  <syswf:param name="subtitleClass" value="UI Icon Contact Disabled" />
	             </c:when>
	             <c:when test="${userStatus eq 'S3'}">
	                  <syswf:param name="subtitleClass" value="UI Icon Contact Retired" />
	             </c:when>
	             <c:otherwise>
	                  <syswf:param name="subtitleClass" value="Artifact" />
	                  <syswf:param name="iconType" value="${this.artifact._artifactSdmName}" />
	             </c:otherwise>
	        </c:choose>
	        <syswf:param name="iconFormat" value="small" />
	        <syswf:param name="showRating" value="${(not this.system) and empty this.artifact._sliceTime and this.showRating}" />
	        <syswf:param name="artifactUuid" value="${this.artifact._uuid}" />
	        <syswf:param name="artifactDeleted" value="${artifactDeleted}" />
	        <syswf:param name="artifactLocked" value="${artifactLocked}" />
	        <c:if test="${not empty this.artifact._sliceTime}">
	            <c:choose>
	                <c:when test="${artifactLastRevision}">
	                    <syswf:param name="artifactRevisionNumber" value="-1" />
	                </c:when>
	                <c:otherwise>
	                    <syswf:param name="artifactRevisionNumber" value="${artifactRevisionNumber}" />
	                </c:otherwise>
	            </c:choose>
	        </c:if>
	        <syswf:param name="artifactCustomizationId" value="${this.customizationId}" />
	        <syswf:param name="wrap" value="false" />
	    </syswf:component>
    <%-- For consistency, keep prefix in sync in view/new/edit pages --%>
    <syswf:component name="${this.customizedComponent}" prefix="props" wrap="false">
        <syswf:param name="customizationId" value="${this.customizationId}" />
        <syswf:param name="artifact" value="${this.artifact}" />
        <syswf:param name="wrap" value="false" />
    </syswf:component>
</c:if>