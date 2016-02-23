<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="report_Message"/>
<fmt:message var="title" key="dashboard.contact_management.title" bundle="${report_Message}" />

<syswf:component name="/reports/chart/pieChartTableInternal" prefix="contractManagement">
    <syswf:param name="datasource" value="${datasource}" />
    <syswf:param name="table" value="${table}" />
    <syswf:param name="title" value="${title}" />    
</syswf:component>