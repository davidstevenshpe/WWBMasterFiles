<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />

<ul>
<c:forEach items="${referencingArtifacts}" var="artifact" varStatus="status">
    <li>
    	<c:choose>
		    <c:when test="${artifact._artifactSdmName eq 'formValidation'}">
				<c:out value="${artifact.name}"/> (<fmt:message key="delete.artifactValidationLink" bundle="${messages}"/>)
			</c:when>
			<c:when test="${artifact._artifactSdmName eq 'lifeCycle'}">
				<syswf:component prefix="processLink_${status.index}" name="/newUi/lc/common/renderer/processLinkRenderer" wrap="false">
					<syswf:param name="caption" value="${artifact.name}"/>
					<syswf:param name="processUuid" value="${artifact._uuid}"/>
				</syswf:component>
			</c:when>
			<c:otherwise>
		        <syswf:component prefix="al${status.index}" name="/core/impl/util/artifactLinkRenderer" wrap="false">
		            <syswf:param name="uuid" value="${artifact._uuid}"/>
		            <syswf:param name="caption" value="${artifact.name}"/>
		            <syswf:param name="sdmName" value="${artifact._artifactSdmName}" />
		        </syswf:component>
		    </c:otherwise>
		</c:choose>
    </li>
</c:forEach>
</ul>