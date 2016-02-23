<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.ea.ui.surveymessages" var="messages"/>
<c:set var="defLink">
	<syswf:control mode="anchor" targetTask="/artifact/${surveyDefinitionUuid}" caption="here">
		<syswf:attribute name="target" value="_blank"/>
	</syswf:control>
</c:set>
<fmt:message var="errorMsg" key="survey.wizard.definition.invalid" bundle="${messages}">
	<fmt:param value="${defLink}"/>
</fmt:message>


<syswf:control mode="script" caption="${prefix}_nextStep" action="nextStep" targetTask="/survey/startSurveySelection">
	<syswf:param name="surveyDefUuid" value="${surveyDefUuid}"/>
</syswf:control>
<syswf:input id="surveyInstanceData" name="surveyInstanceData" mode="hidden" value="" />

<fmt:message var="surveyTitle" key="survey.wizard.title" bundle="${messages}">
  <fmt:param value="${definitionName}"/>
</fmt:message>
<fmt:message var="noArtifactInDBMsg" key="preCheck.noArtifactInDB.msg" bundle="${messages}"/>
<fmt:message var="noArtifactInDBWarn_P1" key="preCheck.noArtifactInDB.warn_P1" bundle="${messages}">
  <fmt:param value="${applicableNames}"/>
</fmt:message>
<fmt:message var="noArtifactInDB_guide_1_P1" key="preCheck.noArtifactInDB.guide_1_P1" bundle="${messages}">
  <fmt:param value="${applicableNames}"/>
</fmt:message>
<fmt:message var="noArtifactInDB_guide_2" key="preCheck.noArtifactInDB.guide_2" bundle="${messages}"/>
<fmt:message var="noArtifactInDB_guide_3" key="preCheck.noArtifactInDB.guide_3" bundle="${messages}"/>
<fmt:message var="ppm_title" key="preCheck.ppm.title" bundle="${messages}"/>
<fmt:message var="ppm_msg" key="preCheck.ppm.msg" bundle="${messages}"/>
<fmt:message var="excel_title" key="preCheck.excel.title" bundle="${messages}"/>
<fmt:message var="excel_msg" key="preCheck.excel.msg" bundle="${messages}"/>
<fmt:message var="ucmdb_title" key="preCheck.ucmdb.title" bundle="${messages}"/>
<fmt:message var="ucmdb_msg" key="preCheck.ucmdb.msg" bundle="${messages}"/>
<fmt:message var="csa_title" key="preCheck.csa.title" bundle="${messages}"/>
<fmt:message var="csa_msg" key="preCheck.csa.msg" bundle="${messages}"/>
<fmt:message var="btStartLabel" key="preCheck.startBt" bundle="${messages}"/>
<fmt:message var="reload" key="preCheck.reload_P1" bundle="${messages}">
  <fmt:param value="${applicableNames}"/>
</fmt:message>

<fmt:message var="notAdminMsg" key="preCheck.notAdmin" bundle="${messages}"/>
<fmt:message var="multipleMsg" key="preCheck.multipleApplicableType" bundle="${messages}"/>

