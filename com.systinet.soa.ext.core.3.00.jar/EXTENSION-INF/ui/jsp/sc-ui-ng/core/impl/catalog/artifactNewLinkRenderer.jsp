<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<c:if test="${not hiddenLink}">
	<syswf:control mode="anchor" caption="${caption}" targetTask="/common/newArtifact" id="${artifactSdmType.id}_link" targetDepth="0">
		<syswf:param name="artifactType" value="${artifactSdmType.id}"/>
	</syswf:control>	
</c:if>