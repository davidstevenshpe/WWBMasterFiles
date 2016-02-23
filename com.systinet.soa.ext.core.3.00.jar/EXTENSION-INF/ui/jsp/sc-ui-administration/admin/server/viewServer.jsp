<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test ="${not empty artifact}">
    <syswf:component name="/core/layout/header" prefix="header" wrap="false">
        <syswf:param name="title" value="${artifact.name}" />
        <syswf:param name="subtitle" value="${subtitle}" />
        <syswf:param name="subtitleClass" value="Artifact" />
        <syswf:param name="iconType" value="${artifact._artifactSdmName}" />
        <syswf:param name="iconFormat" value="small" />
        <syswf:param name="artifactUuid" value="${artifact._uuid}" />
        <syswf:param name="artifactDeleted" value="${artifactDeleted}" />
    </syswf:component>
    <c:if test="${not empty taskArtifact}">
	    <syswf:component name="/admin/task/runningTaskProgressBar" prefix="${prefix}_progress">
	        <syswf:param name="artifact" value="${taskArtifact}" />
	    </syswf:component>
    </c:if>
	<syswf:component name="/core/layout/columns" prefix="${prefix}_viewServerArtifact" wrap="false">
	    <syswf:param name="subtitle" value="${subtitle}" />
	    <syswf:param name="artifact" value="${artifact}" />
	    <syswf:param name="artifactDeleted" value="${artifactDeleted}" />
	    <syswf:param name="customizationId" value="admin.viewArtifact.${artifact._artifactSdmName}"/>
	</syswf:component>
</c:if>