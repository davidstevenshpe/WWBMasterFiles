<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="pr_Messages" />				
<syswf:block className="UI Block Common">
	<div class="Content">
		<c:choose>
			<c:when test="${sourceType eq 'RSOURCE'}">
				<syswf:component name="/core/table" prefix="complianceArtifactsTable" wrap="false">
				    <syswf:param name="customizationId" value="reports.policy.tableResultsCompliantArtifacts" />
				    <syswf:param name="datasource" value="${complianceArtifactsDataSource}"/>
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
									<fmt:message key="policyreport.view.external.status.label" bundle="${pr_Messages}" />:
								</label></td>
								<td>
									<syswf:component name="/reports/policy/statusRender" prefix="statusRender">
										<syswf:param name="status" value="${complianceBean.status}"/>
										<syswf:param name="color" value="${complianceBean.color}"/>
					            	</syswf:component>
								</td>
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
									<fmt:message key="policyreport.view.external.problems.label" bundle="${pr_Messages}" />:
								</label></td>
								<td><c:out escapeXml="true" value="${complianceBean.problems}"/></td>
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
		<span>${noDataLabel}</span>
	</div>
</syswf:block>

