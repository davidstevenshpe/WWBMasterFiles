<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setBundle basename="com.hp.systinet.ea.ui.cloudmigration" var="messages"/>
<fmt:message key="csa.publishing.wizard.serviceDesignNameLabel" var="serviceDesignNameLabel" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.selectInfrastructureServiceLabel" var="selectInfrastructureServiceLabel" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.selectTargetDataCenterLabel" var="selectTargetDataCenterLabel" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.selectCSAServerLabel" var="selectCSAServerLabel" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.InvolvedApps" var="involvedApps" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.InvolvedSystemSoftware" var="involvedSystemSoftware" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.UsedServers" var="usedServers" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.step2Title" var="step2Title" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.buttonPublishLabel" var="buttonPublishLabel" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.buttonPreviousLabel" var="buttonPreviousLabel" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.boxed.message" var="boxMessage" bundle="${messages}"/>
<fmt:message key="csa.publishing.wizard.boxed.title" var="boxTitle" bundle="${messages}"/>

<syswf:control mode="script" caption="${prefix}_nextStep" action="nextStep" targetTask="/artifact/${artifactUuid}">
	<syswf:param name="artifactUuid" value="${artifactUuid}"/>
</syswf:control>
<syswf:control mode="script" caption="${prefix}_previous" action="previous" targetTask="/cloud/migration/csa/startCSAPublishing">
	<syswf:param name="artifactUuid" value="${artifactUuid}"/>
</syswf:control>
<div class="boxed">
	<div id="content-container">
		<div id="page-content">
			<div class="panel">
				<div id="csaPublishing-container" class="eq-height clearfix csaPublishing">
					<div id="csaPublishing-start-wz" class="col-md-5 eq-box-md eq-no-panel ng-isolate-scope">
						<h1>${step2Title}</h1>
						<p class="text-muted"><em></em></p>
						<div>
							<button class="btn btn-gray btn-labeled em fa fa-info-circle" onclick="return emCommon.toggleHelpText(this, 'csaPublishing-start-wz')" help-text="less">
								<span class="csa-property">Show more information</span>
							</button>
						</div>
						<div class="csa-read-only property">
							<div>${serviceDesignNameLabel}</div>
							<div class="help-text"><fmt:message key="csa.publishing.wizard.serviceDesignName.helpText" bundle="${messages}"/></div>
							<div class="csa-readonly-property">
								<syswf:out value="${wizardData.serviceDesignName}" context="HtmlBody"/>
							</div>
						</div>
						<div class="csa-read-only property">
							<div>${involvedApps}</div>
							<div class="help-text"><fmt:message key="csa.publishing.wizard.InvolvedApps.helpText" bundle="${messages}"/></div>
							<div class="csa-readonly-property">
							  <c:forEach var="attr" items="${wizardData.involvedAppComponents}" varStatus="status">
							  		<a href='../../../artifact/${attr.first}' target="_blank"><syswf:out value="${attr.second}" context="HtmlBody"/></a>
							  		<c:if test="${status.index lt fn:length(wizardData.involvedAppComponents) - 1}">
							  			<span style="margin: 0 3px 0 -3px;">,</span>
									</c:if>
							  </c:forEach>
							  <c:if test="${empty wizardData.involvedAppComponents}">&nbsp;</c:if>							
							</div>
						</div>
						<div class="csa-read-only property">
							<div>${involvedSystemSoftware}</div>
							<div class="help-text"><fmt:message key="csa.publishing.wizard.InvolvedSystemSoftware.helpText" bundle="${messages}"/></div>
							<div class="csa-readonly-property">
							  <c:forEach var="attr" items="${wizardData.involvedSystemSoftware}" varStatus="status">
							  		<a href='../../../artifact/${attr.first}' target="_blank"><syswf:out value="${attr.second}" context="HtmlBody"/></a>
							  		<c:if test="${status.index lt fn:length(wizardData.involvedSystemSoftware) - 1}">
							  			<span style="margin: 0 3px 0 -3px;">,</span>
									</c:if>
							  </c:forEach>
							  <c:if test="${empty wizardData.involvedSystemSoftware}">&nbsp;</c:if>							
							</div>
						</div>
						<div class="csa-read-only property">
							<div>${usedServers}</div>
							<div class="help-text"><fmt:message key="csa.publishing.wizard.UsedServers.helpText" bundle="${messages}"/></div>
							<div class="csa-readonly-property">
							  <c:forEach var="attr" items="${wizardData.servers}" varStatus="status">
							  		<a href='../../../artifact/${attr.first}' target="_blank"><syswf:out value="${attr.second}" context="HtmlBody"/></a>
							  		<c:if test="${status.index lt fn:length(wizardData.servers) - 1}">
							  		<span style="margin: 0 3px 0 -3px;">,</span>
							  		</c:if>
							  </c:forEach>
							  <c:if test="${empty wizardData.servers}">&nbsp;</c:if>
							</div>
						</div>
						<div class="csa-read-only property">
							<div>${selectTargetDataCenterLabel}</div>
							<div class="help-text"><fmt:message key="csa.publishing.wizard.selectTargetDataCenter.step2.helpText" bundle="${messages}"/></div>
							<div class="csa-readonly-property">
								<syswf:out value="${wizardData.targetDataCenterName}" context="HtmlBody"/>
							</div>
						</div>
						<div class="csa-read-only property">
							<div>${selectCSAServerLabel}</div>
							<div class="help-text"><fmt:message key="csa.publishing.wizard.selectCSAServer.step2.helpText" bundle="${messages}"/></div>
							<div class="csa-readonly-property">
								<syswf:out value="${wizardData.csaServerName}" context="HtmlBody"/>
							</div>
						</div>
						<div class="pad-no pad-btm csa-button">						
							<button id="previous-wz-start-button" type="button" class="cancel btn btn-primary">${buttonPreviousLabel}</button>
							<button id="next-wz-start-button" type="button" class="next btn btn-primary">${buttonPublishLabel}</button>
						</div>
					</div>
					<div id="info-container" class="col-md-5 eq-box-md text-center box-vmiddle-wrap bg-primary">
						<div survey-info="" class="box-vmiddle pad-all ng-isolate-scope" preview-link="true" survey-instance="surveyInstance" theme="surveyDefinition.survey.theme">
							<div class="content definition-name" ng-switch="" on="previewLink">
								<h2 class="text-thin" style="padding-bottom: 30px;">${boxTitle}</h2>
							</div>
							<span class="icon-wrap icon-wrap-lg icon-circle bg-trans-light"> <i class="fa fa-cloud fa-5x text-primary"></i></span>
							<div class="csaPublishing-box-message">${boxMessage}</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
// <![CDATA[	
    $(document).ready(function () {
	    $('#previous-wz-start-button').click(function(){
	    	${prefix}_previous('${bean.artifactUuid}');
	    });   
	    
	    $('#next-wz-start-button').click(function(){
	    	${prefix}_nextStep('${bean.artifactUuid}');
	    });
	    layoutManager.loadStyle(['<c:out value='${webResourcePath}'/>/skinem/bootstrap/css/survey.css']);
	});
// ]]>
</script>