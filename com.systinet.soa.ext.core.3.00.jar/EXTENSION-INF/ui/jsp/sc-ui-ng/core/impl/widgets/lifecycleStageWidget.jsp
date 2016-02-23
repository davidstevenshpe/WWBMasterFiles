<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<fmt:message var="noLifecycleStatusAssigned" key="noLifecycleStageAssigned" bundle="${widgetMessages}"/>

<c:if test="${mode eq 'table'}">
    <c:choose>
        <c:when test="${not empty lifecycleStage}">
            <c:choose>
                <c:when test="${isGovernedNow and (not empty uuid)}">
                    <syswf:control id="lfcTab" mode="anchor" caption="${lifecycleStage}" targetTask="/artifact/${uuid}">
                        <syswf:param name="artifactTabId" value="lifecycle"/>
                        <c:choose>
                            <c:when test="${not empty revision}">
                                <syswf:param name="revision" value="${revision}"/>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${not empty sliceTime}">
                                    <syswf:param name="timeSlice" value="${sliceTime}"/>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </syswf:control>
                </c:when>
                <c:otherwise>
                    <c:out value="${lifecycleStage}"/>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>            
            <syswf:out value="${noLifecycleStatusAssigned}" context="HtmlBody"/>
        </c:otherwise>
    </c:choose>
</c:if>