<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="pr_Messages" />
<td>		
<syswf:block className="UI Block Common">
	<div class="Title">
		<h3>
		<c:choose>
			<c:when test="${sourceType eq 'RSOURCE'}">		
				<fmt:message key="policyreport.overview.compliant.header" bundle="${pr_Messages}" />
			</c:when>
			<c:otherwise>
				<fmt:message key="policyreport.overview.external.header" bundle="${pr_Messages}" />
			</c:otherwise>
		</c:choose>
		</h3>
	</div>
	<div class="Content">
		<c:choose>
			<c:when test="${sourceType eq 'RSOURCE'}">
				<syswf:component name="/core/table" prefix="compliantArtifactsTable" wrap="false">
				    <syswf:param name="customizationId" value="reports.policy.tableOverviewCompliantArtifacts" />
				    <syswf:param name="datasource" value="${compliantArtifactsDataSource}"/>
				    <c:if test="${empty uuid}">
				    	<syswf:param name="uuid" value="${artifact._uuid}"/>
				    </c:if>
				</syswf:component>
			</c:when>
			<c:otherwise>
				<c:if test="${not empty complianceBean}">
					<table class="UI Table Layout">
					 	<tbody> 
							<tr>
								<td><label class="UI Label Inline">
									<fmt:message key="policyreport.view.external.document.label" bundle="${pr_Messages}" />:
								</label></td>
								<td><c:out escapeXml="true" value="${complianceBean.name}"/></td>
							</tr>
							<tr>
								<td><label class="UI Label Inline">
									<fmt:message key="policyreport.view.external.compliance.label" bundle="${pr_Messages}" />:
								</label></td>
								<td>
									<syswf:component name="/reports/policy/complianceRender" prefix="complianceRender">
										<syswf:param name="compliance" value="${complianceBean.compliance}"/>
										<syswf:param name="color" value="${complianceBean.color}"/>
					            	</syswf:component>
								</td>
							</tr>
							<tr>
								<td><label class="UI Label Inline">
									<fmt:message key="policyreport.view.external.detailId.label" bundle="${pr_Messages}" />:
								</label></td>
								<td>
									<syswf:component name="/reports/policy/detailIdRender" prefix="detailIdRender">
										<syswf:param name="detailId" value="${complianceBean.detailId}"/>
					            	</syswf:component>
								</td>
							</tr>
						</tbody>
					</table>
				</c:if>
			</c:otherwise>
		</c:choose>
		<br>
		<c:if test="${not empty noDataLabel}">
		<c:set var="recalculate_link"><a class="print-hide" href="../artifact/${artifact._uuid}?action=compliance">recalculate</a><span class="print-show hide-not-print" >recalculate</span></c:set>
		<fmt:message bundle="${pr_Messages}" key="policyreport.nevercalculate.labellink" var="recalculate_msg">
			<fmt:param value="${recalculate_link}"/>
		</fmt:message>
		<span>${recalculate_msg}</span>
		<br><br>
		</c:if>
		<a class="print-hide" href="../artifact/${artifact._uuid}?tabId=results">${moreLink}</a>
	</div>
</syswf:block>
</td>