<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:if test="${not empty uuid}">
<div class="issueCont">
	<div class="issueSub">
   		<syswf:component name="/core/impl/widget/artifactLinkWidget" prefix="tp_link">
			<syswf:param name="uuid" value="${uuid}"/>
			<syswf:param name="sdmName" value="${sdmName}"/>
			<syswf:param name="caption" value="${technicalPolicyName}"/>
			<syswf:param name="mode" value="table"/>
			<syswf:param name="style" value="${color}"/>
		</syswf:component>
	</div>
</div>
</c:if>
<c:if test="${(not empty details)}">
<div class="issueCont">	
	<div class="issueSub">
		<span style="${color}">
			<syswf:component name="/core/impl/widget/textWidget" prefix="details">
				<syswf:param name="value" value="${details}"/>
				<syswf:param name="mode" value="table"/>
			</syswf:component>
		</span>
	</div>
</div>
</c:if>
