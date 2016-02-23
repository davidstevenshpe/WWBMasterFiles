<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<jsp:useBean id="timeBean" class="com.hp.systinet.shared.TimeBean"/>
<fmt:setBundle basename="com.systinet.webfw.ui.WebFrameworkUIMessages" var="webFrameworkUI_Messages"/>
<fmt:setBundle basename="com.hp.systinet.platform.rebranding" var="rebranding_Messages"/>
<fmt:setBundle basename="com.hp.systinet.ea.ui.surveymessages" var="survey_messages"/>
<fmt:message key="rebranding.logoProductName" var="productName" bundle="${rebranding_Messages}"/>
<fmt:message var="poweredBy" key="rebranding.poweredByFooter" bundle="${rebranding_Messages}"/>
<fmt:message var="coCopyrightBefore" key="rebranding.coCopyright.before" bundle="${rebranding_Messages}"/>
<fmt:message var="coCopyrightAfter" key="rebranding.coCopyright.after" bundle="${rebranding_Messages}"/>
<fmt:message var="copyright" key="copyright" bundle="${webFrameworkUI_Messages}"/>
<fmt:message var="cancelledMessage" key="survey.cancel.message" bundle="${survey_messages}"/>
<fmt:message var="purgedMessage" key="survey.purge.message" bundle="${survey_messages}"/>
<fmt:message var="lifecycleWarningMessage" key="survey.lifecycleWarning.message" bundle="${survey_messages}"/>
<!DOCTYPE html>
<html lang="en" ng-app="surveyApp">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Survey - <c:out value="${productName}"/></title>
	
	<link rel="icon" href="<c:out value='${webResourcePath}'/>/skin/img/default/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="<c:out value='${webResourcePath}'/>/skin/img/default/favicon.ico" type="image/x-icon" />
	<link href="<c:out value='${webResourcePath}'/>/skin/css/index.css" rel="stylesheet">
	<link href="<c:out value='${webResourcePath}'/>/skin410/css/action/button.css" rel="stylesheet">
    <link href="<c:out value='${webResourcePath}'/>/skinem/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:out value='${webResourcePath}'/>/skin/ext42/resources/css/ext-sandbox.css" rel="stylesheet" type="text/css">
    <link href="<c:out value='${webResourcePath}'/>/skinem/bootstrap/bootstrap-datepicker/bootstrap-datepicker.css" rel="stylesheet">
    <link href="<c:out value='${webResourcePath}'/>/skinem/bootstrap/css/nifty.min.css" rel="stylesheet">
    <link href="<c:out value='${webResourcePath}'/>/skinem/bootstrap/css/font-awesome.min.css" rel="stylesheet">
    <link href="<c:out value='${webResourcePath}'/>/skin410/css/icon-fonts.css" rel="stylesheet">
    <link href="<c:out value='${webResourcePath}'/>/skin410/css/dropdown/dropdown.css" rel="stylesheet">    
    <link href="<c:out value='${webResourcePath}'/>/skin410/css/main.css" rel="stylesheet">
    <link href="<c:out value='${webResourcePath}'/>/skinem/bootstrap/css/em.css" rel="stylesheet">
    <link href="<c:out value='${webResourcePath}'/>/skinem/bootstrap/css/survey.css" rel="stylesheet">
	
	<%-- ExtJS 3.4 declaration--%>
	<syswf:localizedFileName fileName="${webResourcePath}/skin/ext3/adapter/ext/ext-base.js" var="jsExtBase"/>
	<syswf:localizedFileName fileName="${webResourcePath}/skin/ext3/ext-all.js" var="jsExtAll"/>
	<syswf:localizedFileName fileName="${webResourcePath}/skin/ext3/ext-patch-34.js" var="jsExtPatch34"/>
	<script type="text/javascript" src="<c:out value="${jsExtBase}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsExtAll}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsExtPatch34}"/>"></script>
	<%-- ExtJS 4.2 declaration --%>
	<script type="text/javascript" src="${webResourcePath}/skin/ext42/builds/ext-all-sandbox.js"></script>
    <script type="text/javascript" src="${webResourcePath}/skin/ext42/builds/ext-patch-42.js"></script>    	
	<script src="<c:out value='${webResourcePath}'/>/skinem/bootstrap/js/jquery-2.1.1.min.js"></script>
    <script src="<c:out value='${webResourcePath}'/>/skinem/js/layoutManager.js"></script>
