<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="uimessages"/>
<c:if test="${empty label}">
  <fmt:message var="label" key="survey.offer.answers.label" bundle="${uimessages}"/>
</c:if>
<c:set var="artifactName"><syswf:out value="${artifact.name}" context="HtmlBody"/></c:set>

<c:if test="${not unallowedToViewButton}">
<div id="${prefix}_viewAnswersDiv" style="margin: 15px 0 10px 5px; display: inline-block;">
    <button class="btn btn-gray btn-labeled em fa fa-list-alt" onclick="${prefix}_showRespondentAnswer();return false" help-text="less"><span><c:out value="${label}"/></span></button>
</div>
</c:if>

<syswf:component name="/data/js" prefix="survey_answer">
    <syswf:param name="sourceId" value="viewSurveyAnswerComponent"/>
  	<syswf:param name="code">
        function getRespondentAnswer(artifactUuid, surveyDefUuid, surveyDefIncluded) {
          return Packages.com.hp.systinet.ea.ui.survey.SurveyedArtifactsComponent.getInstance().getRespondentAnswer(artifactUuid, surveyDefIncluded, surveyDefUuid);
        }
        function getRespondentAnswersBySurveyUuid(artifactUuid, surveyUuid, surveyDefIncluded) {
          return Packages.com.hp.systinet.ea.ui.survey.SurveyedArtifactsComponent.getInstance().getRespondentAnswers(artifactUuid, surveyUuid, surveyDefIncluded);
        }
  	</syswf:param>
</syswf:component>

<script type="text/javascript">
//<![CDATA[

    function ${prefix}_showRespondentAnswer() {
        // support optional param surveyUuid/surveyDefUuid
        var surveyUuid = '${surveyUuid}';
        var optionalSurveyDefUuid = '${surveyDefUuid}';
		var artifactUuid = '${artifact._uuid}';

        if (surveyUuid != null && surveyUuid != '') {
            getRespondentAnswersBySurveyUuid(surveyUuid, '${artifact._uuid}', 'true', function(response) {
                var result = eval('(' + response + ')');
                var surveyDefinitionData = eval('(' + result.definition + ')');
                Ext4.create('EA.model.table.survey.SurveyedArtifactAnswersTable', {
                    definitionData : surveyDefinitionData,
                    answerData : result.surveyedArtifacts[0],
                    artifactName : '${artifactName}',
                    artifactType : '',
					hideButton   : !result.showTakeSurveyButton,					
					buttonLabel  : result.takeSurveyButtonLabel,
					doTakeOfferSurvey : function () {
						
					}
                }).show();
            });
        } else {		    
            getRespondentAnswer('${artifact._uuid}', optionalSurveyDefUuid, 'true', function(response) {
                var result = eval('(' + response + ')');				
                var surveyDefinitionData = eval('(' + result.definition + ')');
                Ext4.create('EA.model.table.survey.SurveyedArtifactAnswersTable', {
                    definitionData : surveyDefinitionData,
                    answerData : result.surveyedArtifacts[0],
                    artifactName : '${artifactName}',
                    artifactType : '',					
					hideButton   : !result.showTakeSurveyButton,
					buttonLabel  : result.takeSurveyButtonLabel,					
					doTakeOfferSurvey : function (win) {
						if(result.lifecycleWarning != ''){						    
							layoutManager.showUiMessage(result.lifecycleWarning, "Warning");	
							win.close();
						 }else{
							 var url = "/em/web/service-catalog/survey/doSurvey?surveyUuid=" + result.surveyUuidString + "&artifactUuid=" + artifactUuid + "&surveyDefUuid=" + optionalSurveyDefUuid + "&forceStart=true&startOverSurvey=true";												
							 window.open(url, '_blank'); 
						 }						
					}
                }).show();
            });
        }
    }

	//]]>
</script>
