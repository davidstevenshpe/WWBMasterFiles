<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${allow_to_delete}">    
    <syswf:component name="/core/contextActions/deleteArtifact" prefix="deleteArtifact">
		<syswf:param name="artifact" value="${artifact}" />
        <syswf:param name="includeSubArtifacts" value="false"/>
	</syswf:component>    
</c:if>