<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--
  Renderer for FormValidationException content. It only supports error messages.
--%>

<%--@elvariable id="failureInfo" type="com.hp.systinet.policy.form.validation.structures.FormValidationFailureInfo"--%>
<%--@elvariable id="exception" type="com.hp.systinet.policy.form.validation.exception.FormValidationException"--%>

<fmt:setBundle basename="com.hp.systinet.policy.ui.UiPolicyL10n" var="messages"/>

<div class="UI SystemMessage Error">
    <div class="MessageContainer">
        <div class="Text">
            <strong><fmt:message key="formValidation_error" bundle="${messages}"/></strong>
            <c:out value="${failureInfo.failMessageHeader}" escapeXml="false"/>
            <ul class="UI Bullets">
                <c:forEach var="item" items="${failureInfo.assertionFailureInfos}" varStatus="status">
                    <li class="New">
                        <c:out value="${item.hint}"/>
                        <fmt:message key="formValidation.assertion.technicalPolicyRef" bundle="${messages}" var="technicalPolicyRef">
                            <fmt:param>${item.technicalPolicyName}</fmt:param><%-- don't escape technicalPolicyName because complete message are escaped in uiMessage component --%>
                        </fmt:message>
                        <syswf:component prefix="tpLink_${status.index}" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                            <syswf:param name="uuid" value="${item.technicalPolicyUuid}"/>
                            <syswf:param name="caption" value="${technicalPolicyRef}"/>
                        </syswf:component>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="x-clear"></div>
    </div>
</div>
