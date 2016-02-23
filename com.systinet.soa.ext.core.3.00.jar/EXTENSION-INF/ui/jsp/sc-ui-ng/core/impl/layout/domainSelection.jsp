<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${visible}">
 <c:choose>
 	<c:when test="${composite}">
		<syswf:component prefix="domainSelectionInReport" name="/core/impl/layout/domainSelectionInReport" wrap="false"/>
	</c:when>
	<c:when test="${not empty activeTab and activeTab eq 'catalog'}">
		<syswf:component prefix="domainSelectionInCatalog" name="/core/impl/layout/domainSelectionInCatalog" wrap="false">
			<syswf:param name="context" value="${context}" />
			<syswf:param name="browseArtifact" value="${browseArtifact}"/>
		</syswf:component>		
	</c:when>
	<c:when test="${not empty activeTab and (activeTab eq 'reports' or activeTab eq 'navigator')}">
		<syswf:component prefix="domainSelectionInReport" name="/core/impl/layout/domainSelectionInReport" wrap="false"/>
	</c:when>
	<c:otherwise>								
	</c:otherwise>
</c:choose>
</c:if>

