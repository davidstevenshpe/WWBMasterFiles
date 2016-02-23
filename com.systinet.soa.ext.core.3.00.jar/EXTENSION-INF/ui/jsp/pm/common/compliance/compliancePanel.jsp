<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:component prefix="lifecycle" name="/pm/common/compliance/lifecycleCompliancePanel">
	<syswf:param name="artifact" value="${artifact}"/>
</syswf:component>
<syswf:component prefix="policy" name="/reports/policy/policyCompliancePanel">
    <syswf:param name="artifactUuid" value="${artifact._uuid}"/>
    <syswf:param name="overview" value="true"/>
</syswf:component>