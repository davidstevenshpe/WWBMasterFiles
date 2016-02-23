<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.contract.ui.impl.ContractUIMessages" var="msg"/>
<fmt:message key="Artifact_CreateConsumptionRequest" var="action" bundle="${msg}"/>

<c:if test="${enabled}">
	         <c:choose>
				<c:when test="${contextMenu}">
				<div class="EA-left-panel">
				    <syswf:control mode="anchor" caption="${action}" targetTask="/common/contract/newRequest">
				        <syswf:param name="canChangeConsumer" value="${canChangeConsumer}"/>
				        <syswf:param name="canChangeProvider" value="${canChangeProvider}"/>
				        <syswf:param name="uuid">${artifact._uuid}</syswf:param>
				        <syswf:attribute name="class" value="UI PageAction Notify"/>
   				   </syswf:control>
				</div>
				</c:when>
				<c:otherwise>
					<syswf:control mode="anchor" caption="" targetTask="/common/contract/newRequest" hint="${action}">
				        <syswf:param name="canChangeConsumer" value="${canChangeConsumer}"/>
				        <syswf:param name="canChangeProvider" value="${canChangeProvider}"/>
				        <syswf:param name="uuid">${artifact._uuid}</syswf:param>
				        <syswf:attribute name="class" value="context-button Notify"/>
   				   </syswf:control>
				</c:otherwise>
		</c:choose>

</c:if>