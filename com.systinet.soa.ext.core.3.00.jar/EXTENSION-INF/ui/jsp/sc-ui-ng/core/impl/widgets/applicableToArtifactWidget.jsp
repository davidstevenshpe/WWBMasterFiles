<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${not this.browserPageArtifact}">
         <a href="${this.artifactTaskUri}" target="_blank"><c:out value="${this.value}" /></a>
    </c:when>
	<c:otherwise>
		 <c:out value="${this.value}" />
	</c:otherwise>
</c:choose>	