<jsp:include page="../../sc-ui-ng/core/globalJsVariables.jsp"/>
	<script type="text/javascript">
		//<![CDATA[
		var surveyDefinition = {}, surveyedArtifact = {}, surveyInstance = {}, contactUuid = '${contactUuid}', doingContactUuid = '${doingContactUuid}';
		 <c:if test="${validSurvey eq true}">
		 	<c:if test="${empty purged and empty cancelled and empty hasNoReadPermission}">
			try {
				surveyDefinition = ${surveyDefinition}, surveyInstance = ${surveyInstance}, surveyedArtifact = ${surveyedArtifact};				
				surveyedArtifact.nameInHtml = surveyedArtifact.name;
				surveyedArtifact.name = emCommon.unescapeHtml(surveyedArtifact.nameInHtml);
				surveyInstance.nameInHtml = surveyInstance.name;
				surveyInstance.name = emCommon.unescapeHtml(surveyInstance.nameInHtml);
			} catch(e) { console.log(e) }
			</c:if>
		surveyDefinition.survey = eval('(${definitionContent})');
		var definitionUuid = '${surveyDefinitionUuid}';
		</c:if>
		
		function setSurveyArtifactUuidsStorage(relationSurveyId, artifactUuids) {
			if (!relationSurveyId || !artifactUuids) {
				return;
			}
			var result = "";
			if (artifactUuids instanceof Array) {
				result = _join(artifactUuids);
			} else {
				result = artifactUuids;
			}
            window.localStorage.setItem(relationSurveyId, result);
		}
		function appendSurveyArtifactUuidsStorage(relationSurveyId, artifactUuids) {
            var currValue = window.localStorage.getItem(relationSurveyId);
            if (!currValue || currValue.length == 0) {
            	currValue = '';
            }
            var listUuids = _toArray(currValue);
            artifactUuids = _toArray(artifactUuids);
            for (var idx = 0; idx < artifactUuids.length; idx++) {
            	var entry = artifactUuids[idx];
            	if (listUuids.indexOf(entry) == -1) {
            		listUuids.push(entry);
            	}
            }
            var result = _join(listUuids);
            window.localStorage.setItem(relationSurveyId, result);
		}
		function removeSurveyArtifactUuidsStorage(relationSurveyId, artifactUuids) {
            var currValue = window.localStorage.getItem(relationSurveyId);
            if (!currValue || currValue.length == 0) {
                currValue = '';
            }
            var listUuids = _toArray(currValue);
            artifactUuids = _toArray(artifactUuids);
            for (var idx = 0; idx < artifactUuids.length; idx++) {
                var entry = artifactUuids[idx];
                var index = listUuids.indexOf(entry);
                if (index != -1) {
                    listUuids.splice(index, 1);
                }
            }
            var result = _join(listUuids);
            window.localStorage.setItem(relationSurveyId, result);
        }
		
		function getSurveyArtifactUuidsStorage(relationSurveyId) {
			var currValue = window.localStorage.getItem(relationSurveyId);
            return _toArray(currValue);
		}
		
	    function _toArray(stringValues) {
	    	if (!stringValues || stringValues.length == 0) {
	    		return [];
	    	}
	    	if (stringValues instanceof Array) {
	    		return stringValues;
	    	}
	    	var tmp = stringValues.split(',');
	    	var result = [];
	    	for (var idx = 0; idx < tmp.length; idx++) {
	    		result[idx] = tmp[idx].trim();
	    	}
	    	return result;
	    }
		
		function _join(arrayValues) {
			var result = "";
            for (var idx = 0; idx < arrayValues.length; idx++) {
                result += arrayValues[idx];
                if (idx < arrayValues.length - 1) {
                    result += ",";
                }
            }
            return result;
		}
		//]]>
	</script>