<div class="boxed">
	<div id="content-container">
		<div id="page-content" ng-controller="surveyController">
		<c:choose>
		<c:when test="${validSurvey eq false}">
		<div class="alert alert-warning">
		${errorMsg}
			<c:if test="${not empty message}">
			<br>Error: <em>${message}</em>
			</c:if>
		</div>
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${noArtifactInDB}">
				<div>
					<div class="panel">
					<div id="survey-container" class="eq-height clearfix">
						<div  id="survey-start-no-art-wz" class="col-md-12 eq-box-md eq-no-panel">
							<h2>${surveyTitle}</h2>
							<div>
								<p class="text-muted"><em>${noArtifactInDBMsg}</em></p>
								<div class="no-artifact-warn">${noArtifactInDBWarn_P1}</div>
								<div class="import-info">${noArtifactInDB_guide_1_P1} ${noArtifactInDB_guide_2} ${noArtifactInDB_guide_3}</div>
								<div class="survey-imp-box-cont">
									<div class="import-box">
										<div class="import-cont ms-excel">
											<div class="import-title">${excel_title}</div>
											<div class="pad-ver"><span><i class="fa fa-table fa-5x"></i></span></div>
											<div class="import-sep"><hr class="c-top"/><hr class="c-bot"/></div>
											<div class="import-inner">${excel_msg}</div>
											<div><a target="_blank" class="btn btn-lg btn-labeled fa fa-arrow-right btn-danger" href="${webdataPath}/../../service-catalog/common/imports/csvImport?artifactType=${applicableType}">${btStartLabel}</a></div>
										</div>
									</div>
									<div class="import-box">
										<div class="import-cont ucmdb">
											<div class="import-title">${ucmdb_title}</div>
											<div class="pad-ver"><span><i class="fa fa-server fa-5x"></i></span></div>
											<div class="import-sep"><hr class="c-top"/><hr class="c-bot"/></div>
											<div class="import-inner">${ucmdb_msg}</div>
											<div><a class="btn btn-lg btn-labeled fa fa-arrow-right btn-mint" href="#" onclick="javascript:boxClick('ucmdb');">${btStartLabel}</a></div>
										</div>
									</div>
									<div class="import-box">
										<div class="import-cont ppm">
											<div class="import-title">${ppm_title}</div>
											<div class="pad-ver"><span><i class="fa fa-users fa-5x"></i></span></div>
											<div class="import-sep"><hr class="c-top"/><hr class="c-bot"/></div>
											<div class="import-inner">${ppm_msg}</div>
											<div><a class="btn btn-lg btn-labeled fa fa-arrow-right btn-dark" href="#" onclick="javascript:boxClick('ppm');">${btStartLabel}</a></div>
										</div>
									</div>
									<div class="import-box">
										<div class="import-cont csa">
											<div class="import-title">${csa_title}</div>
											<div class="pad-ver"><span><i class="fa fa-cloud fa-5x"></i></span></div>
											<div class="import-sep"><hr class="c-top"/><hr class="c-bot"/></div>
											<div class="import-inner">${csa_msg}</div>
											<div><a class="btn btn-lg btn-labeled fa fa-arrow-right btn-primary" href="#" onclick="javascript:boxClick('csa');">${btStartLabel}</a></div>
										</div>
									</div>
								</div>
								<div class="reload"><a href="#" onclick="javascript:location.reload();" class="btn btn-lg btn-labeled fa fa-arrow-right btn-primary btn-reload">${reload}</a></div>
							</div>
						</div>
					</div>
					</div>
				</div>
				</c:when>
				<c:otherwise>
				<div class="panel">
					<div id="survey-container" class="eq-height clearfix">
						<div  id="survey-start-wz" class="col-md-7 eq-box-md eq-no-panel" survey-start data="{ selectedArtifactCount : 1 }" survey-instance="surveyInstance">
						</div>
						<div id="info-container" class="col-md-5 eq-box-md text-center box-vmiddle-wrap">
							<div survey-info class="box-vmiddle pad-all" preview-link="true" survey-instance="surveyInstance" theme="surveyDefinition.survey.theme"></div>
						</div>
						<div  id="survey-preview-wz" class="col-md-7 eq-box-md eq-no-panel" style="display:none;">
							<div style="overflow:hidden;height:627px">
								<div survey-tabs></div>
								<div class="progress progress-xs" survey-progress></div>
								<div class="form-horizontal">
									<div class="panel-body">
										<div survey-tab class="tab-content" ng-repeat="item in surveyDefinition.survey.steps"></div>
									</div>
									<div survey-actions></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				</c:otherwise>
				</c:choose>
			</c:otherwise>
			</c:choose>
			</div>
		</div>
		<div>
	</div>
</div>
<script src="<c:out value='${webResourcePath}'/>/skinem/angular/js/angular.min.js"></script>
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/angular/survey/controller.js"></script>
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/angular/survey/view.js"></script>
<script type="text/javascript">
//<![CDATA[

var surveyDefinition = ${surveyDefinition}, surveyedArtifact = {}, surveyInstance = ${surveyInstance}, gridInstances = [];

surveyDefinition.previewMode = true;
<c:if test="${validSurvey eq true}">
try {
	surveyDefinition.survey = eval('(${definitionContent})');
} catch(e) {
	$('#page-content').html('<div class="alert alert-warning">${errorMsg}</div>');
	console.log(e);
}

$(document).ready(function () {
    $('#next-wz-start-button').click(function(){
    	surveyInstance.definitionName = surveyDefinition.name;
    	if(surveyInstance.questionNumber == null && surveyDefinition.survey.steps != null) {
    		surveyInstance.questionNumber = 0;
    		for(var i = 0; i < surveyDefinition.survey.steps.length; i++) {
    			if(surveyDefinition.survey.steps[i].questions != null) {
    				surveyInstance.questionNumber += surveyDefinition.survey.steps[i].questions.length;
    			}
    		}
    	}
    	Ext.get('surveyInstanceData').dom.value = Ext.encode(surveyInstance);
    	${prefix}_nextStep();
    });
    
    $('#cancel-wz-start-button').click(function(){
    	window.location='${webResourcePath}/../../../../service-catalog/artifact/' + surveyDefinition.uuid;
    });       
        
    $('#next-step-button').click(function(){
    	showRelationshipTable();
    });
    
	$('#prev-step-button').click(function(){
		showRelationshipTable();
    });
    
    renderRelationshipQuestionAsTable(surveyDefinition.survey);
});

