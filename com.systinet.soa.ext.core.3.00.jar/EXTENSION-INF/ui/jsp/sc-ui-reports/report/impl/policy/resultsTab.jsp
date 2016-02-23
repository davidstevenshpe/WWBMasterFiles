<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--

If validationResultId or validationExecutionUuid parameter is present, we display the validation report. Otherwise we display
the standard page listing artifacts and their compliance %, from which they can view the report.

--%>

<%--@elvariable id="validationResultId" type="java.lang.Object"--%>
<%--@elvariable id="validationExecutionUuid" type="java.lang.Object"--%>

<c:choose>
    <c:when test="${not empty validationResultId or not empty validationExecutionUuid}">
        <syswf:component prefix="resultsTabContent" name="/core/layout/columns">
            <syswf:param name="customizationId" value="reports.viewArtifact.hpsoaPolicyReportArtifact.resultsReport"/>
            <syswf:param name="validationResultId" value="${validationResultId}"/>
            <syswf:param name="kind" value="reports" />
        </syswf:component>
    </c:when>
    <c:otherwise>
        <syswf:component prefix="resultsTabContent" name="/core/layout/columns">
            <syswf:param name="customizationId" value="reports.viewArtifact.hpsoaPolicyReportArtifact.resultsList"/>
            <syswf:param name="kind" value="reports" />
        </syswf:component>
    </c:otherwise>
</c:choose>
