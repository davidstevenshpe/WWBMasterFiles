<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="selectedArtifactCount" value="${fn:length(wizardData.selectedArtifactUuids)}"/>
<c:set var="selectedCount" value="${fn:length(wizardData.responses)}"/>

<fmt:setBundle basename="com.hp.systinet.ea.ui.surveymessages" var="messages"/>
<fmt:message var="title" key="survey.wizard.title" bundle="${messages}">
	<fmt:param value="'${wizardData.definitionName}'"/>
</fmt:message>
<fmt:message var="summary" key="survey.wizard.summary" bundle="${messages}">
	<fmt:param value="'${wizardData.definitionName}'"/>
</fmt:message>
<fmt:message var="artifactNumber" key="survey.wizard.summary.artifactNumber" bundle="${messages}">
	<fmt:param value="${selectedArtifactCount}"/>
</fmt:message>
<fmt:message var="questionNumber" key="survey.wizard.summary.questionNumber" bundle="${messages}">
	<fmt:param value="${wizardData.questionNumber}"/>
</fmt:message>

<fmt:message var="surveyedArtifact" key="survey.surveyed.artifacts.table.label" bundle="${messages}"/>
<fmt:message var="surveyedArtifactDesc" key="survey.surveyed.artifacts.reviewtable.label" bundle="${messages}"/>
<fmt:message var="addRespondentLabel" key="survey.respondent.add" bundle="${messages}"/>
<fmt:message var="addRespondentNoPermissionWarning" key="survey.respondent.no.permission.warning" bundle="${messages}"/>
<fmt:message var="removeRespondentAtLeastOneWarning" key="survey.respondent.one.warning" bundle="${messages}"/>

<fmt:message var="notification" key="survey.wizard.summary.notification" bundle="${messages}"/>

<c:if test="${empty wizardData.name}">
	<syswf:control mode="script" caption="${prefix}_firstStep" action="firstStep" targetTask="/survey/startSurvey">
		<syswf:param name="surveyDefUuid" value="${surveyDefUuid}"/>
	</syswf:control>
	<script type="text/javascript">
//<![CDATA[
	
	${prefix}_firstStep();
	
//]]>
	</script>
</c:if>

<c:set var="peopleInt" value="${fn:length(wizardData.responses)}"/>
<c:set var="peopleMessageKey">
	<c:choose>
		<c:when test="${peopleInt gt 1}">survey.wizard.summary.peopleNumber</c:when>
		<c:otherwise>survey.wizard.summary.personNumber</c:otherwise>
	</c:choose>
</c:set>

<fmt:message var="peopleNumber" key="${peopleMessageKey}" bundle="${messages}">
	<fmt:param value="${peopleInt}"/>
</fmt:message>
<c:set var="finishMessageKey">
	<c:choose>
		<c:when test="${wizardData.sendEmailNotification}">survey.wizard.finish.message</c:when>
		<c:otherwise>survey.wizard.finish.message.noemail</c:otherwise>
	</c:choose>
</c:set>

<div class="boxed">
	<div id="content-container">
		<div id="page-content">
			<div class="panel pad-hor">
				<div id="survey-container" class="eq-height clearfix">
					<div id="survey-start-wz">
						<h2><c:out value="${title}"/></h2>
						<div id="start-survey-progress-bar" class="pad-ver" style="display:none">
						<div class="col-lg-5 pad-no progress progress-sm progress-striped active" style="height: 10px">
							<div class="progress-bar" style="width: 100%;"></div>
						</div>
						<p class="text-muted pad-top">
							<br/><c:out value="${finishMessage}" escapeXml="false"/>
						</p>
						</div>
						<div id="survey-summary-finish">
							<p class="text-muted pad-top"><c:out value="${summary}"/></p>
							<div class="pad-lft">
								<ul class="summary pad-all">
									<li><c:out value="${artifactNumber}" escapeXml="false"/></li>
									<li><c:out value="${peopleNumber}" escapeXml="false"/></li>
									<li><c:out value="${questionNumber}" escapeXml="false"/></li>
								</ul>
							</div>	
							<c:if test="${wizardData.sendEmailNotification}">
								<p class="col-lg-7 pad-no">
									<c:out value="${notification}"/>
								</p>
							</c:if>
							<div class="col-lg-7 pad-no pad-ver">
								<h2><c:out value="${surveyedArtifact}"/></h2>
								<p class="pad-top"><c:out value="${surveyedArtifactDesc}"/></p>
								<div id="surveyed-artifact-review"></div>
							</div>

							<div class="col-lg-7 pad-no pad-ver">
								<button id="prev-wz-start-button" type="button" class="prev btn btn-primary">Previous</button>
								<c:choose>
									<c:when test="${selectedArtifactCount eq 0}"><button id="next-wz-start-button" type="button" class="next btn btn-primary disabled">Finish</button></c:when>
									<c:otherwise><button id="next-wz-start-button" type="button" class="next btn btn-primary" <c:if test="${peopleInt == 0}"> <c:out value="disabled" /></c:if>>Finish</button></c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div></div>
