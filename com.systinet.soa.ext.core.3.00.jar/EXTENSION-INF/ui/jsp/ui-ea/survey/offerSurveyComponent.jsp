<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="uimessages"/>

<c:if test="${empty label}">
  <fmt:message var="label" key="survey.offer.btn.label" bundle="${uimessages}"/>
</c:if>
<c:if test="${empty answersLabel}">
  <fmt:message var="answersLabel" key="survey.offer.answers.label" bundle="${uimessages}"/>
</c:if>


<div id="${prefix}_controlDiv" style="margin: 15px 0 10px 5px; display: inline-block;">
    <syswf:control mode="script" caption="${prefix}_doTakeOfferSurveyFn" action="doTakeOfferSurvey"/>
    
    <button id="${prefix}_takeSurveyButton" class="btn btn-gray btn-labeled em fa fa-pencil-square" help-text="less"><span><c:out value="${label}"/></span></button>
</div>
<div style="display:none" >
<syswf:component name="/data/js" prefix="survey_offer">
    <syswf:param name="sourceId" value="offerSurveyComponent"/>
  	<syswf:param name="code">
        function checkTakeSurvey(artifactUuid, surveyDefUuid) {
          return Packages.com.hp.systinet.ea.ui.survey.OfferSurveyComponent.getInstance().checkTakeSurvey(artifactUuid, surveyDefUuid);
        }        
  	</syswf:param>
</syswf:component>
</div>
<script type="text/javascript">
//<![CDATA[
    jQuery(document).ready(function () {
        jQuery('#${prefix}_takeSurveyButton').bind('click', function(e) {
        	var surveyDefUuid = '${surveyDefUuid}';			
			var artifactUuid = '${artifact._uuid}';	

			if (surveyDefUuid != null && artifactUuid != '') {
				checkTakeSurvey(artifactUuid, surveyDefUuid , function(response) {
					if(response == 'OK'){						
						if (document.forms['ContentForm']) document.forms['ContentForm'].target="_blank";// in case "formtarget" not working, such as IE
						${prefix}_doTakeOfferSurveyFn();
					}else{						
						layoutManager.showUiMessage(response, "Warning");
					}
				});								
			} 
			
			e.preventDefault();
			e.stopPropagation(); // return false;*/
        });
    });
//]]>
</script>

