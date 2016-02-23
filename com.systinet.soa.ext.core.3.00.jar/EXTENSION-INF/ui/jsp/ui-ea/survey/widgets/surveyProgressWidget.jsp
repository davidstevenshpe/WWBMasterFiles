<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty surveyProgressInfo}">
	<fmt:setBundle basename="com.hp.systinet.ea.ui.surveymessages" var="messages"/>
	<fmt:message var="label" key="survey.progress.label" bundle="${messages}"/>
	<table class="UI Table Properties">
		<colgroup>
			<col class="LabelCol">
			<col>
		</colgroup>
		<tbody>
			<tr>
			<c:if test="${not empty this.mode and this.mode eq 'view' }"><%-- mode = table does not show this element --%>
				<th>
					<label class="UI Label Inline" id="surveyProgressLabel"> 
						<c:out value="${label}" />:
					</label>
				</th>
			</c:if>
				<td>
					<fmt:message var="value" key="survey.progress.value" bundle="${messages}">
						<fmt:param value="${surveyProgressInfo.finishedRespondents}" />
						<fmt:param value="${surveyProgressInfo.totalRespondents}" />
					</fmt:message>					
					
					<c:set var="color" value="#FFF"/>
					<c:if test="${(surveyProgressInfo.finishedRespondents / surveyProgressInfo.totalRespondents)*100 <= 10}">
						<c:set var="color" value="#000"/>
					</c:if>
					
					<c:set var="customWidth">
						<c:choose>
							<c:when test="${surveyProgressInfo.finishedRespondents eq 0}">
								<c:set var="color" value="#000"/>
								<c:out value="auto"/>
							</c:when>
							<c:otherwise>
								<c:out value="${(surveyProgressInfo.finishedRespondents / surveyProgressInfo.totalRespondents)*100}%"/>
							</c:otherwise>
						</c:choose>
					</c:set>
					
					<c:choose>
                        <c:when test="${surveyProgressInfo.completed eq true}">
                                <c:set var="status" value="completed"/>
                                <c:set var="customWidth" value="auto"/>
                        </c:when>
						<c:when test="${surveyProgressInfo.overdate eq true}">
							<fmt:message var="labelOverdue" key="survey.progress.overdue" bundle="${messages}"/>
							<c:choose>
								<c:when test="${surveyProgressInfo.finishedRespondents eq 0}">
									<c:set var="color" value="#FF0000"/>
								</c:when>
								<c:otherwise>
									<c:set var="status" value="overdate"/>
								</c:otherwise>
							</c:choose>							
						</c:when>
						<c:otherwise>
							<c:if test="${surveyProgressInfo.finishedRespondents gt 0}">
								<c:set var="status" value="notCompleted"/>
							</c:if>
						</c:otherwise>
					</c:choose>
					
					<div class="survey-progress-bar" title="${labelOverdue}">
						<div class="survey-progress-bar-info <c:out value="${status}"/>" style="color: <c:out value="${color}"/>; width: <c:out value="${customWidth}"/>">
							<c:out value="${value}" />
						</div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</c:if>