<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="message"/>
<fmt:message var="financialInfo" key="financial.info" bundle="${message}"/>
<fmt:message var="financialInfoDesc" key="financial.info.description" bundle="${message}"/>
<fmt:message var="newFiscalPeriod" key="new.fiscal.period" bundle="${message}"/>

<c:set var="currentFiscalPeriodVal"><c:choose>
  <c:when test="${empty accessDenyUuids}">${this.currentFiscalPeriod}</c:when>
  <c:otherwise></c:otherwise>
</c:choose></c:set>

<fmt:message var="financialInfoParam" key="financial.info.param" bundle="${message}">
	<fmt:param value="${currentFiscalPeriodVal}"/>
</fmt:message>

<div class="Title">
	<h3><span>
		<c:choose>
			<c:when test="${not empty currentFiscalPeriodVal}">
				<c:out value="${financialInfoParam}"/>
			</c:when>
			<c:otherwise>
				<c:out value="${financialInfo}"/>
			</c:otherwise>
		</c:choose>
	</span></h3>
</div>
<i>
	<c:out value="${financialInfoDesc}"/>
</i>
<c:set var="surveyActions">
<c:if test="${not empty takeSurveyScriptLocation}">
<syswf:component name="/survey/offerSurvey" prefix="financialAssessmentOfferSurvey" wrap="false">
   <syswf:param name="artifact" value="${artifact}"/>
   <syswf:param name="scriptLocation" value="${takeSurveyScriptLocation}"/>
</syswf:component>
<syswf:component name="/survey/viewAnswer" prefix="financialAssessmentViewAnswers" wrap="false">
   <syswf:param name="artifact" value="${artifact}"/>
   <syswf:param name="scriptLocation" value="${takeSurveyScriptLocation}"/>
   <syswf:param name="label" value="Review Survey Answers"/>
</syswf:component>

</c:if>
</c:set>
<c:choose>
	<c:when test="${fn:length(linkedArtifacts) > 0 }">
		<div id="${prefix}ContextAction">
		${surveyActions}
		</div>
		<syswf:component name="/core/impl/artifact/financialProfile/linkedFinancialPropertiesDetail" prefix="${prefix}LinkedPropertiesDetailId">
		    <syswf:param name="artifact" value="${linkedArtifacts[0]}" />
		    <syswf:param name="linkedProperties" value="${linkedProperties}" />
		    <syswf:param name="creationListener" value="${linkToNewFiscalPeriodListener}"/>
		    <syswf:param name="mode" value="view" />
		    <syswf:param name="parentArtifactName" value="${parentArtifactName}"/>
		    <syswf:param name="parentArtifactVersion" value="${parentArtifactVersion}"/>
		    <syswf:param name="disableFinancialButton" value="${disableFinancialButton}"/>
		    <syswf:param name="contextActionId" value="${prefix}ContextAction"/>
		</syswf:component>		
	</c:when>
	<c:otherwise>
		<syswf:control id="${prefix}createNew" mode="button" caption="${newFiscalPeriod}" targetTask="/${viewId}/newArtifact" icon="plus-square">
	        <syswf:param name="sdmName" value="${artifactType}"/>
	        <syswf:param name="creationListener" value="${linkToNewFiscalPeriodListener}"/>
	        <syswf:param name="parentArtifactName" value="${parentArtifactName}"/>
	        <syswf:param name="parentArtifactVersion" value="${parentArtifactVersion}"/>
	        <c:if test="${disableFinancialButton}">
				<syswf:attribute name="disabled" value="true"/>
			</c:if>
    	</syswf:control>
    	${surveyActions}
	</c:otherwise>
</c:choose>