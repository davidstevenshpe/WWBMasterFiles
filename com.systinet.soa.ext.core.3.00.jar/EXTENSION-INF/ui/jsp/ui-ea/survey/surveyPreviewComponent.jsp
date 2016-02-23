<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<c:if test="${validSurvey eq false}">
<fmt:setBundle basename="com.hp.systinet.ea.ui.surveymessages" var="messages"/>
<c:set var="defLink">
	<syswf:control mode="anchor" targetTask="/artifact/${surveyDefinitionUuid}" caption="here">
		<syswf:attribute name="target" value="_blank"/>
	</syswf:control>
</c:set>
<fmt:message var="errorMsg" key="survey.wizard.definition.invalid" bundle="${messages}">
	<fmt:param value="${defLink}"/>
</fmt:message>
<div class="alert alert-warning fade in">
	${errorMsg}
</div>
</c:if>
<c:if test="${validSurvey eq true}">
<div class="boxed">
	<div id="content-container">
		<div id="page-content" ng-controller="surveyController">
			<div class="panel">
				<div id="survey-container" class="eq-height clearfix" style="display:block">
					<div  id="survey-start-wz" class="col-md-7 eq-box-md eq-no-panel" survey-start data="{ selectedArtifactCount : 1 }" survey-instance="surveyInstance" >
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
		</div>
	</div>
</div>

<script src="<c:out value='${webResourcePath}'/>/skinem/angular/js/angular.min.js"></script>
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/angular/survey/controller.js"></script>
<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/angular/survey/view.js"></script>

<script type="text/javascript">
//<![CDATA[

var surveyDefinition = ${surveyDefinition}, surveyedArtifact = {}, surveyInstance = ${surveyInstance}, gridInstances = [];

surveyDefinition.previewMode = true;

try {
	surveyDefinition.survey = eval('(${definitionContent})');
} catch(e) {
	$('#page-content').html('<div class="alert alert-warning">${errorMsg}</div>');
	console.log(e);
}

$(document).ready(function () {   
	
	$('#survey-start-wz').remove();
	$('#info-container').remove();
	$('#survey-preview-wz').slideEx(1, null, showRelationshipTable);
        
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

//]]>
</script>
</c:if>
<syswf:component name="/newui/nifty" prefix="nifty_angular">
	<syswf:param name="ngApp" value="surveyApp"/>
	<syswf:param name="styles" value="['/skinem/bootstrap/css/survey.css','/skinem/bootstrap/bootstrap-datepicker/bootstrap-datepicker.css']"/>
	<syswf:param name="scripts" value="['/skinem/bootstrap/bootstrap-datepicker/bootstrap-datepicker.js']"/>
	<c:if test="${validSurvey eq true}">
		<syswf:param name="callback" value="function(){ if(surveyManager) {surveyManager.initSelectors();} }"/>
	</c:if>
</syswf:component>