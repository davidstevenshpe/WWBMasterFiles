	<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.contract.ui.impl.ContractUIMessages" var="msg"/>

<fmt:message bundle="${msg}" var="acceptButton" key="ContractState_AcceptButton"/>
<fmt:message bundle="${msg}" var="rejectButton" key="ContractState_RejectButton"/>
<fmt:message bundle="${msg}" var="approveRequest" key="ContractState_ApproveRequest"/>
<fmt:message bundle="${msg}" var="rejectRequest" key="ContractState_RejectRequest"/>
<fmt:message bundle="${msg}" var="deployTitle" key="ContractState_DeployTitle"/>


<c:choose>
    <c:when test="${statusModel.invalidContractState}">
        <c:set var="divClass" value="Invalid"/>
    </c:when>

    <c:when test="${fn:endsWith(statusModel.contract.contractState.val, 'pending')}">
        <c:set var="divClass" value="ConsumptionRequest"/>
    </c:when>

    <c:when test="${statusModel.contract.contractState.val eq 'uddi:systinet.com:soa:model:taxonomies:contractAgreementStates:rejected'}">
        <c:set var="divClass" value="Rejected"/>
    </c:when>

    <c:when test="${statusModel.contract.contractState.val eq 'uddi:systinet.com:soa:model:taxonomies:contractAgreementStates:accepted'}">
        <c:set var="divClass" value="Valid"/>
    </c:when>

    <c:when test="${statusModel.contract.contractState.val eq 'uddi:systinet.com:soa:model:taxonomies:contractAgreementStates:invalid'}">
        <c:set var="divClass" value="Invalid"/>
    </c:when>

    <c:when test="${statusModel.contract.contractState.val eq 'uddi:systinet.com:soa:model:taxonomies:contractAgreementStates:revoked'}">
        <c:set var="divClass" value="Revoked"/>
    </c:when>
</c:choose>

<syswf:component name="/contract/impl/view/lifecycleStatus" prefix="lifecycle">
	<syswf:param name="statusModel" value="${statusModel }"/>
	<syswf:param name="artifactUuid" value="${artifact._uuid }"/>
	<syswf:param name="proxyMgmtEnabled" value="${proxyMgmtEnabled }"/>
</syswf:component>

<c:if test="${statusModel.deployed}">
	<syswf:block className="Block UI Plain">
		<div class="Title">
			<h3>
				<span class="IconAlign"><c:out value="${deployTitle}" escapeXml="false"/></span>
			</h3>
		</div>
	</syswf:block>
</c:if>

<div style="padding-left:20px;">
<c:if test="${statusModel.wsdlURLs.hasEndpoints}">
    <c:if test="${not empty statusModel.wsdlURLs.unmatchedEndpoints}">
        <tr>
            <th></th>
            <td>
                <div class="UI StatusBox Invalid">
                    <div class="Title">
                        Data inconsistency detected
                    </div>
                    <div class="Message">
                        There are endpoints associated with this contract that can't be matched with the service WSDL file. This is a result of the service WSDL
                        change where a functional endpoint for which a proxy has been created no longer exists. You need to resolve this situation manually by redeploying
                        the contract. Affected endpoints are:
                        <c:forEach var="endpoint" varStatus="status" items="${statusModel.wsdlURLs.unmatchedEndpoints}">
                            <syswf:component prefix="consumer" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                                <syswf:param name="caption" value="${endpoint.name} (${endpoint.environment})"/>
                                <syswf:param name="uuid" value="${endpoint.uuid}"/>
                                <syswf:param name="sdmName" value="endpointArtifact"/>
                            </syswf:component>
                            <c:if test="${not status.last}">,</c:if>
                        </c:forEach>
                    </div>
                </div>
            </td>
        </tr>
    </c:if>

    <table style="margin:25px">
        <tr>
            <th width="200" ><label class="UI Label Inline">Contract ID:</label></th>
            <td>
                <div style="margin-top:2px">${statusModel.contractID}</div>
            </td>
            </th>
        </tr>

        <c:if test="${not empty statusModel.wsdlURLs.environmentFreeWSDLUrl}">
            <tr>
                <th><label class="UI Label Inline">Environment neutral WSDL Url:</label></th>
                <td>
                    <div style="margin-top:2px">
                        <c:forEach var="wsdl" items="${statusModel.wsdlURLs.environmentFreeWSDLUrl}">
                            <a href="<c:out value='${wsdl}'/>"><syswf:out value="${wsdl}" context="HtmlBody"/></a>
                        </c:forEach>
                    </div>
                </td>
                </th>
            </tr>
        </c:if>
    </table>

    <!-- <br/> -->
    <table border="1" width="100%" style="margin:15px">
        <tr style="background-color:#e8f1fa;"><th><div  style="margin:8px;font-weight:bold;">Environment</div></th><th><div style="margin:8px;font-weight:bold;">URL(s)</div></th></tr>
        <c:forEach var="env" items="${statusModel.wsdlURLs.environmentToWSDLs}">
            <tr>
                <td>
                    <div  style="margin:8px"><syswf:out value="${env.environment.name}" context="HtmlBody"/></div>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${not empty env.wsdls}">
                            <div style="margin-left:8px; margin-right:8px; margin-top:5px">
                                <c:forEach var="wsdl" items="${env.wsdls}">
                                    <a href="<c:out value='${wsdl.url}'/>"><syswf:out value="${wsdl.url}" context="HtmlBody"/></a>
                                    <br/>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div style="margin:8px">Not available</div>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>
</div>