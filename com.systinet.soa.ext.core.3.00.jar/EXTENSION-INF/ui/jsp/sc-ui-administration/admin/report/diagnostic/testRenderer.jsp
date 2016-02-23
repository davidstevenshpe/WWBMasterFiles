<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${(not empty testSuiteName)}">
<div class="issueCont">
   <div class="issueSub">
		<syswf:component name="/core/impl/widget/artifactLinkWidget" prefix="script_link">
			<syswf:param name="uuid" value="${scriptArtifactUuid}"/>
			<syswf:param name="sdmName" value="r_scriptArtifact"/>
			<syswf:param name="caption" value="${testSuiteName}"/>
			<syswf:param name="mode" value="table"/>
			<syswf:param name="linkMode" value="artifact"/>
			<syswf:param name="style" value="${color}"/>
		</syswf:component>
	</div>
</div>
</c:if>
