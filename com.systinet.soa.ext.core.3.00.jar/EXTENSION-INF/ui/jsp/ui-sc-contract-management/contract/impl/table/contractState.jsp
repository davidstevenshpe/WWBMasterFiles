<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.contract.ui.impl.ContractUIMessages" var="msg"/>

<c:set var="stateIcon"><c:choose>
    <c:when test="${stateVal eq 'pending'}">ConsumptionRequestPending</c:when>
    <c:when test="${stateVal eq 'accepted'}">ConsumptionRequestApprove</c:when>
    <c:when test="${stateVal eq 'rejected'}">ConsumptionRequestReject</c:when>
    <c:when test="${stateVal eq 'revoked'}">ConsumptionRequestRevoke</c:when>
    <c:when test="${stateVal eq 'invalid'}">ConsumptionRequestInvalid</c:when>
    <c:when test="${stateVal eq 'invalidRequest'}">ConsumptionRequestInvalid</c:when>
</c:choose>
</c:set>
<span class="UI Icon ${stateIcon}"><fmt:message bundle="${msg}" key="ContractState_label_${stateVal}"/></span>
