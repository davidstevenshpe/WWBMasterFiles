<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<c:choose>
		<c:when test="${not empty winTitle}">
			<c:set var="title" value="${winTitle}" />
		</c:when>
		<c:otherwise>
			<c:set var="title"><fmt:message bundle="${messages}" key="delete.title" /> </c:set>	
		</c:otherwise>
</c:choose>

<syswf:component name="/data/js" prefix="server_code">
  <syswf:param name="sourceId" value="checkEditSurveyDefinitions"/>
  <syswf:param name="code">
    function checkEditSurveyDefinitions(uuids) {
        return Packages.com.hp.systinet.sc.ui.impl.bulk.DeleteComponent.getInstance().checkEditSurveyDefinitions(uuids);
    }
  </syswf:param>
</syswf:component>

 <script type="text/javascript">
//<![CDATA[
	function ${controlName}(){		
	    var uuids = '';
		var myList = document.getElementsByTagName("input");
		for (var i = 0; i < myList.length; i++) {
			if(myList[i].type == "checkbox" && myList[i].name.indexOf("selectionVisual") != -1){				
				if(myList[i].checked == true){
					uuids += myList[i].value;
					uuids += ":";
				}
			}
		}
		uuids = uuids.substring(0,uuids.length - 1);
		
		checkEditSurveyDefinitions(uuids,function(result){
			if(result ==  'true'){
				openWarningDialogForSurvey();
			}else{
				openWarningDialog();
			}
		});	
	}			
//]]>
</script>

<syswf:component name="/core/window" prefix="dw">
    <syswf:param name="winComponent" value="/core/impl/bulk/deleteWindow" />
    <syswf:param name="winTitle" value="${title}"/>
	<syswf:param name="warningMessageKey" value="${warningMessageKey}" />
    <syswf:param name="winOpenFunctionName" value="openWarningDialog" />
    <syswf:param name="winOkAction" value="${prefix}delete" />
    <syswf:param name="winWidth"><c:out value="${winWidth}" default="300" /></syswf:param>
    
    <syswf:param name="artifact" value="${artifact}" />
    <syswf:param name="settings" value="${settings}"/>
    <syswf:param name="selectionBag" value="${selectionBag}" />
    <syswf:param name="artifactName" value="${artifactName}" />
    <syswf:param name="disableAdvancedOptions" value="${disableAdvancedOptions}"/>
    <syswf:param name="referencingArtifacts" value="${referencingArtifacts}" />
    <syswf:param name="singleDelete" value="${singleDelete}" />
</syswf:component>

<syswf:component name="/core/window" prefix="dwWarning">
    <syswf:param name="winComponent" value="/core/impl/bulk/deleteWindow" />
    <syswf:param name="winTitle" value="Confirm Script Deleting" />
	<syswf:param name="warningMessageKey" value="deleteSurveysManagementScriptWarning" />
    <syswf:param name="winOpenFunctionName" value="openWarningDialogForSurvey" />
    <syswf:param name="winOkAction" value="${prefix}deleteSurvey" />
    <syswf:param name="winWidth"><c:out value="500" default="300" /></syswf:param>
    
    <syswf:param name="artifact" value="${artifact}" />
    <syswf:param name="settings" value="${settings}"/>
    <syswf:param name="selectionBag" value="${selectionBag}" />
    <syswf:param name="artifactName" value="${artifactName}" />
    <syswf:param name="disableAdvancedOptions" value="true"/>
    <syswf:param name="referencingArtifacts" value="${referencingArtifacts}" />
    <syswf:param name="singleDelete" value="${singleDelete}" />
</syswf:component>

<%-- action control - fires action after user presses OK --%>
<syswf:control mode="script" action="delete" caption="${prefix}delete" >
	<syswf:param name="removeRelation" value="${removeRelation}" />
</syswf:control>

<syswf:control mode="script" action="deleteSurvey" caption="${prefix}deleteSurvey" />
