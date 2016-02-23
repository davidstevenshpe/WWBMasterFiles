<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="L10nSCAdministration" />

<fmt:message var="repositoryDataDiagnosticReport_reportName" key="repositoryDataDiagnosticReport.reportName" bundle="${L10nSCAdministration}"/>
<syswf:component name="/core/report/reportStatus" prefix="reportStatus">
    <syswf:param name="reportArtifact" value="${report}" />    
</syswf:component>

<syswf:block className="UI Block Common">
	<div class="webfw-Window" id="${prefix}-webfw-Window">
		<syswf:component name="/core/table" prefix="table">
    		<syswf:param name="customizationId" value="admin.task.diagnostic.report"/>
    		<syswf:param name="artifact" value="${report}"/>
    		<syswf:param name="hasExpander" value="${true}"/>
    		<c:choose>
            	<c:when test="${reportStatus eq 'NOT_COMPLETE'}">
                	 <syswf:param name="overrideFilter" value="none"/>
                </c:when>
                <c:otherwise>
                	<syswf:param name="overrideFilter" value="auto"/>
            	</c:otherwise>
            </c:choose>
		</syswf:component>
	</div>
</syswf:block>