<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<%--@elvariable id="entry" type="com.hp.systinet.lifecycle.ui.catalog.visualization.PoliciesSection.PoliciesSectionEntry"--%>
<%--@elvariable id="entryId" type="java.lang.String"--%>
<%--@elvariable id="showRuntimeData" type="java.lang.Boolean"--%>
<%--@elvariable id="showValidationButton" type="java.lang.Boolean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<c:set var="commentBodyId" value="${entryId}_comment"/>
<table class="UI Table Properties">
    <col class="FormSelectCol"/>
    <col class="LongLabelCol"/>
    <col/>
    <col class="ControlCol"/>
    <tr>
        <td>
            <syswf:component prefix="desc" name="/newUi/lc/common/widget/expandComment" wrap="false">
                <syswf:param name="bodyId" value="${commentBodyId}"/>
            </syswf:component>
        </td>
        <td>
            <syswf:component prefix="policy" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                <syswf:param name="uuid" value="${entry.policyUuid}"/>
                <syswf:param name="caption" value="${entry.policyName}"/>
                <syswf:param name="class" value="IconAlign"/>
            </syswf:component>
        </td>
        <td>
            <fmt:message key="policiesSection.requiredStatus.${entry.required}"
                         bundle="${messages}" var="requiredStatus"/>
            <fmt:message key="policiesSection.validationStatus.${entry.validationStatus}"
                         bundle="${messages}" var="validationStatusText"/>
            <c:set var="validationStatus">
                <c:choose>
                    <c:when test="${entry.validationFailed}">
                        <syswf:component prefix="${prefix}complianceReportLink" name="/core/impl/util/artifactLinkRenderer" wrap="false">
                            <syswf:param name="uuid" value="${artifact._uuid}"/>
                            <syswf:param name="caption" value="${validationStatusText}"/>
                            <syswf:param name="artifactTabId" value="compliance"/>
                            <syswf:param name="class" value="IconAlign"/>
                        </syswf:component>
                    </c:when>
                    <c:otherwise>
                        ${validationStatusText}
                    </c:otherwise>
                </c:choose>
            </c:set>
            <fmt:message key="policiesSection.validationStatusClass.${entry.validationStatus.name}"
                         bundle="${messages}" var="validationStatusClass"/>
            <c:choose>
                <%--@elvariable id="showRuntimeData" type="java.lang.Boolean"--%>
                <c:when test="${showRuntimeData}">
                    <c:choose>
                        <c:when test="${not entry.validationRunning}">
                            <div class="UI Icon ${validationStatusClass}">
                                <span <c:if test="${entry.required && entry.validationFailed}">
                                    style="color: #ff0000;"
                                </c:if>>${requiredStatus}</span>, ${fn:trim(validationStatus)}</div>
                        </c:when>
                        <c:otherwise>
                                <div class="UI Icon ${validationStatusClass}">${requiredStatus}</div>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <div class="IconAlign">${requiredStatus}</div>
                </c:otherwise>
            </c:choose>
        </td>
        <td>
            <div class="Text RightAlign">
                <c:choose>
                    <c:when test="${entry.validationRunning}">
                    <span class="UI Icon Working"><fmt:message
                            key="policiesSection.validationRunningLabel"
                            bundle="${messages}"/></span>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${showValidationButton}">
                            <fmt:message key="policiesSection.runValidationButton" bundle="${messages}"
                                         var="validateButtonCaption"/>
                            <syswf:control mode="postAnchor" action="validate" caption="${validateButtonCaption}"
                                           wrapper="span" affects=".">
                                <syswf:attribute name="class" value="UI Icon Validation"/>
                            </syswf:control>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </td>
    </tr>
</table>
<syswf:component prefix="descBody" name="/newUi/lc/common/widget/expandCommentBody" wrap="false">
    <syswf:param name="bodyId" value="${commentBodyId}"/>
    <syswf:param name="commentedTextHasCheckbox" value="${false}"/>
    <syswf:param name="content">
        <c:if test="${entry.validationFailedWithError}">
            <div class="UI SystemMessage Error">
                <div class="MessageContainer">
                    <div class="Text">
                        <strong><fmt:message key="errorBoxPrefix" bundle="${messages}"/>:</strong>
                        <fmt:message key="policiesSection.validationErrorMessage" bundle="${messages}"/>
                    </div>
                    <div class="x-clear"></div>
                </div>
            </div>
        </c:if>
        <p class="Comment Plain">
            <c:if test="${not empty entry.policyDescription}">
                <c:out value="${entry.policyDescription}" escapeXml="false"/>
                <br/>
            </c:if>
            <strong><fmt:message key="policiesSection.applicableTo" bundle="${messages}"/>:</strong>
            <c:forEach var="type" varStatus="status" items="${entry.artifactTypeNames}">
                <c:out value="${type}"/><c:if test="${not status.last}">,</c:if>
            </c:forEach>
        </p>
    </syswf:param>
</syswf:component>



