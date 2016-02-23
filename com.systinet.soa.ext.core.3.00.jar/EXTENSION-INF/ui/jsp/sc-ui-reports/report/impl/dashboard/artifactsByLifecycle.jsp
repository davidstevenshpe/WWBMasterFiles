<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="report_Message"/>
<fmt:message var="title" key="dashboard.artifact_by_lifecycle.title" bundle="${report_Message}" />

<syswf:component name="/reports/chart/pieChartTableInternal" prefix="artifactsByLifecycle">
    <syswf:param name="datasource" value="${datasource}" />
    <syswf:param name="domainFilterType">${domainFilterType}</syswf:param>
    <syswf:param name="table" value="${lifecycleTable}" />
    <syswf:param name="title" value="${title}" />    
</syswf:component>