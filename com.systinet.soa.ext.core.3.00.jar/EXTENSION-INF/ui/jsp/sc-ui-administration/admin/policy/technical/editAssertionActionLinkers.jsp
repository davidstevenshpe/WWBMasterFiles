<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.policy.technical.TechnicalPolicyMessages" var="tpMessages" />

<c:if test="${isAccessGranted and (not isDeleted) and((empty hasError) or (not hasError))}">
	<a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}editAssertion" onclick="${openDialogFunction}('${beanId}', '${editParamMode}')">
		<fmt:message key="editAssertionLinker.label" bundle="${tpMessages}"/>
	</a>
</c:if>