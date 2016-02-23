<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.report.reportMessages" var="reportMessages"/>

<c:if test="${not empty reportErrors}">
    <syswf:block className="UI Block Common">
        <div class="Title">
            <h3><fmt:message bundle="${reportMessages}" key="errors" /></h3>
        </div>

        <div class="Content">                   
            <c:forEach items="${reportErrors}" var="entry" varStatus="status">
                <c:set var="reportErrorTypeBundleKey" value="${reportRendererId}.reportErrorType.${entry.key}"/>
                <fmt:message var="errorType" key="${reportErrorTypeBundleKey}" bundle="${reportMessages}"/>
                          
                <span class="UI Icon Error">
                    <strong>${errorType}</strong>
                    <c:set var="count" value="${fn:length(entry.value)}"/>
                    <span class="Comment">(${count})</span>
                </span>
                <div class="Offset">
                    <c:choose>
                        <c:when test="${isErrorInfo}">
                            <c:forEach end="3" items="${entry.value}" var="item">
                                <span class="Comment">${item}</span><br />
                            </c:forEach>
                            <c:if test="${fn:length(entry.value) > 3}">
                                <span class="Comment"><fmt:message bundle="${reportMessages}" key="andMore" /></span>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <c:set var="reportErrorDescriptionBundleKey" value="${reportRendererId}.reportErrorDescription.${entry.key}"/>
                            <fmt:message var="errorMessage" key="${reportErrorDescriptionBundleKey}" bundle="${reportMessages}"/>
                            <span class="Comment">${errorMessage}</span>
                        </c:otherwise>
                    </c:choose>
                </div>                    
            </c:forEach>
        </div>        
    </syswf:block>
</c:if>
<c:if test="${not empty reportWarnings}">
    <syswf:block className="UI Block Common">
        <div class="Title">
            <h3><fmt:message bundle="${reportMessages}" key="warnings" /></h3>
        </div>

        <div class="Content">                   
            <c:forEach items="${reportWarnings}" var="entry" varStatus="status">
                <c:set var="reportWarningTypeBundleKey" value="${reportRendererId}.reportWarningType.${entry.key}"/>
                <fmt:message var="warningType" key="${reportWarningTypeBundleKey}" bundle="${reportMessages}"/>
                                   
                <span class="UI Icon Warning">
                    <strong>${warningType}</strong>
                    <c:set var="count" value="${fn:length(entry.value)}"/>
                    <span class="Comment">(${count})</span>
                </span>
                <div class="Offset">
                    <c:choose>
                        <c:when test="${isWarningInfo}">
                            <c:forEach end="3" items="${entry.value}" var="item">
                                <span class="Comment">${item}</span><br />
                            </c:forEach>
                            <c:if test="${fn:length(entry.value) > 3}">
                                <span class="Comment"><fmt:message bundle="${reportMessages}" key="andMore" /></span>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <c:set var="reportWarningDescriptionBundleKey" value="${reportRendererId}.reportWarningDescription.${entry.key}"/>
                            <fmt:message var="warningMessage" key="${reportWarningDescriptionBundleKey}" bundle="${reportMessages}"/>
                            <span class="Comment">${warningMessage}</span>
                        </c:otherwise>
                    </c:choose>
                </div>                    
            </c:forEach>
        </div>        
    </syswf:block>
</c:if>