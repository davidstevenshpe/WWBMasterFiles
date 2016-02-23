<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="report_Message"/>

<c:if test ="${not empty reportLinkAsPdf}">
     <a href="${reportLinkAsPdf}" class ="UI PageAction Download" target="_blank"><fmt:message key="birt_report.action.view_as_pdf.label" bundle="${report_Message}"/> </a>
</c:if>
<c:if test="${not empty reportLinkAsHtml}">
     <a href="${reportLinkAsHtml}" class ="UI PageAction Download" target="_blank"><fmt:message key="birt_report.action.view_as_html.label" bundle="${report_Message}"/> </a>
</c:if>