<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="message"/>

<fmt:message var="transformationStrategyLabel" key="cloudMigration.transformationStrategy.label" bundle="${message}"/>
<fmt:message var="transformationStrategyHelpText" key="cloudMigration.transformationStrategy.helptext" bundle="${message}"/>
<fmt:message var="deploymentModelsToAutomateLabel" key="cloudMigration.deploymentModelsToAutomate.label" bundle="${message}"/>
<fmt:message var="deploymentModelsToAutomateHelpText" key="cloudMigration.deploymentModelsToAutomate.helptext" bundle="${message}"/>
<fmt:message var="automatedDeploymentModelsLabel" key="cloudMigration.automatedDeploymentModels.label" bundle="${message}"/>
<fmt:message var="automatedDeploymentModelsHelpText" key="cloudMigration.automatedDeploymentModels.helptext" bundle="${message}"/>

<div style="margin: 15px 0 10px 0;">
	<table class="UI Table Properties">
		<colgroup>
			<col class="LabelCol">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<td colspan="2">
					<div class="help-text">
						<c:out value="${transformationStrategyHelpText}" />
					</div>
				</td>
		   	</tr>
			<tr>
				<th>
					<label class="UI Label Inline"> 
						<c:out value="${transformationStrategyLabel}" />:
					</label>
				</th>
				<td>
					<c:choose>
						<c:when test="${cloudTransformationStrategy == null}">N/A</c:when>
						<c:otherwise><c:out value="${cloudTransformationStrategy.name}"/></c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="help-text">
						<c:out value="${deploymentModelsToAutomateHelpText}" />
					</div>
				</td>
		   	</tr>
			<tr>
				<th>
					<label class="UI Label Inline"> 
						<c:out value="${deploymentModelsToAutomateLabel}" />:
					</label>
				</th>
				<td>
					<c:forEach items="${deploymentModelsToAutomate}" var="pair" varStatus="status">
					    <syswf:control mode="anchor" caption="${pair.second}" targetTask="/artifact/${artifact._uuid}" targetDepth="0">
					    	<syswf:param name="tabId" value="cloudMigration"/>
					    	<syswf:param name="subTabId" value="deploymentModels"/>
					    	<syswf:param name="selectedDeploymentModel" value="${pair.first}"/>
					    </syswf:control>
						<c:if test="${!status.last}" >,</c:if>
					</c:forEach>
					<c:if test="${fn:length(deploymentModelsToAutomate) == 0}" >N/A</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="help-text">
						<c:out value="${automatedDeploymentModelsHelpText}" />
					</div>
				</td>
		   	</tr>
			<tr>
				<th>
					<label class="UI Label Inline"> 
						<c:out value="${automatedDeploymentModelsLabel}" />:
					</label>
				</th>
				<td>
					<c:forEach items="${automatedDeploymentModels}" var="pair" varStatus="status">
					    <syswf:control mode="anchor" caption="${pair.second}" targetTask="/artifact/${artifact._uuid}" targetDepth="0">
					    	<syswf:param name="tabId" value="cloudMigration"/>
					    	<syswf:param name="subTabId" value="deploymentModels"/>
					    	<syswf:param name="selectedDeploymentModel" value="${pair.first}"/>
					    </syswf:control>
						<c:if test="${!status.last}" >,</c:if>
					</c:forEach>
					<c:if test="${fn:length(automatedDeploymentModels) == 0}" >N/A</c:if>
				</td>
			</tr>
		</tbody>
	</table>
</div>
