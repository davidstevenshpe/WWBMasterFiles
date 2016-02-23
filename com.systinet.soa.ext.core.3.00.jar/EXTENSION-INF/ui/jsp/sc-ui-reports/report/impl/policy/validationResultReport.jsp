<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="messages"/>

<%--@elvariable id="viewModeSelectorModel" type="com.hp.systinet.policy.ui.compliance.ViewModeSelector.ViewModeSelectorBean"--%>
<%--@elvariable id="validationResultsInfo" type="com.hp.systinet.policy.compliance.common.ValidationResultsInfo"--%>
<%--@elvariable id="bean" type="com.hp.systinet.report.ui.impl.policy.ValidationResultReport.ValidationResultReportBean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="dataSource" type="com.hp.systinet.sc.datasource.DataSource"--%>

<br/>
<syswf:block className="UI Block Common">
    <div class="Title">
        <div class="UI Align">
            <c:if test="${not empty bean.artifactName}">
                <div class="Left">
                    <h3><span><c:out value="${bean.artifactName}"/></span></h3>
                </div>
            </c:if>
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
        <br/>
        <c:choose>
            <c:when test="${not viewModeSelectorModel.showSources}">
                <syswf:component name="/core/table" prefix="validationResultTable">
                    <syswf:param name="customizationId" value="reports.policy.validationResultTable"/>
                    <syswf:param name="datasource" value="${dataSource}" />
                    <syswf:param name="showAssertionArtifacts" value="${bean.showAssertionArtifacts}" />
                    <syswf:param name="assertionArtifactTabId" value="overview" />
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