</head>
<body>

<syswf:form id="ContentForm" method="post" enctype="multipart/form-data">

<syswf:component name="/data/js" prefix="server_code">
  <syswf:param name="sourceId" value="doSurvey"/>
  <syswf:param name="code">
    function saveAnswer(surveyUuid, artifactUuid, answer, definitionUuid, doingContactUuid) {
		return Packages.com.hp.systinet.ea.ui.survey.SurveyComponent.getInstance().saveAnswer(surveyUuid, artifactUuid, answer, definitionUuid, doingContactUuid);
    }
  </syswf:param>
</syswf:component>

<c:set var="takeSurveyContactUuid">
	<c:choose>
		<c:when test="${not empty doingContactUuid}">
			${doingContactUuid}
		</c:when>
		<c:otherwise>
			${contactUuid}
		</c:otherwise>
	</c:choose>
</c:set>

<div class="hidden" id="hiddenRelationshipEditors">
	<syswf:component name="/core/relations/selectArtifacts" prefix="${prefix}ArtifactSelection"/>
	<c:forEach var="item" items="${this.relationshipAndShortcutQuestions}">
		<c:choose>
			<c:when test="${item.type eq 'relationship' and not empty item.mapping.relationshipName}">
				<syswf:component name="/core/layout/relationshipItemComponent" prefix="${item.id}reltionshipQuestion">
					<syswf:param name="artifact" value="${this.surveyedArtifact}"/>
					<syswf:param name="relationshipName" value="${item.mapping.relationshipName}"/>
					<syswf:param name="useType" value="${item.mapping.useType}"/>
				    <syswf:param name="artifactTypes" value="${item.mapping.artifactTypesAsString}"/>
					<syswf:param name="label" value="${item.mapping.label}"/>
					<syswf:param name="tableViewOnly" value="${item.mapping.tableViewOnly}"/>
					<syswf:param name="deleteOnly" value="${item.mapping.deleteOnly}"/>
					<syswf:param name="readOnly" value="${item.mapping.readOnly}"/>
					<syswf:param name="isInvalid" value="${item.mapping.isInvalid}"/>
					<syswf:param name="isBidirectional" value="${item.mapping.isBidirectional}"/>
					<%-- these parameters only are available/used in doSurvey page --%>
					<syswf:param name="isSurveyPage" value="${true}"/>
					<syswf:param name="forceGetUuids" value="${true}"/>
					<syswf:param name="hideLabelOfTable" value="${true}"/>
					<%-- This must be the same as $scope.localId of controller.js --%>
					<%-- <syswf:param name="localStorageId" value="${contactUuid}_${surveyInstance.getAsJsonPrimitive('uuid').getAsString()}_${surveyedArtifact.getAsJsonPrimitive('uuid').getAsString()}"/> --%>
					<syswf:param name="relationSurveyId" value="${takeSurveyContactUuid}_${surveyInstance.getAsJsonPrimitive('uuid').getAsString()}_${surveyedArtifact.getAsJsonPrimitive('uuid').getAsString()}_${item.id}"/>
				</syswf:component>
			</c:when>
			<c:when test="${item.type eq 'shortcut'}">
				<syswf:component name="/core/layout/shortcuts" prefix="${item.id}shortcutQuestion">
					<syswf:param name="artifact" value="${this.surveyedArtifact}"/>
					<syswf:param name="shortcutIds" value="${item.mapping.shortcutId}"/>
					<syswf:param name="label" value="${item.mapping.label}"/>
					<syswf:param name="showLabel" value="${item.mapping.showLabel}"/>
					<syswf:param name="isSurveyPage" value="${true}"/>
					<syswf:param name="relationSurveyId" value="${takeSurveyContactUuid}_${surveyInstance.getAsJsonPrimitive('uuid').getAsString()}_${surveyedArtifact.getAsJsonPrimitive('uuid').getAsString()}_${item.id}"/>
				</syswf:component>
			</c:when>
		</c:choose>
	</c:forEach>
</div>

