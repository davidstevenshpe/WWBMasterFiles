<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.ea.ui.surveymessages" var="surveymessages"/>
<fmt:message var="surveyDefManagementDescp" bundle="${surveymessages}" key="survey.surveyManagement.listSurveyInstance.desc"/>
<fmt:message var="showAllSurveyCaption" bundle="${surveymessages}" key="survey.action.showAllSurvey.caption"/>
<fmt:message var="showOnlyStartSurveyCaption" bundle="${surveymessages}" key="survey.action.showOnlyStartSurvey.caption"/>
<fmt:message var="overdate" bundle="${surveymessages}" key="survey.progress.overdue"/>
<fmt:message var="noRespondents" bundle="${surveymessages}" key="survey.progress.noRespondents"/>

<div class="proposalDeliverableDescp">${surveyDefManagementDescp}</div>
<c:choose>
	<c:when test="${not this.showAllSurveys}">
		Right now you see surveys started by the 'Start Survey Wizard',  
		<syswf:control caption="${showAllSurveyCaption}" hint="${showAllSurveyCaption}" action="change" mode="anchor"></syswf:control>
	</c:when>
	<c:otherwise>
		Right now you see all survey instances, 
		<syswf:control caption="${showOnlyStartSurveyCaption}" hint="${showOnlyStartSurveyCaption}" action="change" mode="anchor"></syswf:control>
	</c:otherwise>
</c:choose>
<div>&nbsp;</div>
<div id="${prefix}-surveyDefManagementComponent">
</div>

<syswf:component name="/data/js" prefix="server_code">
  <syswf:param name="sourceId" value="progressSurveyMagementComponent"/>
  <syswf:param name="code">
    function getSurveyInstanceProgress(surveyUuid, surveyInstanceUuids) {
        return Packages.com.hp.systinet.ea.ui.survey.SurveyComponent.getInstance().getSurveyInstanceProgress(surveyUuid, surveyInstanceUuids);
    }
  </syswf:param>
</syswf:component>

<syswf:control mode="script" caption="markSurveyCompletedFunc" action="markSurveyCompleted"/>
<syswf:control mode="script" caption="cancelSurveyFunc" action="cancelSurvey"/>
<syswf:input id="${prefix}_completedSurveyUuids" name="completedSurveyUuids" mode="hidden" value="" />
<syswf:input id="${prefix}_canceledSurveyUuids" name="canceledSurveyUuids" mode="hidden" value="" />

<script type="text/javascript">
//<![CDATA[

Ext4.onReady(function() {
    var artifactTable = Ext4.create('EA.model.table.survey.SurveyDefinitionManagementTable', {
        renderTo: '${prefix}-surveyDefManagementComponent',
        width: '100%',
        extraParamsDataSource: {
        	surveyDefUuid: '${artifact._uuid}',
        	showAll : ${this.showAllSurveys},
        },
        prefixComponent: '${prefix}',
        pageResults: true,
        pageSize: 10,
        remoteSort: false,
        selectionTable: true,
        surveyUuid: '${artifact._uuid}',
        sorters:[{"property":"surveyName","direction":"ASC"}],
        
        columns:[{
                  id:'name',
                  flex:1,
                  header:'Name',
                  dataIndex:'surveyName',
                  renderer:function (v,m,record) {
                	  var hasComletionDate = record.data['expectedCompletionDate'];
                	  var style = '';
                	  if (!hasComletionDate) {
                		  style = 'color: red;';
                	  }
                 	  return artifactTable.getArtifactLinkRender(record.data.uuid, record.data.surveyName, record.data.type, style);
                  },
                  width:150,
                  sortable:true,
                  doSort: function(state) {
                 	 artifactTable.sortColumn(this, state, '');
                  }
              }, {
                  header:'Version',
                  dataIndex:'version',
                  renderer:function (v) {
                      if (v == null || v == '') return 'N/A'; else return v;
                  },
                  width:50,
                  sortable:true,
                  hidden: true
              }, {
                  header:'Owner',
                  dataIndex:'owner',
                  width:50,
                  sortable:true,
                  hidden: true
              }, {
                  header:'Date Started',
                  dataIndex:'dateStarted',
                  xtype:'datecolumn', 
                  format:'m/d/Y',
                  width:150,
                  sortable:true
              }, {
                  header:'Expected Completion Date',
                  dataIndex:'expectedCompletionDate',
                  xtype:'datecolumn', 
                  format:'m/d/Y',
                  width:200,
                  sortable:true
              }, {
                  header:'Progress',
                  dataIndex:'progress',
                  width:250,
                  flex:1,
                  sortable:true,
                  renderer: function(v, m, record) {
                      var progressInfor = record.data.progressInfor;
                      
                      var status = '';
                      var value = progressInfor.finishedRespondents + '/' + progressInfor.totalRespondents;
                      var title = "";
                      
                      var color = '#FFF';
                      if ((progressInfor.finishedRespondents / progressInfor.totalRespondents) *100 <= 10) {
                    	  color = '#000';
                      }
                      var width = '';
                      if (progressInfor.finishedRespondents == 0) {
                    	  color = '#000';
                    	  width = 'auto';
                      } else {
                    	  width = ((progressInfor.finishedRespondents / progressInfor.totalRespondents) *100) + "%";
                      }
                      
                      if (progressInfor.completed) {
                          status = 'completed';
                          width = 'auto';
                      } else if (progressInfor.overdate) {
                    	  if (progressInfor.finishedRespondents == 0) {
                              color = '#FF0000';
                          } else {
                              status = 'overdate';
                          }
                          title = '${overdate}';
                      } else {
                    	  if (progressInfor.finishedRespondents > 0) {
                    		  status = 'notCompleted';
                    	  }
                      }
                      
                      if(progressInfor.totalRespondents == 0){
                    	  value = '${noRespondents}';
                      }
                      
                      return '<div class="survey-progress-bar" style="width: 98%" title="' + title + '">' +
                             '    <div class="survey-progress-bar-info ' + status + '" style="color: ' + color + '; width:' + width +'"> ' + value + ' </div>'+
                             '</div>';
                  }
              }, {
                  header:'Status',
                  dataIndex:'status',
                  width:150,
                  sortable:true,
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