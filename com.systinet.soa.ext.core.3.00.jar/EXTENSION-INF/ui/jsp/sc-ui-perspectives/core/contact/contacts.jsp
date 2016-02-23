<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:component name="/core/layout/columns" prefix="${artifact}.contacts" wrap="false">
    <syswf:param name="artifactUuid" value="${artifactUuid}"/>
    <syswf:param name="customizationId" value="${viewId}.viewArtifact.${artifactLocalName}.contacts"/>
</syswf:component>