</div>

<syswf:input id="surveyInstanceData" name="surveyInstanceData" mode="hidden" value="" />
<syswf:control mode="script" caption="${prefix}_prevStep" action="prevStep" targetTask="/survey/startSurveySelection">
	<syswf:param name="surveyDefUuid" value="${surveyDefUuid}"/>
</syswf:control>
<syswf:control mode="script" caption="${prefix}_nextStep" action="nextStep"/>


<syswf:input id="removeArtifactUuids" name="removeArtifactUuids" mode="hidden" value="" />
<syswf:control mode="script" caption="${prefix}_removeArtifactsFromSurvey" action="removeArtifactsFromSurvey"/>

<syswf:input id="surveyedArtifactUuid" name="surveyedArtifactUuid" mode="hidden" value="" />
<syswf:input id="respondentUuid" name="respondentUuid" mode="hidden" value="" />
<syswf:control mode="script" caption="removeRespondentFromArtifact" action="removeRespondentFromArtifact"/>

<syswf:component name="/survey/respondentSelector" prefix="${prefix}addRespondentWindow">
	<syswf:param name="dialogTitle" value="${addRespondentLabel}"/>
	<syswf:param name="openFceName" value="openAddRespondentWindowFuncName"/>
	<syswf:param name="providerSelectorListener" value="${listener}"/>
	<syswf:param name="overrideselectionModel" value="multiple" />
	<syswf:param name="winWidth" value="650" />
	<syswf:param name="submitBeforeCreation" value="." />
</syswf:component>
    
<script type="text/javascript">
//<![CDATA[

var surveyDefinition = {}, surveyedArtifact = {}, surveyInstance = {};
var localMsg2 = {
		noPermission: '<syswf:out value="${addRespondentNoPermissionWarning}" context="HtmlJSText"/>',
   		atLeastOne: '<syswf:out value="${removeRespondentAtLeastOneWarning}" context="HtmlJSText"/>'
	};

Ext4.onReady(function() {

	var artifact2respondents = eval('(${artifact2Respondents})');
	var data = [];
	var versionValue = "1.0";
		<c:forEach var="artifact" items="${wizardData.selectedArtifacts}">
		<c:catch var="exception">${artifact.version}</c:catch>
		<c:if test="${empty exception}">versionValue = "${artifact.version}";</c:if>	
		data[data.length] = {uuid: '${artifact._uuid}',name: '<syswf:out value="${artifact.name}" context="HtmlJSText"/>',version:versionValue,responses: artifact2respondents['${artifact._uuid}']}
	</c:forEach>

	var artifactTable = Ext4.create('EA.model.table.survey.SurveyedArtifactsReviewTable', {
        renderTo: 'surveyed-artifact-review',
        hideStatusColumn: true,
        data: data,
        pageSize: ${this.pageSize},
        localMsg: localMsg2,
        onAfterRemove: function(selectionModel) {
        	var uuids = '';
        	for(var i = 0; i < selectionModel.selected.items.length; i++) {
        		var item = selectionModel.selected.items[i];
        		var uuid = item.data.uuid;
                uuids += (i > 0 ? ',' : '') + uuid;
        	}
            Ext4.get('removeArtifactUuids').dom.value = uuids;
            ${prefix}_removeArtifactsFromSurvey();
        },
        respondentRenderer: function(v, m, record){

			var content = '<p class="multi-lines">';
			for(var i = 0; i < v.length; i++) {
				var resp = v[i];
				var link = artifactTable.renderRemoveRespondentMenu(resp.contactUUID, resp.contactName, record.data.uuid, v.length);
				content += '<span class="survey-user not-submitted">' + link + '</span>';
				if(i < v.length -1) content += ', ';
			}
			content += '</p>';
      	  	if(v.length > 5) {
      			content += '<span class="more" onclick="emCommon.toggleTextareaCell(this,{containerId:\'' + this.id + '\',css:\'top-right\'})"><i class="fa fa-ellipsis-h"></i></span>';
    	  	}
			return content;
        }
    });
    $('#prev-wz-start-button').click(function(){
    	var uuids = '';
    	for(var i = 0; i < data.length; i++) {
    		uuids += (i > 0 ? ',' : '') + data[i].uuid;
    	}
    	Ext.get('surveyInstanceData').dom.value = uuids;
        ${prefix}_prevStep();
    });
    $('#next-wz-start-button').click(function(){
    	$('#start-survey-progress-bar').toggle();
    	$('#survey-summary-finish').toggle();
    	var uuids = '';
    	for(var i = 0; i < data.length; i++) {
    		uuids += (i > 0 ? ',' : '') + data[i].uuid;
    	}
    	Ext.get('surveyInstanceData').dom.value = uuids;
        ${prefix}_nextStep();
    });
});

//]]>
</script>

