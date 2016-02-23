<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.report.ui.lifecycle.LifecycleReportMessages" var="messages"/>

<%--@elvariable id="viewModeSelectorModel" type="com.hp.systinet.report.ui.impl.policy.ViewModeSelector.ViewModeSelectorBean"--%>
<%--@elvariable id="bean" type="com.hp.systinet.report.ui.impl.lifecycle.ValidationResultReport.ValidationResultReportBean"--%>
<%--@elvariable id="validationResultsInfo" type="com.hp.systinet.policy.compliance.common.ValidationResultsInfo"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="dataSource" type="com.hp.systinet.sc.datasource.DataSource"--%>


<br/>
<syswf:block className="UI Block Common">
    <div class="Title">
        <div class="UI Align">
        <div class="Left">
            <h3><span><fmt:message key="validationResult.lifecycleCompliance" bundle="${messages}"/></span></h3>

            <i>
                This artifact is involved in an active <syswf:control caption="lifecycle process." mode="anchor" targetTask="${sessionStack.currentTask.taskURI}">
                <syswf:param name="artifactTabId">lifecycle</syswf:param>
            </syswf:control> Here you can review the status of all policy assertions needed to be evaluated so that you
                can advance into new lifecycle stage.
            </i>
            <br/>

            <c:if test="${not empty bean.complianceInPercents}">
                <fmt:message key="validationResult.currentStatus" bundle="${messages}" var="currentStatus">
                    <fmt:param value="${bean.complianceInPercents}"/>
                </fmt:message>
                
                	<br/>
                    <c:choose>
                        <c:when test="${not viewModeSelectorModel.showSources}">
                            <b><span>${currentStatus}</span></b>
                        </c:when>
                        <c:otherwise>
                            <b><fmt:message key="validationResult.issues" bundle="${messages}"/>
                                <small>(${currentStatus})</small></b>
                        </c:otherwise>
                    </c:choose>
                    </c:if>
            </div>
            <c:if test="${bean.enableAnotatedSources}">
                <div class="Right">
                    <syswf:component name="/reports/policy/viewModeSelector" prefix="viewModeSelector">
                        <syswf:param name="modelBean" value="${viewModeSelectorModel}"/>
                        <syswf:param name="componentPrefix" value="${prefix}"/>
                    </syswf:component>
                </div>
            </c:if>
        </div>
        <div class="x-clear"></div>
    </div>
    <div class="Content">
        <%-- if there is no error component displays nothing --%>
        <syswf:component name="/reports/policy/validationErrorMessage" prefix="validationErrorMessage">
            <syswf:param name="validationResultsInfo" value="${validationResultsInfo}"/>
        </syswf:component>
        <c:choose>
            <c:when test="${not viewModeSelectorModel.showSources}">
                <syswf:component name="/core/table" prefix="validationResultTable">
                    <syswf:param name="customizationId" value="reports.lifecycle.validationResultTable"/>
                    <syswf:param name="datasource" value="${dataSource}" />
                    <syswf:param name="showAssertionArtifacts" value="${bean.showAssertionArtifacts}" />
                    <syswf:param name="assertionArtifactTabId" value="compliance" />
                    <syswf:param name="hasExpander" value="${true}"/>
                </syswf:component>
            </c:when>
            <c:otherwise>
                <syswf:component prefix="sources" name="/pm/report/sources/annotatedSourcesPanel">
                    <syswf:param name="info" value="${validationResultsInfo}"/>
                </syswf:component>                
            </c:otherwise>
        </c:choose>
    </div>
</syswf:block>
