<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<div class="UI Block">
<c:if test="${lifecycleApplicable}">
	<syswf:component prefix="lifecycle" name="/reports/lifecycle/validationResultReport">
	    <syswf:param name="artifactUuid" value="${artifact._uuid}"/>
	</syswf:component>
</c:if>
<script type="text/javascript">
//<![CDATA[
function togglePolicyComplianceRow(expander) {
	var policyRow = $(expander).closest('div.x-grid3-row');
	if(policyRow.hasClass('x-grid3-row-collapsed')) {
		policyRow.addClass('x-grid3-row-expanded').removeClass('x-grid3-row-collapsed');
	}else{
		policyRow.removeClass('x-grid3-row-expanded').addClass('x-grid3-row-collapsed');
	}
} 
//]]>
</script>
<syswf:component prefix="policy" name="/reports/policy/policyComplianceReport">
    <syswf:param name="artifactUuid" value="${artifact._uuid}"/>
</syswf:component>
</div>