<div id="container" class="effect">
		<survey-header data="{productName: '${productName}', userName: '${userName}', historyTimestamp: '${historyTimestamp}'}"></survey-header>
		<div class="boxed">
    	<div id="content-container">
    		<div id="page-content" ng-controller="surveyController">
    			<c:choose>
					<c:when test="${validSurvey eq true and empty purged and empty cancelled and empty message}">
    		    	<artifact-info class="artifact-info"></artifact-info>
					<div class="panel">

						<div id="survey-container" class="eq-height clearfix">
							<div id="info-container" class="col-md-5 eq-box-md text-center box-vmiddle-wrap bg-primary">
								<div survey-info class="box-vmiddle pad-all" survey-instance="surveyInstance" theme="surveyDefinition.survey.theme"></div>
							</div>
							<div  id="survey-start-page" class="col-md-7 eq-box-md eq-no-panel">
										<div class="start-body">
											<div survey-start-page></div>
										</div>
										<div class="survey-actions">
											<div class="pull-right pad-all"><button id="start-button" type="button" class="survey next btn" ng-click="startSurvey()">Start</button></div>
										</div>

							</div>
							<div  id="survey-main-wz" class="col-md-7 eq-box-md eq-no-panel hidden">
								<div>
									<div survey-tabs></div>
									<div class="progress progress-xs" survey-progress></div>
									<form class="form-horizontal">
										<div class="panel-body">
											<div survey-tab class="tab-content" ng-repeat="item in surveyDefinition.survey.steps"></div>
										</div>
										<div survey-actions></div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
				</c:when>
				<c:when test="${lifecycleWarning}">
					<div class="alert alert-warning fade in">
						${lifecycleWarningMessage}
					</div>
				</c:when>
				<c:when test="${purged}">
					<div class="alert alert-warning fade in">
						${purgedMessage}
					</div>
				</c:when>
				<c:when test="${cancelled}">
					<div class="alert alert-warning fade in">
						${cancelledMessage}
					</div>
				</c:when>
				<c:otherwise>
				<div class="alert alert-warning fade in">
					${message}
				</div>
				</c:otherwise>
			</c:choose>
			</div>
			<div>
  		</div>
    </div>
    <survey-footer data="{time: '${timeBean.time}', poweredBy: '${poweredBy}', copyrightBefore: '${coCopyrightBefore}', copyright: '${copyright}', copyrightAfter: '${coCopyrightAfter}'}"></survey-footer>
</div>
	
	<syswf:localizedFileName fileName="${webContext}/${productBuildId}/js/ajaxExt.js" var="ajax"/>
	<syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_dropdown.js" var="jsComDropDown"/>
	<script type="text/javascript" src="<c:out value="${ajax}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsComDropDown}"/>"></script>

    <script src="<c:out value='${webResourcePath}'/>/skinem/bootstrap/js/bootstrap.min.js"></script>
    <script src="<c:out value='${webResourcePath}'/>/skinem/bootstrap/bootstrap-datepicker/bootstrap-datepicker.js"></script>
    <script src="<c:out value='${webResourcePath}'/>/skinem/angular/js/angular.min.js"></script>
    <script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/angular/survey/controller.js"></script>
    <script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/angular/survey/view.js"></script>
    <c:if test="${validSurvey eq true}">
    <script type="text/javascript">
  	//<![CDATA[
  	    if(surveyDefinition.survey != undefined) {         
	  	    try {
	  			if($.isArray(surveyDefinition.survey.types)) {
	  				var script = document.createElement('script');
	  	        	script.setAttribute('type', 'text/javascript');
	  	        
	  				var ntypes = surveyDefinition.survey.types;
	  				for(var i = 0; i < ntypes.length; i++) {
	  					console.log(ntypes[i]);
	  					script.innerText += 'surveyApp.directive("' + ntypes[i].name + '", function() { return { template: \'' + ntypes[i].renderer + '\'}});';
	  				}
	  				document.body.appendChild(script);	
	  			}
	  	    } catch(e) { console.log(e) }
	
	        $(document).ready(function () {
	        	surveyManager.initSelectors();
	        });
  	    }
    //]]>
    </script>
    </c:if>
</syswf:form>    
</body>
</html>