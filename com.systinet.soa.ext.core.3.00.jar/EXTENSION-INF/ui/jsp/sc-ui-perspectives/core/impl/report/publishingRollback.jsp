<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.report.reportMessages" var="reportMessages"/>
<fmt:message var="publishingReportLinkLabel" key="publishingReportLinkLabel" bundle="${reportMessages}"/>
<fmt:message var="singleArtifact" key="singleArtifact" bundle="${reportMessages}"/>
<fmt:message var="multipleArtifacts" key="multipleArtifacts" bundle="${reportMessages}"/>

<syswf:component name="/core/report/reportStatus" prefix="reportStatus">
    <syswf:param name="reportArtifact" value="${report}" />
    <syswf:param name="reportDataTableComponentId" value="${prefix}_table_customized_data"/>
</syswf:component>

<c:if test="${not empty publishingReportArtifact}">
    <syswf:block className="UI Block Common">
        <div class="Content">
            <table class="UI Table Properties">
                <thead>
                    <col class="LabelCol" />
                    <col />
                </thead>
                <tbody>
                    <tr>
                        <th>
                            <label class="UI Label Inline">${publishingReportLinkLabel}</label>
                        </th>
                        <td>
                            <syswf:control mode="anchor" caption="${publishingReportArtifact.name}" targetTask="/artifact/${publishingReportArtifact._uuid}" id="publishingReportArtifact" wrapper="span" targetDepth="0">
                                <syswf:attribute name="class" value="UI Icon Report"/>       
                            </syswf:control>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </syswf:block>    
</c:if>

<c:if test="${reportStatus ne 'NOT_COMPLETE'}">
    <syswf:component name="/core/report/reportStatistics" prefix="stat">
        <syswf:param name="report" value="${report}" />
        <syswf:param name="rowClazz" value="com.hp.systinet.publishing.report.PublishingReportItem" />
        <syswf:param name="statisticsBeanId" value="ui-sc-perspectives.PublishingRollbackReportStatistic" />
    </syswf:component>
</c:if>

<syswf:block className="UI Block Common">
    <syswf:component name="/core/table" prefix="table">
        <syswf:param name="customizationId" value="shared.viewArtifact.reportArtifact.properties.publishingReport"/>
        <syswf:param name="artifact" value="${report}"/>
        <c:choose>
            <c:when test="${reportStatus eq 'NOT_COMPLETE'}">
                <syswf:param name="overrideselectionModel" value="none"/>
                <syswf:param name="disableExports" value="${true}"/>
                <syswf:param name="overrideFilter" value="none"/>
            </c:when>
            <c:otherwise>
                <syswf:param name="disableExports" value="${false}"/>
                <syswf:param name="overrideFilter" value="auto"/>
            </c:otherwise>
        </c:choose>
    </syswf:component>
</syswf:block>