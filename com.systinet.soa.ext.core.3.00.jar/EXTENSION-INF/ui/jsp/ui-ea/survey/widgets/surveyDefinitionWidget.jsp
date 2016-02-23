<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not isSurveyDefPurged}">
	<fmt:setBundle basename="com.hp.systinet.ea.ui.surveymessages" var="messages"/>
	<fmt:message var="label" key="survey.progress.label" bundle="${messages}"/>
	
	<table class="UI Table Properties">
		<colgroup>
			<col class="LabelCol">
			<col>
		</colgroup>
		<tbody>
			<tr id="">
				<th>
					<label class="UI Label Inline" id="surveyDefinitionLabel"> 
						<c:out value="${relLabel}" />:
					</label>
				</th>
				<td>
					<c:if test="${not empty surveyDefUuid}">
						<syswf:control mode="anchor" caption="${surveyDefName}" targetTask="/artifact/${surveyDefUuid}" id="${prefix}surveyDefinition" targetDepth="0"/>
					</c:if>
				</td>
			</tr>
		</tbody>
	</table>
</c:if>