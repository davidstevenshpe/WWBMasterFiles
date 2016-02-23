<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<c:if test="${mode eq 'table'}">
    <c:choose>
        <c:when test="${not empty lifecycleStageAndStatusHolder}">

            <syswf:control id="lfcTab" mode="anchor" caption="${lifecycleStageAndStatusHolder.stage}" targetTask="/artifact/${lifecycleStageAndStatusHolder.uuid}">
                <syswf:param name="artifactTabId" value="lifecycle"/>
            </syswf:control>
            
            <c:set var="bundleKey" value="lifecycleStatus.${lifecycleStageAndStatusHolder.status}"/>
            <fmt:message var="statusText" key="${bundleKey}" bundle="${widgetMessages}"/>

            <c:choose>
                <c:when test="${lifecycleStageAndStatusHolder.status eq 'APPROVED'}">
                    <c:set var="statusIcon" value="EventApproved"/>
                </c:when>
                <c:when test="${lifecycleStageAndStatusHolder.status eq 'REJECTED'}">
                    <c:set var="statusIcon" value="EventRejected"/>
                </c:when>
                <c:when test="${lifecycleStageAndStatusHolder.status eq 'FAILED'}">
                    <c:set var="statusIcon" value="EventFailed"/>
                </c:when>
                <c:when test="${lifecycleStageAndStatusHolder.status eq 'VOTING'}">
                    <c:set var="statusIcon" value="EventVoted"/>
                </c:when>
                <c:when test="${lifecycleStageAndStatusHolder.status eq 'INPROGRESS'}">
                    <c:set var="statusIcon" value="EventUserActionPending"/>
                </c:when>
            </c:choose>
           (<span class="UI Icon ${statusIcon}">${statusText}</span>)
        </c:when>
        <c:otherwise>            
            <fmt:message var="noLifecycleStageAssigned" key="noLifecycleStageAssigned" bundle="${widgetMessages}"/>
            ${noLifecycleStageAssigned}
        </c:otherwise>
    </c:choose>
    
</c:if>