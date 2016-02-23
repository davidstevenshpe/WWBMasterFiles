<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.ea.ui.surveymessages" var="messages"/>
<style>
#root_content>div{padding: 10px 25px 0 25px}.survey-filter>div{border:none}.survey-filter select{height:31px;border-color:#bbb}.survey-header{padding-top:40px;font-size: 28px}
.survey-header .EA-top-header{ font-family:'Open Sans','Helvetica Neue',Helvetica,Arial,sans-serif;font-weight: normal;font-size:28px}.survey-header .EA-sub-type.clickable{padding-top:20px;cursor:default}
</style>
<div id="survey-artifact-selector">
<c:if test="${not empty warningMessage}">
<div class="UI SystemMessage Warning">
<fmt:message var="warning" key="${warningMessage}" bundle="${messages}"/>
	<div class="MessageContainer">
		<c:out value="${warning}"/>
	</div>
</div>
</c:if>
<fmt:message var="title" key="survey.wizard.title" bundle="${messages}">
  <fmt:param value="'${definitionName}'"/>
</fmt:message>
<fmt:message var="noArtifactInDBMsg" key="preCheck.noArtifactInDB.msg" bundle="${messages}"/>
<fmt:message var="noArtifactInDBWarn_P1" key="preCheck.noArtifactInDB.warn_P1" bundle="${messages}">
  <fmt:param value="${applicableNames}"/>
</fmt:message>
<fmt:message var="noArtifactInDB_guide_1_P1" key="preCheck.noArtifactInDB.guide_1_P1" bundle="${messages}">
  <fmt:param value="${applicableNames}"/>
</fmt:message>
<fmt:message var="guide_1" key="survey.wizard.artifact.select" bundle="${messages}"/>
<fmt:message var="show_1" key="survey.import_sources.link.show_1" bundle="${messages}"/>
<fmt:message var="show_2" key="survey.import_sources.link.show_2" bundle="${messages}"/>
<fmt:message var="hide" key="survey.import_sources.link.hide" bundle="${messages}"/>
<fmt:message var="import_sources_guide" key="preCheck.import_sources.guide_P1" bundle="${messages}">
  <fmt:param value="${applicableNames}"/>
