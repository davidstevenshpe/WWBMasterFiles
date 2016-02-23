<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.ea.ui.surveymessages" var="messages"/>
<fmt:message var="title" key="survey.cancel.label" bundle="${messages}"/>
<fmt:message var="warningMessage" key="survey.cancel.label" bundle="${messages}"/>

<c:choose>
	<c:when test="${this.permissions.write}">
		<a id="cancelSurvey" href="javascript:void(0);" class="with-text context-button CancelSurvey">
			<span>${title}</span>
		</a>				
	</c:when>
	<c:otherwise>
		<fmt:message var="hasNotRightPermissionLabel" key="survey.action.editSurvey.hasNotRightPermission.label" bundle="${messages}"/>
		<a href="javascript:void(0);" id="${prefix}anchor" class="with-text context-button CancelSurvey" style="opacity: 0.6">
			<span>${title}</span>
		</a>
	</c:otherwise>
</c:choose>

<c:if test="${this.permissions.delete and not deleted}">

	<c:set var="controlName" value="deleteArtifactFunc" />
    <syswf:component name="/core/impl/bulk/deleteSingle" prefix="del">
        <syswf:param name="artifact" value="${artifact}" />
		<syswf:param name="winTitle" value="${title}" />
		<syswf:param name="warningMessageKey" value="cancel.cancelSurvey" />
        <syswf:param name="uuid" value="${artifact._uuid}" />
        <syswf:param name="artifactName" value="${artifact.name}" />
        <syswf:param name="controlName" value="${controlName}" />
        <syswf:param name="disableAdvancedOptions" value="true"/>
		<syswf:param name="includeSubArtifacts" value="false"/>
        <syswf:param name="winWidth" value="500" />
        <syswf:param name="singleDelete" value="true" />
    </syswf:component>
	
    <script type="text/javascript">
	//<![CDATA[

		Ext4.onReady(function() {
			attachOn('cancelSurvey','click',${controlName});
			moveWindow('${prefix}_del_dwwin','popupWindows');
		});
		
	//]]>
	</script>

</c:if>