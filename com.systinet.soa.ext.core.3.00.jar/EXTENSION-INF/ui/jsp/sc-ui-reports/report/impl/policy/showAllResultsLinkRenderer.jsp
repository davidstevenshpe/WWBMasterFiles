<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="messages"/>
<fmt:message key="validationResult.showAllResults.label" bundle="${messages}" var="resultLinkCaption"/>

<syswf:component name="/core/impl/util/artifactLinkRenderer" prefix="showAllResults">
    <syswf:param name="uuid">${uuid}</syswf:param>
    <syswf:param name="caption">${resultLinkCaption}</syswf:param>
    <syswf:param name="class">UI PageAction ListView</syswf:param>
    <syswf:param name="artifactTabId">results</syswf:param>
</syswf:component>
