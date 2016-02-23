<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:component name="/core/impl/wizard" prefix="${viewId}.addArtifactWizard">
    <syswf:param name="customizationId" value="shared.artifactTypeWizard.addArtifactTypeWizard"/>
    <syswf:param name="controller" value="${wizardController}"/>
</syswf:component>