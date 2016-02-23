<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${enablePolicyManagement}">
	<li>
    <syswf:control id="admin.${artifactType}" caption="${label}" mode="anchor" targetTask="/admin/browseArtifact" targetDepth="0">
    	<syswf:param name="artifactType">${artifactType}</syswf:param>
    </syswf:control>    
    </li>
    <c:if test="${addRuler eq 'yes'}">
    	<hr />
    </c:if>
</c:if>