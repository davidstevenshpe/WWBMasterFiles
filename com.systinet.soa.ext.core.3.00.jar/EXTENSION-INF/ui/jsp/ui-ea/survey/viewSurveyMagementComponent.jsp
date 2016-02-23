<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<syswf:component name="/core/artifact/viewArtifact" prefix="${prefix}${status.index}id" wrap="false">
    <syswf:param name="uuid" value="${surveyUuid}" />
    <syswf:param name="viewId" value="catalog" />
    <syswf:param name="customizationId" value="catalog.viewArtifact.surveyManagementArtifact" />
</syswf:component>