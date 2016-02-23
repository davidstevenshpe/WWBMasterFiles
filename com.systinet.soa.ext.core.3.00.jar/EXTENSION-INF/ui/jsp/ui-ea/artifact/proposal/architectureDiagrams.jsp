<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="uisccomponentsmessages"/>
<fmt:message var="proposalDiagramDesc" bundle="${uisccomponentsmessages}" key="proposal.architecture.diagram.description"/>
<c:set var="dqlCondition">
<c:forEach var="package" items="${plateauAssociatedPackageGroup}"  varStatus="status"><c:if test="${status.index gt 0}"> or </c:if>a.repositoryPackage.val like '${package.val}%' </c:forEach>
</c:set>
<c:set var="dql">
<c:if test="${fn:length(plateauAssociatedPackageGroup) > 0}">
select a.name, a._uuid, a._sdmName from diagramArtifact a where ${dqlCondition}
</c:if>
</c:set>
<syswf:component name="/core/artifactOverview" prefix="${prefix}Overview" wrap="false">
    <syswf:param name="artifact" value="${artifact}"/>
    <syswf:param name="content">{
	groups: [{
		items: [{
			label: "Architecture Diagrams",
			tooltip: "${proposalDiagramDesc}",
			sdmName: "diagramArtifact",
			dql: "${dql}",
			dqlCondition: "${dqlCondition}"
		}]
	}]
}</syswf:param>
    <syswf:param name="dql" value="${dql}"/>
</syswf:component>