<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${this.permissions.delete and not deleted}">
    <c:set var="controlName" value="deleteArtifactFunc" />
    <syswf:component name="/core/impl/bulk/deleteSingle" prefix="del">
        <syswf:param name="artifact" value="${artifact}" />
        <syswf:param name="uuid" value="${artifact._uuid}" />
        <syswf:param name="artifactName" value="${artifact.name}" />
		<c:if test="${showWarning}">
			<syswf:param name="winTitle" value="Confirm Script Deleting" />
			<syswf:param name="warningMessageKey" value="deleteSurveyManagementScriptWarning" />
		</c:if>
        <syswf:param name="controlName" value="${controlName}" />
        <syswf:param name="includeSubArtifacts" value="${includeSubArtifacts}"/>
        <syswf:param name="disableAdvancedOptions" value="${disableAdvancedOptions}"/>
        <syswf:param name="referencingArtifacts" value="${referencingArtifacts}" />
        <syswf:param name="winWidth" value="500" />
        <syswf:param name="singleDelete" value="true" />
    </syswf:component>
	
	<syswf:control mode="script" action="checkUsingSurveyDefinition" caption="checkUsingSurveyDefinition" affects=".">
	   <syswf:param name="artifact" value="${artifact}" />
	</syswf:control>
    
    <fmt:setBundle basename="com.hp.systinet.sc.ui.bulk.messages" var="messages"/>
    <fmt:message var="delete_buttonLabel" key="bulk.opDelete.label" bundle="${messages}"/>
         <c:choose>
				<c:when test="${contextMenu}">
				<div class="EA-right-panel">
					<c:out value="${buttonCode}" escapeXml="false" default="<a id=\"DeleteArtifact\" href=\"javascript:void(0);\" class=\"UI PageAction Delete\">${delete_buttonLabel}</a>" />
				</div> 	
				</c:when>
				<c:otherwise>
					<c:out value="${buttonCode}" escapeXml="false" default="<a id=\"DeleteArtifact\" href=\"javascript:void(0);\" class=\"context-button Delete\" title=\"${delete_buttonLabel}\"></a>" />
				</c:otherwise>
		</c:choose>
    <script type="text/javascript">
//<![CDATA[


    Ext.onReady(function() {

	    <c:choose>
			<c:when test="${surveyDefinitionArtifact}">
				 function onDeleteArtifact(){	    				 
					checkUsingSurveyDefinition();		
				 }
				 attachOn('DeleteArtifact','click',onDeleteArtifact);
				
			</c:when>
			<c:otherwise>
				attachOn('DeleteArtifact','click',${controlName});
			</c:otherwise>
		</c:choose>
       		
        moveWindow('${prefix}_del_dwwin','popupWindows');
		
		<c:if test="${checked}">			
			${controlName}();
		</c:if>
    });
	
//]]>
</script>

    
</c:if>