function showRelationshipTable(){
	var arr = (gridInstances[surveyDefinition.currentStep]).filter(function(n){ return n != undefined });
	for(var i=0; i<arr.length; i++){
		var grid = arr[i];
		grid.doLayout();
		if(surveyDefinition.currentStep==0){
			//call doLayout() 2nd time to avoid bad layout grid
			grid.doLayout();
		}
	}
}

function renderRelationshipQuestionAsTable(survey){
	for(var i=0; i<survey.steps.length; i++){
		var step = survey.steps[i];
		gridInstances[i] = [];
		if(step.questions!=null){
			 for(var j=0; j<step.questions.length; j++){
				var question = step.questions[j];
				if(question.type=='relationship'){
					var mapping = question.mapping;
					if(mapping!=null && mapping.tableViewOnly==true){
						gridInstances[i][j] = renderRelationshipTable(question);
					}
				} 
			} 
		}
	}
}

function renderRelationshipTable(question){
	
	var tbar = Ext4.create('Ext4.toolbar.Toolbar');
	tbar.add( {
		height: 35,
		width: 35,
		cls: 'x-btn-icon rel-new',
		tooltipType: 'data-qtip',
		tooltip:  'Link to new artifact',
		text: ' '
	});
	tbar.add({
		height: 35,
		width: 35,
		cls: 'x-btn-icon rel-link-exist',
		tooltipType: 'data-qtip',
		tooltip:  'Link to existing artifacts',
		text: ' '
	});
	tbar.add({
		height: 35,
		width: 35,
		cls: 'x-btn-icon rel-remove',
		tooltipType: 'data-qtip',
		tooltip:  'Remove selected artifacts from relationship',
		text: ' '
	});    				
	
	//fake data for preview page
	var store = Ext4.create('Ext4.data.ArrayStore', {
	    storeId: 'myStore',	    
	    fields: ['name', 'sdmName', 'version'],
	    data: [
	              ['Demo Artifact 1','Application Component','1.2'],
	              ['Demo Artifact 2','Application Component','2.5'],
	              ['Demo Artifact 3','Application Component','3.7']
	          ]
	});
	
	//fake grid for preview page
	var artifactGrid = Ext4.create("Ext4.grid.Panel", {
    	id: question.mapping.relationshipName + 'ArtifactGridPanelId',
    	store: store,
    	renderTo: Ext4.get(question.mapping.relationshipName + 'ArtifactGridPanelContainer'),
		columnLines: true,
		viewConfig:{
			enableTextSelection: true
		},
		selModel: Ext4.create('Ext4.selection.CheckboxModel',{ checkOnly: true, multipageSelection: {}}),			
        columns: [{	    		                
                header:'Name',
                dataIndex:'name',
                flex:1,
                width:200,
                sortable:true
            }, {
                header:'Type',
                dataIndex:'sdmName',
                width:150,
                sortable:true
            }, {
                header:'Stage',
                dataIndex:'currentStage',
                width:100,
                hidden:true,
                sortable:true
            }, {
                header:'Version',
                dataIndex:'version',
                width:100,
                sortable:true
            }, {
                header:'Owner',
                dataIndex:'owner',
                hidden:true,
                width:150,
                sortable:true
            }, {
                header:'Domain',
                dataIndex:'domain',
                hidden:true,
                width:150,
                sortable:true
            }],
            tbar: tbar,
            bbar: {
                xtype: 'pagingtoolbar',
                displayInfo: false,
                plugins: Ext4.create("EA.model.table.SlidingPager")
            }
    });
	return artifactGrid;
}

function boxClick(type){// dup startSurveyArtifactSelection.jsp
	<c:choose>
		<c:when test="${notAdmin}">
			Ext4.MessageBox.alert('Warning', '${notAdminMsg}')
		</c:when>
		<c:otherwise>
        var targetUrl = '${webResourcePath}/../../../../service-catalog/artifact/';
        if (type == "ppm") {
            targetUrl = targetUrl + '${ppmUrl}';
        } else if (type == "csa") { 
            targetUrl = targetUrl + '${csaUrl}';
        } else {//ucmdb
            targetUrl = targetUrl + '${ucmdbUrl}';
        }
        // prefer admin tab
        targetUrl += (targetUrl.indexOf('?') > -1)? '&view=admin' : '?view=admin';
        window.open(targetUrl); // open in new window/tab
		</c:otherwise>
	</c:choose>
	
}
</c:if>

//]]>
</script>
<syswf:component name="/newui/nifty" prefix="nifty_angular">
	<syswf:param name="ngApp" value="surveyApp"/>
	<syswf:param name="styles" value="['/skinem/bootstrap/css/survey.css','/skinem/bootstrap/bootstrap-datepicker/bootstrap-datepicker.css']"/>
	<syswf:param name="scripts" value="['/skinem/bootstrap/bootstrap-datepicker/bootstrap-datepicker.js']"/>
	<syswf:param name="callback" value="function(){ if(surveyManager) {surveyManager.initSelectors();} }"/>
</syswf:component>