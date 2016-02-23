<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${hasWritePermission}">
<c:choose>
	<c:when test="${(this.artifactName == 'personArtifact') and (viewId == 'reports' or viewId == 'admin')}">
		<syswf:control id="addNew" mode="script" caption="${controlName}" hint="" targetTask="/provider/newArtifact">
			<syswf:attribute name="class" value="UI Icon New"/>
			<syswf:param name="sdmName" value="${this.artifactSdmName}"/>
			<syswf:param name="creationListener" value="${this}"/>
		</syswf:control>
	</c:when>
	<c:otherwise>
		<syswf:control id="addNew" mode="script" caption="${controlName}" hint="" targetTask="/${viewId}/newArtifact">
			<syswf:attribute name="class" value="UI Icon New"/>
			<syswf:param name="sdmName" value="${this.artifactSdmName}"/>
			<syswf:param name="creationListener" value="${this}"/>
		</syswf:control>
	</c:otherwise>
</c:choose>
</c:if>