</fmt:message>
<fmt:message var="ppm_title" key="preCheck.ppm.title" bundle="${messages}"/>
<fmt:message var="ppm_msg" key="preCheck.ppm.msg" bundle="${messages}"/>
<fmt:message var="excel_title" key="preCheck.excel.title" bundle="${messages}"/>
<fmt:message var="excel_msg" key="preCheck.excel.msg" bundle="${messages}"/>
<fmt:message var="ucmdb_title" key="preCheck.ucmdb.title" bundle="${messages}"/>
<fmt:message var="ucmdb_msg" key="preCheck.ucmdb.msg" bundle="${messages}"/>
<fmt:message var="csa_title" key="preCheck.csa.title" bundle="${messages}"/>
<fmt:message var="csa_msg" key="preCheck.csa.msg" bundle="${messages}"/>
<fmt:message var="btStartLabel" key="preCheck.startBt" bundle="${messages}"/>
<fmt:message var="notAdminMsg" key="preCheck.notAdmin" bundle="${messages}"/>
<fmt:message var="multipleMsg" key="preCheck.multipleApplicableType" bundle="${messages}"/>
<div>
	<div class="panel">
		<div  id="survey-start-no-art-wz">
			<h2>${title}</h2>
			<div>
				<p class="text-muted" style="margin-bottom:0px;">
					<em>${guide_1} <span class="survey-import-artifact-toggler">${show_1} <a href="javascript:void(0)"  onclick="$('.survey-import-artifact-toggler').toggle()">${show_2}</a></span>
						<span class="survey-import-artifact-toggler" onclick="$('.survey-import-artifact-toggler').toggle()" style="display:none"><a href="javascript:void(0)">${hide}</a></span>
					</em>
				</p>
				<div class="pad-btm survey-import-artifact-toggler" style="display:none">
					<div class="import-info" class="pad-btm">${import_sources_guide}</div>
					<div class="survey-imp-box-cont">
						<div class="import-box">
							<div class="import-cont ms-excel">
								<div class="import-title">${excel_title}</div>
								<div class="pad-ver"><span><i class="fa fa-table fa-4x"></i></span></div>
								<div class="import-sep"><hr class="c-top"/><hr class="c-bot"/></div>
								<div class="import-inner">${excel_msg}</div>
								<div><a target="_blank" class="btn btn-lg btn-labeled fa fa-arrow-right btn-danger" href="${webdataPath}/../../service-catalog/common/imports/csvImport?artifactType=${applicableType}">${btStartLabel}</a></div>
							</div>
						</div>					
						
						<div class="import-box">
							<div class="import-cont ucmdb">
								<div class="import-title">${ucmdb_title}</div>
								<div class="pad-ver"><span><i class="fa fa-server fa-4x"></i></span></div>
								<div class="import-sep"><hr class="c-top"/><hr class="c-bot"/></div>
								<div class="import-inner">${ucmdb_msg}</div>
								<div><a class="btn btn-lg btn-labeled fa fa-arrow-right btn-mint" href="#" onclick="javascript:boxClick('ucmdb');">${btStartLabel}</a></div>
							</div>
						</div>
					
						<div class="import-box">
							<div class="import-cont ppm">
								<div class="import-title">${ppm_title}</div>
								<div class="pad-ver"><span><i class="fa fa-users fa-4x"></i></span></div>
								<div class="import-sep"><hr class="c-top"/><hr class="c-bot"/></div>
								<div class="import-inner">${ppm_msg}</div>
								<div><a class="btn btn-lg btn-labeled fa fa-arrow-right btn-dark" href="#" onclick="javascript:boxClick('ppm');">${btStartLabel}</a></div>
							</div>
						</div>

						<div class="import-box">
							<div class="import-cont csa">
								<div class="import-title">${csa_title}</div>
								<div class="pad-ver"><span><i class="fa fa-cloud fa-4x"></i></span></div>
								<div class="import-sep"><hr class="c-top"/><hr class="c-bot"/></div>
								<div class="import-inner">${csa_msg}</div>
								<div><a class="btn btn-lg btn-labeled fa fa-arrow-right btn-primary" href="#" onclick="javascript:boxClick('csa');">${btStartLabel}</a></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<syswf:component name="/core/layout/columns" prefix="startSurveyWizardArtifactSelection">
	<syswf:param name="artifact" value="${artifact}" />
    <syswf:param name="customizationId" value="${selectionCustomizationID}" />
    <syswf:param name="title" value="${title}"/>
    <syswf:param name="description" value="${description}"/>
    <syswf:param name="kind" value="browse"/>
    <syswf:param name="selectionBag" value="${selectionBag}"/>
    <syswf:param name="dqlCondition" value="${dqlCondition}"/>
</syswf:component>
<div class="col-lg-7 pad-no pad-ver">
<button id="prev-wz-start-button" type="button" class="prev btn btn-primary">Previous</button>
  <button id="next-wz-start-button" type="button" class="next btn btn-primary">Next</button>
</div>
<syswf:control mode="script" caption="${prefix}_prevStep" action="prevStep" targetTask="/survey/startSurvey">
	<syswf:param name="surveyDefUuid" value="${surveyDefUuid}"/>
</syswf:control>
<syswf:control mode="script" caption="${prefix}_nextStep" action="nextStep" targetTask="/survey/startSurveyFinish">
	<syswf:param name="surveyDefUuid" value="${surveyDefUuid}"/>
</syswf:control>
<script type="text/javascript">
//<![CDATA[

$(document).ready(function () {
    $('#prev-wz-start-button').click(function(){
        ${prefix}_prevStep();
    });
    $('#next-wz-start-button').click(function(){
        ${prefix}_nextStep();
    });
    layoutManager.loadStyle('<c:out value='${webResourcePath}'/>/skinem/bootstrap/css/survey.css');
});
function boxClick(type){
	<c:choose>
		<c:when test="${notAdmin}">
			Ext4.MessageBox.alert('Warning', '${notAdminMsg}')
		</c:when>
		<c:otherwise>
		var targetUrl = '${webResourcePath}/../../../../service-catalog/artifact/';
		if (type == "ppm"){
			targetUrl = targetUrl + '${ppmUrl}';
		} else if (type == "csa") {	
			targetUrl = targetUrl + '${csaUrl}';
		}else{//ucmdb
			targetUrl = targetUrl + '${ucmdbUrl}';
		}
		// prefer admin tab
		targetUrl += (targetUrl.indexOf('?') > -1)? '&view=admin' : '?view=admin';
		window.open(targetUrl); // open in new window/tab
		</c:otherwise>
	</c:choose>
	
}
//]]>
</script>
</div>