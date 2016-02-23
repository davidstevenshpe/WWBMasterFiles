<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.ea.ui.cloudmigration" var="messages"/>

<fmt:message var="deploymentModelLabel" key="cloud.transformation.deployment.model.label" bundle="${messages}"/>
<fmt:message var="deploymentModelEmpty" key="cloud.transformation.deployment.model.empty" bundle="${messages}"/>

<fmt:message var="deploymentModelReferenceDomainDesc" key="cloud.transformation.deployment.model.reference.domain.desc" bundle="${messages}"/>
<fmt:message var="deploymentModelNonReferenceDomainDesc" key="cloud.transformation.deployment.model.non.reference.domain.desc" bundle="${messages}"/>

<fmt:message var="deploymentModelNonReferenceDomain_LinkNew" key="cloud.transformation.deployment.model.non.reference.domain.create.new" bundle="${messages}"/>
<fmt:message var="deploymentModelNonReferenceDomain_LinkExisting" key="cloud.transformation.deployment.model.non.reference.domain.link.existing" bundle="${messages}"/>
<fmt:message var="deploymentModelReferenceDomain_LinkExisting" key="cloud.transformation.deployment.model.reference.domain.link.existing" bundle="${messages}"/>

<fmt:message var="deploymentModelReferenceDomain_RelLabel" key="cloud.transformation.deployment.model.reference.domain.relationship.label" bundle="${messages}"/>

<fmt:message var="deploymentModelDropdown" key="cloud.transformation.deployment.model.help.text.deployment.model.dropdown" bundle="${messages}"/>

