<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="messages"/>

<%--@elvariable id="validationResultsInfo" type="com.hp.systinet.policy.compliance.common.ValidationResultsInfo"--%>
<%--@elvariable id="bean" type="com.hp.systinet.report.ui.impl.policy.ValidationErrorMessage.ValidationErrorMessageBean"--%>

<%--
This component requires parameter validationResultsInfo, and displays an error message if there was some validation
error. Links will be displayed with popup window showing stacktrace.
--%>

<c:if test="${bean.showErrorMessage}">
    <%-- Put stacktrace window divs at the beginning, they don't work in error msg divs --%>
    <c:forEach items="${bean.errorItems}" var="errorItem" varStatus="status">
        <syswf:component name="/reports/policy/stackTraceWindow"
                         prefix="stackTraceWindow_${status.index}">
            <syswf:param name="linkId" value="${prefix}_errorItem_${status.index}"/>
            <syswf:param name="stackTrace" value="${errorItem.second}"/>
        </syswf:component>
    </c:forEach>

    <div class="UI SystemMessage Error">
        <div class="MessageContainer Icon Error">
            <div class="Text">
                <c:if test="${not empty bean.errorType}">
                    <c:choose>
                        <c:when test="${bean.errorType eq 'validationExecution'}">
                            <c:set var="errorMsgKey" value="validationExecutionError.msg"/>
                        </c:when>
                        <c:when test="${bean.errorType eq 'validationResult'}">
                            <c:set var="errorMsgKey" value="validationError.artifacts.msg"/>
                        </c:when>
                        <c:when test="${bean.errorType eq 'validationResultAndAssertion'}">
                            <c:set var="errorMsgKey" value="validationError.artifacts.msg"/>
                        </c:when>
                        <c:when test="${bean.errorType eq 'assertion'}">
                            <c:set var="errorMsgKey" value="validationError.policies.msg"/>
                        </c:when>
                    </c:choose>

                    <c:set var="errorItems">
                        <c:forEach items="${bean.errorItems}" var="errorItem" varStatus="status">
                            <a id="${prefix}_errorItem_${status.index}" href="javascript:void(0);"><c:out
                                    value="${errorItem.first}"/></a><c:if test="${not status.last}">,</c:if>
                        </c:forEach>
                    </c:set>
                    <fmt:message key="${errorMsgKey}" bundle="${messages}">
                        <fmt:param value="${errorItems}"/>
                    </fmt:message>
                </c:if>
            </div>
            <div class="x-clear"/>
        </div>
    </div>
</c:if>
