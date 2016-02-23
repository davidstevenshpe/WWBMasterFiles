<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:choose>
	
	<c:when test="${hasError}">
		<p class="UI Icon Delete"><syswf:out value="${name}" context="HtmlBody"/></p>
	</c:when>
	
	<c:otherwise>
		<syswf:control id="${prefix}artifactLinker" caption="${name}" mode="anchor" targetTask="/admin/viewArtifact">
    		<syswf:param name="uuid">${uuid}</syswf:param>
	    </syswf:control>
	</c:otherwise>	
	
</c:choose>
