<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.contract.ui.impl.ContractUIMessages" var="msg"/>
<c:choose>
	<c:when test="${disableCM}">
	</c:when>
	<c:otherwise>
		<syswf:component name="/core/layout/header" prefix="header" wrap="false">
		    <syswf:param name="subtitle" value="${this.bean.subtitle}" />
		    <syswf:param name="subtitleClass" value="Artifact" />
		    <syswf:param name="iconType" value="${this.bean.artifact._artifactSdmName}" />
		    <syswf:param name="iconFormat" value="small" />
		</syswf:component>
		
		<syswf:component name="/core/layout/columns" prefix="${this.bean.artifact.artifactDescriptor.artifactSdmName}" wrap="false">
		    <syswf:param name="customizationId" value="${this.bean.customizationId}" />
		    <syswf:param name="artifact" value="${this.bean.artifact}" />
		    <syswf:param name="pageModel" value="${this.model}" />
		    <syswf:param name="validationReport" value="${this.bean}" />
		</syswf:component>
		
		<syswf:component name="/contract/impl/create/newRequestButtons" prefix="b">
		    <syswf:param name="model" value="${this.model}"/>
		</syswf:component>
		
		<syswf:component name="/util/stayLoggedIn" prefix="stayLoggedIn" wrap="false" />
	</c:otherwise>
</c:choose>

