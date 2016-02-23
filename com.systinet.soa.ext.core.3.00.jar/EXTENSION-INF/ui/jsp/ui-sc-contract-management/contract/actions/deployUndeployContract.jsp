<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<c:if test="${statusModel.contract.contractState.val eq 'uddi:systinet.com:soa:model:taxonomies:contractAgreementStates:accepted' and proxyMgmtEnabled and statusModel.allowDeployment}">
	<c:choose>
		<c:when test="${statusModel.deployed }">
			<c:if test="${not contextAction}">
				<a id="undeployContractLink" href="javascript:undeployContract('${statusModel.contract._uuid}','<syswf:out value='${statusModel.contract.name}' context='HtmlJSText'/>');">${deployMessage }</a>
			</c:if>
		</c:when>
		<c:otherwise>						
			<c:choose>				
				<c:when test="${contextAction}">
					<a  id="deployContractAction" href="javascript:void(0);" onclick="deployContract('${statusModel.contract._uuid}','<syswf:out value="${statusModel.contract.name}" context="HtmlJSText"/>','${statusModel.contract._domainId}');" class="UI PageAction Deploy">${deployMessage }</a>
					<syswf:component name="/provision/createProxyWindow" prefix="create" wrap="false"/>
				</c:when>
				<c:otherwise>
					<a  id="deployContractLink" href="javascript:void(0);" onclick="deployContract('${statusModel.contract._uuid}','<syswf:out value="${statusModel.contract.name}" context="HtmlJSText"/>','${statusModel.contract._domainId}');">${deployMessage }</a>					
				</c:otherwise>
			</c:choose>						
		</c:otherwise>	
	</c:choose>
</c:if>
