<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<fmt:setBundle basename="com.hp.systinet.ea.ui.cloudmigration" var="messages"/>
<fmt:setBundle basename="com.hp.systinet.ea.ui.uimessages" var="uimessages"/>
<fmt:message var="msg_financialAlignment" key="cloud.migration.financial.alignmentScore" bundle="${messages}"/>
<fmt:message var="msg_financialAlignmentDesc" key="cloud.migration.financial.alignmentScore.desc" bundle="${messages}"/>
<table class="UI Table Properties">
	<colgroup>
		<col class="LabelCol">
		<col>
	</colgroup>
		<tbody>
			<tr>
			  <td colspan="2">
				 <div class="help-text ${linkTabId}" style="display: none;">${msg_financialAlignmentDesc}</div>
			  </td>
			</tr>
			<tr>
			  <th><label class="UI Label Inline" title="${msg_financialAlignment}">${msg_financialAlignment}:</label></th>
			  <td>
				 <span class="IconAlign">${financialAlignment}</span>
			  </td>
			</tr>
		</tbody>
</table>