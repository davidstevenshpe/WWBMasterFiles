<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.relations.relationshipmessages" var="relationshipmessages"/>
<fmt:message var="titleWarning" key="warning.window.title" bundle="${relationshipmessages}" />

<fmt:setBundle basename="com.hp.systinet.ea.ui.surveymessages" var="messages"/>
<fmt:message var="tableLabel" key="survey.surveyed.artifacts.table.label" bundle="${messages}"/>
<fmt:message var="tableDesc" key="survey.surveyed.artifacts.table.desc" bundle="${messages}"/>
<fmt:message var="tableRemoveBtn" key="survey.surveyed.artifacts.table.remove.form" bundle="${messages}"/>
<fmt:message var="userResponded" key="survey.responded" bundle="${messages}"/>
<fmt:message var="userNotResponded" key="survey.not.responded" bundle="${messages}"/>
<fmt:message var="noPermissionOnBehalf" key="survey.do.onbehalf.noWritePermission" bundle="${messages}"/>
<fmt:message var="addRespondentLabel" key="survey.respondent.add" bundle="${messages}"/>
<fmt:message var="addRespondentNoPermissionWarning" key="survey.respondent.no.permission.warning" bundle="${messages}"/>
<fmt:message var="removeRespondentAtLeastOneWarning" key="survey.respondent.one.warning" bundle="${messages}"/>


<div class="Title">
	<h3>
		<span>
			<c:out value="${tableLabel}"/>
		</span>
	</h3>
</div>

<syswf:component name="/core/impl/description/customDescription" prefix="tableDescription">
	<syswf:param name="description" value="${tableDesc}"/>
</syswf:component>

<br><br>


<div id="${prefix}surveyedArtifactsTable"></div>

<syswf:component name="/data/js" prefix="server_code">
  <syswf:param name="sourceId" value="progressSurveyedArtifactMagementComponent"/>
  <syswf:param name="code">
    function removeFromSurvey(surveyUuid, surveyedArtifactUuids) {
        return Packages.com.hp.systinet.ea.ui.survey.SurveyedArtifactsComponent.getInstance().removeFromSurvey(surveyUuid, surveyedArtifactUuids);
    }
    function getRespondentsAndStatus(surveyUuid, surveyedArtifactUuids) {
        return Packages.com.hp.systinet.ea.ui.survey.SurveyedArtifactsComponent.getInstance().getRespondentsAndStatus(surveyUuid, surveyedArtifactUuids);
    }
    function getRespondentAnswers(surveyUuid, surveyedArtifactUuids, includeDefinition) {
    	return Packages.com.hp.systinet.ea.ui.survey.SurveyedArtifactsComponent.getInstance().getRespondentAnswers(surveyUuid, surveyedArtifactUuids, includeDefinition);
    }
    function removeRespondent(surveyInstanceUuid, surveyedArtifactUuid, respondentUuid) {
   		return Packages.com.hp.systinet.ea.ui.survey.SurveyedArtifactsComponent.getInstance().removeRespondent(surveyInstanceUuid, surveyedArtifactUuid, respondentUuid);
    }
    function checkArtifactInTransition(artifactUuid) {
   		return Packages.com.hp.systinet.ea.ui.survey.SurveyedArtifactsComponent.getInstance().checkArtifactInTransition(artifactUuid);
    }
  </syswf:param>
</syswf:component>

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

/* Global variable/function for SurveyedArtifactsManagementTable.js*/
var localMsg2 = {
		noPermissionOnBehalf: '${noPermissionOnBehalf}', 
		titleWarning: '${titleWarning}',
		noPermission: '<syswf:out value="${addRespondentNoPermissionWarning}" context="HtmlJSText"/>',
   		atLeastOne: '<syswf:out value="${removeRespondentAtLeastOneWarning}" context="HtmlJSText"/>'
	};
           
var surveyDefinitionData;

Ext4.onReady(function() {
	
    var artifactTable = Ext4.create('EA.model.table.survey.SurveyedArtifactsManagementTable', {
        renderTo: '${prefix}surveyedArtifactsTable',
        width: '100%',
        minHeight: 230,
        localMsg: localMsg2,
        extraParamsDataSource: {
        	surveyUuid: '${artifact._uuid}'
        },
        pageResults: true,
        pageSize: ${this.pageSize},
        remoteSort: false,
        selectionTable: true,
        reviewAnswers:true,
		disableRemoveButton: ${hasWritePermission eq 'false'},
        surveyUuid: '${artifact._uuid}',
        sorters:[{"property":"surveyName","direction":"ASC"}],
        loggedUserUuid: '${loggedUserUuid}',
        hasRightDoingSurveyOnBehalf: '${hasWritePermission}',
        hasWritePermission: '${hasWritePermission}',
        
        columns:[{
                  id:'name',
                  flex:1,
                  header:'Name',
                  dataIndex:'surveyName',
                  renderer:function (v, m, record) {
                      return artifactTable.renderArtifactMenuLink(record.data.uuid,record.data.surveyName.replace(/(['"&:;])/g, "\\$1"), record.data.type, null, null);
                  },
                  width:150,
                  sortable:true
              }, {
                  header:'Version',
                  dataIndex:'surveyVersion',
                  renderer:function (v) {
                      if (v == null || v == '') return 'N/A'; else return v;
                  },
                  width:100,
                  sortable:true
              }, {
                  header:'Respondents',
                  dataIndex:'responses',
                  width:400,
                  flex:1,
                  sortable: false,
                  tdCls: 'relative-cell-container',
                  renderer: function(v, m, record) {
                	  
                	  if (v == null || v == '') return '';
                	  var el = '<p class="multi-lines">';
                	  for(var i = 0; i < v.length; i++) {
                		  var resp = v[i];
                		  var className;
                		  var title;
                		  if(resp.status == 'completed'){
                			  className='submitted';
                			  title='${userResponded}';
                		  }else{
                			  className='not-submitted';
                			  title='${userNotResponded}';
                		  }
                		  
                		  var link = artifactTable.renderRespondentMenuLink(resp.contactUUID, resp.contactName, record.data.uuid, v.length);
                		  el += '<span class="survey-user '+ className +'" title="' + title + '"></span>' + link;
                		  if(i < v.length -1) el += ', ';
                	  }
                	  el += '</p>';
                	  if(v.length > 5) {
                		  el += '<span class="more" onclick="emCommon.toggleTextareaCell(this,{containerId:\'${prefix}surveyedArtifactsTable\'})"><i class="fa fa-ellipsis-h"></i></span>';
                	  }
                      return el;
                  }
              }, {
                  header:'Status',
                  dataIndex:'status',
                  width:150,
                  sortable:false,
                  renderer: function(v,m,record) {
                	  if (v == null) return '';
                	  var text = '', color = 'HealthYellow';
                	  if(v == 'completed'){
                		  text = 'Completed';
                          color = 'HealthGreen';
                	  }else if(v == 'notcompleted'){
                		  text = 'Not Completed';                          
                	  }else if(v == 'notstarted'){
                		  text = 'Not Started';                          
                	  }
                      return '<div ><span class="UI Icon ' + color + ' ProjectStatus"></span>&nbsp;'+ text + '</div>';
                  }
              }]
    });
});

//]]>
</script>