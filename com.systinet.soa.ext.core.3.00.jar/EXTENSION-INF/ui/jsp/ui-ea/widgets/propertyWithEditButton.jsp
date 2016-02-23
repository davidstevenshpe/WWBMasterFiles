<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="uisccomponentsmessages"/>
<fmt:message var="editLabel" key="property.edit.label" bundle="${uisccomponentsmessages}"/>

<c:if test="${hasWritePermission}">
<c:set var="editLink">
	<syswf:control mode="anchor" targetTask="/${viewId}/editArtifact" caption="${editLabel}">
		<syswf:taskParam name="uuid">${artifact._uuid}</syswf:taskParam>
		<syswf:taskParam name="tabId">${tabId}</syswf:taskParam>
        <syswf:taskParam name="subTabId">${subTabId}</syswf:taskParam>
	</syswf:control>
</c:set>
</c:if>

<c:if test="${not empty propertyValue or showNAIfNull}">
	<table class="UI Table Properties">
		<colgroup>
			<col class="LabelCol">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<th>
					<label class="UI Label Inline">${propertyLabel}:</label>
				</th>
				<td>
					<span class="IconAlign">
						<ul class="rel-new-and-add-link">
							<li>
								<c:if test="${not empty propertyValue}">${propertyValue}</c:if>
								<c:if test="${empty propertyValue && showNAIfNull}">N/A</c:if>
							</li>
							<c:if test="${hasWritePermission}">
							<li>,&nbsp</li>
							<li>${editLink}</li>
							</c:if>
						</ul>
					</span>
				</td>
			</tr>
		</tbody>
	</table>
</c:if>