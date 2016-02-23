<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.util.uimessages" var="uimessages"/>
<fmt:message var="reportStatus_NOT_COMPLETE" key="reportStatus.NOT_COMPLETE" bundle="${messages}"/>

<%--@elvariable id="reportResultCode" type="com.hp.systinet.platform.report.ReportHelper.ReportResultCode"--%>
<%--@elvariable id="reportArtifact" type="com.hp.systinet.repository.sdm.generated.artifacts.sys.ReportArtifact"--%>
<%--@elvariable id="reportStatus" type="com.hp.systinet.platform.report.ReportHelper.ReportStatus"--%>
<%--@elvariable id="reportResultCodeLabel" type="java.lang.String"--%>
<%--@elvariable id="reportStatusLabel" type="java.lang.String"--%>
<c:set var="isError" value="${reportResultCode == 'ERROR'}"/>
<c:set var="isWarning" value="${reportResultCode == 'REVIEW'}"/>
<c:set var="isFinishedWithErrors" value="${reportResultCode == 'FINISHED_WITH_ERRORS'}"/>
<c:set var="isFinishedWithWarnings" value="${reportResultCode == 'FINISHED_WITH_WARNINGS'}"/>

<c:set var="uiIcon">
    <c:choose>
        <c:when test="${isError or isFinishedWithErrors}">Error</c:when>
        <c:when test="${isFinishedWithWarnings}">Warning</c:when>
        <c:when test="${reportStatus == 'NOT_COMPLETE'}">Working</c:when>
        <c:otherwise>Completed</c:otherwise>
    </c:choose>
</c:set>

<span class="UI Icon ${uiIcon}">
    <span class="Text">
        <strong>
            <c:choose>
                <c:when test="${reportStatus == 'COMPLETE'}">
                    <c:set var="completeText">
                        <c:choose>
                            <c:when test="${reportResultCode == 'OK' or reportResultCode == 'ERROR' or
                            reportResultCode == 'FINISHED_WITH_WARNINGS' or reportResultCode == 'FINISHED_WITH_ERRORS'}">
                                <fmt:message key="reportResultCode.${reportResultCode}" bundle="${messages}"/>
                            </c:when>
                            <c:otherwise>
                                ${reportResultCodeLabel}
                            </c:otherwise>
                        </c:choose>
                    </c:set>
                    <syswf:component name="/core/impl/util/artifactLinkRenderer" prefix="reportArtifactLink"
                                     wrap="false">
                        <syswf:param name="uuid" value="${reportUuid}"/>
                        <syswf:param name="caption" value="${completeText}"/>
                    </syswf:component>
                </c:when>
                <c:when test="${reportStatus == 'NOT_COMPLETE'}">
                    ${reportStatus_NOT_COMPLETE}
                    <%--<syswf:component name="/core/report/reportProgress" prefix="progress">
                        <syswf:param name="reportArtifact" value="${reportArtifact}"/>
                    </syswf:component>--%>
                </c:when>
                <c:otherwise>
                    ${reportStatusLabel}
                </c:otherwise>
            </c:choose>
        </strong>
    </span>
</span>