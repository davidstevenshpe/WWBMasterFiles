<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<fmt:message var="noLifecycleStatusAssigned" key="noLifecycleStatusAssigned" bundle="${widgetMessages}"/>
<fmt:message var="lifecycleStatusApproved" key="lifecycleStatus.APPROVED" bundle="${widgetMessages}"/>
<fmt:message var="lifecycleStatusRejected" key="lifecycleStatus.REJECTED" bundle="${widgetMessages}"/>
<fmt:message var="lifecycleStatusFailed" key="lifecycleStatus.FAILED" bundle="${widgetMessages}"/>
<fmt:message var="lifecycleStatusVoting" key="lifecycleStatus.VOTING" bundle="${widgetMessages}"/>
<fmt:message var="lifecycleStatusInProgress" key="lifecycleStatus.INPROGRESS" bundle="${widgetMessages}"/>
<fmt:message var="lifecycleStatusChanged" key="lifecycleStatus.CHANGED" bundle="${widgetMessages}"/>

<%-- use enum description once LFC status contains it --%>
<c:if test="${mode eq 'table'}">    
    <c:choose>
        <c:when test="${not empty lifecycleStatus}">
            <c:choose>
                <c:when test="${lifecycleStatus eq 'APPROVED'}">
                    <c:set var="statusIcon" value="EventApproved"/>
                    <c:set var="statusText" value="${lifecycleStatusApproved}"/>
                </c:when>
                <c:when test="${lifecycleStatus eq 'REJECTED'}">
                    <c:set var="statusIcon" value="EventRejected"/>
                    <c:set var="statusText" value="${lifecycleStatusRejected}"/>
                </c:when>
                <c:when test="${lifecycleStatus eq 'FAILED'}">
                    <c:set var="statusIcon" value="EventFailed"/>
                    <c:set var="statusText" value="${lifecycleStatusFailed}"/>
                </c:when>                
                <c:when test="${lifecycleStatus eq 'VOTING'}">
                    <c:set var="statusIcon" value="EventVoted"/>
                    <c:set var="statusText" value="${lifecycleStatusVoting}"/>
                </c:when>
                <c:when test="${lifecycleStatus eq 'INPROGRESS'}">
                    <c:set var="statusIcon" value="EventUserActionPending"/>
                    <c:set var="statusText" value="${lifecycleStatusInProgress}"/>
                </c:when>
                <c:when test="${lifecycleStatus eq 'CHANGED'}">
                    <c:set var="statusIcon" value="EventApproved"/>
                    <c:set var="statusText" value="${lifecycleStatusChanged}"/>
                </c:when>
            </c:choose>
            <span class="UI Icon ${statusIcon}">${statusText}</span>
        </c:when>
        <c:otherwise>            
            ${noLifecycleStatusAssigned}
        </c:otherwise>
    </c:choose>

</c:if>