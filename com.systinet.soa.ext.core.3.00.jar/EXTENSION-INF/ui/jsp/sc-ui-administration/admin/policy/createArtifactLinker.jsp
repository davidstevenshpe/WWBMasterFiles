<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${enablePolicyManagement and canCreateTechnicalPolicy}">
<syswf:control mode="script" caption="${controlName}" targetTask="/admin/newArtifact" >
	<syswf:param name="artifactType">hpsoaTechnicalPolicyArtifact</syswf:param>
</syswf:control>
</c:if>