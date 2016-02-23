<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="messages"/>

<syswf:block className="UI Block Common">

    <div class="Title">
        <h3><span><fmt:message key="validationResult.policycompliance" bundle="${messages}"/></span></h3>
    </div>
    <div class="Content">
    <i>Check the aggregated policy violations from all known
        <syswf:control id="gov5" mode="anchor" caption="policy reports" targetTask="/reports/browseArtifact">
            <syswf:param name="artifactType" value="hpsoaPolicyReportArtifact"/>
        </syswf:control>. You can review the current policy reports and also
        <syswf:control id="gov6" mode="anchor" caption="define a new one." targetTask="/reports/newReportArtifact">
            <syswf:param name="artifactType" value="hpsoaPolicyReportArtifact"/>
            <syswf:param name="collectionId" value="hpsoaPolicyReports"/>
        </syswf:control> You can do that on the "Reports" tab by selecting Create under All Reports.</i>
    <br/>
    <br/>

    <c:choose>
        <c:when test="${not empty complianceInPercents && complianceInPercents > -1}">

            <div class="UI Block">
                <fmt:message key="validationResult.currentStatus" bundle="${messages}" var="currentStatus">
                    <fmt:param value="${complianceInPercents}"/>
                </fmt:message>
                <b><span>${currentStatus}</span></b>
                <fmt:message key="validationResult.currentStatusProblems" bundle="${messages}" var="complianceProblems">
                    <fmt:param value="${problemsFound}"/>
                </fmt:message>
                <br/>
                <b><span>${complianceProblems}</span></b>
            </div>

            <div style="position: relative;margin-top: 10px">
                <syswf:component name="/core/table" prefix="compliantArtifactsTable" wrap="false">
                    <syswf:param name="customizationId" value="reports.policy.tableOverviewPolicyComplianceTab" />
                    <syswf:param name="datasource" value="${policiesDataSource}"/>
                </syswf:component>
            </div>
            
        </c:when>
        <c:otherwise>
            <br/>
            <b>No issues have been found so far.</b>
        </c:otherwise>
    </c:choose>
    </div>
</syswf:block>