<br/>
<div class="flex-container align-center wrap-1200">
	<div class="UI Block" style="flex-grow:2">
		<c:choose>
			<c:when test="${not isAppCompFromReferenceDomain}">
				<table class="UI Table Properties">
				   <colgroup>
				      <col class="LabelCol">
				      <col>
				   </colgroup>
				   <tbody>
				   		<tr>
							<td colspan="2">
								<div class="help-text">${deploymentModelDropdown}</div>
							</td>
						</tr>
					    <tr>
							<th><label style="padding-top: 6px" class="UI Label Inline">${deploymentModelLabel}:</label></th>
							<td>						
								<div id="deploymentModelsDropdown" class="btn-group" style="position: absolute;">
									<c:choose>
										<c:when test="${hasNoDeploymentModel}">
											<button class="btn btn-default value" onclick="javascript:return false;">${deploymentModelEmpty}</button>
											<ul class="dropdown-menu">												
												<li><a href="javascript:void(0)">${deploymentModelEmpty}</a></li>
											</ul>	
										</c:when>
										<c:otherwise>
											<c:set var="selectedDeploymentModel" value="${deploymentModelUuid}"/>
											<c:if test="${empty selectedDeploymentModel}">
												<c:set var="selectedDeploymentModel" value="${deploymentModels[0].uuid}"/>
											</c:if>
											<c:forEach items="${deploymentModels}" var="deploymentModel" varStatus="stat">
												<c:if test="${deploymentModel.uuid eq selectedDeploymentModel}">
													<button class="btn btn-default value" onclick="javascript:return false;">${deploymentModel.name}</button>
												</c:if>
											</c:forEach>											
											<syswf:control mode="script" caption="${prefix}SelectDeploymentModel" action="setDeploymentModel" affects="." loadingMask="true"/>
											<ul class="dropdown-menu">
												<c:forEach items="${deploymentModels}" var="deploymentModel" varStatus="stat">
													<li><a href="javascript:${prefix}SelectDeploymentModel({deploymentModelUuid: '${deploymentModel.uuid}'})">${deploymentModel.name}</a></li>
												</c:forEach>
											</ul>											
										</c:otherwise>
									</c:choose>
									<button class="btn btn-default dropdown-toggle dropdown-toggle-icon" data-toggle="dropdown" type="button">
										<i class="dropdown-caret fa fa-caret-down"></i>
									</button>
								</div>
							</td>
						</tr>	   
				   </tbody>
				</table>
				<br/>
				<c:choose>
					<c:when test="${hasNoDeploymentModel}">
						<syswf:component name="/core/impl/description/customDescription" prefix="serviceDesignsDesc">
			               <syswf:param name="description" value="${deploymentModelNonReferenceDomainDesc}"/>
			            </syswf:component>			            
			            <syswf:component name="/core/layout/relationshipButtonComponent" prefix="associateApplocationReferenceModel" wrap="false">
			            	<syswf:param name="artifact" value="${artifact}"/>
			            	<syswf:param name="relationshipName" value="specializes"/>
			            	<syswf:param name="artifactTypes" value="applicationComponentArtifact"/>
			            	<syswf:param name="label" value="${deploymentModelNonReferenceDomain_LinkExisting}"/>
			            	<syswf:param name="icon" value="fa-link"/>
			            	<syswf:param name="type" value="linkExisting"/>
			            	<syswf:param name="relationWinTitle" value="Select Reference Applications"/>
			            	<%-- only filter from reference model domains --%>
			            	<syswf:param name="domainTypesParam" value="Reference"/>
			            </syswf:component>
			            <syswf:component name="/core/layout/relationshipButtonComponent" prefix="createNewDeploymentModel" wrap="false">
			            	<syswf:param name="artifact" value="${artifact}"/>
			            	<syswf:param name="relationshipName" value="uses"/>
			            	<syswf:param name="artifactTypes" value="infrastructureServiceArtifact"/>
			            	<syswf:param name="label" value="${deploymentModelNonReferenceDomain_LinkNew}"/>
			            	<syswf:param name="icon" value="fa-plus"/>
			            	<syswf:param name="type" value="linkNew"/>
			            </syswf:component>
		            </c:when>
		            <c:otherwise>
		            	<syswf:component name="/cloud/migration/csa/deploymentModelPreview" prefix="deploymentModelPreview">
			               <syswf:param name="uuid" value="${selectedDeploymentModel}"/>
			               <syswf:param name="appCompUuid" value="${artifact._uuid}"/>
			               <syswf:param name="isAppCompFromReferenceDomain" value="${isAppCompFromReferenceDomain}"/><%-- only check in current app comp --%>
			            </syswf:component>
		            </c:otherwise>
	            </c:choose>
			</c:when>
			<c:otherwise>	
				<c:choose>
					<c:when test="${hasNoDeploymentModel}">
						<syswf:component name="/core/layout/relationshipItemComponent" prefix="${prefix}serverClassItemComponent">
							<syswf:param name="relationshipName" value="uses" />
							<syswf:param name="artifact" value="${artifact}" />
							<syswf:param name="label" value="${deploymentModelReferenceDomain_RelLabel}" />
							<syswf:param name="artifactTypes" value="infrastructureServiceArtifact" />
							<syswf:param name="tableViewWndTitle" value="Service Designs"/>
							<syswf:param name="relationWinTitle" value="Select Service Designs" />
							<%-- only show 'Link Existing' --%>
							<syswf:param name="notShowLinkNew" value="true" />
							<%-- only filter from CSA domain --%>
			            	<syswf:param name="domainIdsParam" value="csaServiceDesignsDomain"/>
			            	<syswf:param name="domainNamesParam" value="CSA Service Designs"/>
			            	<%-- filter from not been created using HP EM publishing --%>
			            	<syswf:param name="customDql" value="select a._uuid as uuid,a.name as name, a._artifactTypeName as sdmName, a._sdmName as type, a._ownerName as owner, a.version as version, a._currentStage.name as currentStage,a.description as description, da.name as domain from hpsoaDomainArtifact da, infrastructureServiceArtifact a, deploymentSpecification dp where da.r_localId=a._domainId and (upper(a.name) like :query or upper(a._artifactTypeName) like :query or upper(a.version) like :query) and bind(a.accesses, dp) and dp.deploymentSpecificationType.val = \\\'CSA Service Design\\\'"/>
						</syswf:component>
						<br/>
						<syswf:component name="/core/impl/description/customDescription" prefix="serviceDesignsDesc">
			               <syswf:param name="description" value="${deploymentModelReferenceDomainDesc}"/>
			            </syswf:component>
			            <syswf:component name="/core/layout/relationshipButtonComponent" prefix="linkExistingDeploymentModel" wrap="false">
			            	<syswf:param name="artifact" value="${artifact}"/>
			            	<syswf:param name="relationshipName" value="uses"/>
			            	<syswf:param name="artifactTypes" value="infrastructureServiceArtifact"/>
			            	<syswf:param name="label" value="${deploymentModelReferenceDomain_LinkExisting}"/>
			            	<syswf:param name="icon" value="fa-link"/>
			            	<syswf:param name="type" value="linkExisting"/>			            	
			            	<syswf:param name="relationWinTitle" value="Select Service Designs"/>
			            	<%-- filter from CSA domain --%>
			            	<syswf:param name="domainIdsParam" value="csaServiceDesignsDomain"/>
			            	<syswf:param name="domainNamesParam" value="CSA Service Designs"/>
			            	<%-- filter from not been created using HP EM publishing --%>
			            	<syswf:param name="customDql" value="select a._uuid as uuid,a.name as name, a._artifactTypeName as sdmName, a._sdmName as type, a._ownerName as owner, a.version as version, a._currentStage.name as currentStage,a.description as description, da.name as domain from hpsoaDomainArtifact da, infrastructureServiceArtifact a, deploymentSpecification dp where da.r_localId=a._domainId and (upper(a.name) like :query or upper(a._artifactTypeName) like :query or upper(a.version) like :query) and bind(a.accesses, dp) and dp.deploymentSpecificationType.val = \\\'CSA Service Design\\\'"/>
			            </syswf:component>
					</c:when>
					<c:otherwise>
						<table class="UI Table Properties">
						   <colgroup>
						      <col class="LabelCol">
						      <col>
						   </colgroup>
						   <tbody>
						   		<tr>
									<td colspan="2">
										<div class="help-text">${deploymentModelDropdown}</div>
									</td>
								</tr>
							    <tr>
									<th><label style="padding-top: 6px" class="UI Label Inline">${deploymentModelLabel}:</label></th>
									<td>						
										<div class="btn-group" style="position: absolute;">
											
											<c:set var="selectedDeploymentModel" value="${deploymentModelUuid}"/>
											<c:if test="${empty selectedDeploymentModel}">
												<c:set var="selectedDeploymentModel" value="${deploymentModels[0].uuid}"/>
											</c:if>
											<c:forEach items="${deploymentModels}" var="deploymentModel" varStatus="stat">
												<c:if test="${deploymentModel.uuid eq selectedDeploymentModel}">
													<button class="btn btn-default value" onclick="javascript:return false;">${deploymentModel.name}</button>
												</c:if>
											</c:forEach>											
											<syswf:control mode="script" caption="${prefix}SelectDeploymentModel" action="setDeploymentModel" affects="." loadingMask="true"/>
											<ul class="dropdown-menu">
												<c:forEach items="${deploymentModels}" var="deploymentModel" varStatus="stat">
													<li><a href="javascript:${prefix}SelectDeploymentModel({deploymentModelUuid: '${deploymentModel.uuid}'})">${deploymentModel.name}</a></li>
												</c:forEach>
											</ul>
											<button class="btn btn-default dropdown-toggle dropdown-toggle-icon" data-toggle="dropdown" type="button">
												<i class="dropdown-caret fa fa-caret-down"></i>
											</button>
										</div>
									</td>
								</tr>	   
						   </tbody>
						</table>
						<br/>
						<syswf:component name="/cloud/migration/csa/deploymentModelPreview" prefix="deploymentModelPreview">
			               <syswf:param name="uuid" value="${selectedDeploymentModel}"/>
			               <syswf:param name="appCompUuid" value="${artifact._uuid}"/>
			               <syswf:param name="isAppCompFromReferenceDomain" value="${isAppCompFromReferenceDomain}"/><%-- only check in current app comp --%>
			            </syswf:component>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</div>
</div>