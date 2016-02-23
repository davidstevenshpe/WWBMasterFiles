<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:component name="/core/report/reportStatus" prefix="reportStatus">
    <syswf:param name="reportArtifact" value="${artifact}" />
</syswf:component>

<c:if test="${reportStatus ne 'NOT_COMPLETE'}">    
    <syswf:component name="/core/report/reportStatistics" prefix="stat">
        <syswf:param name="report" value="${report}" />
        <syswf:param name="rowClazz" value="com.hp.systinet.repository.exportimport.progress.ReportProgressInfo" />
        <syswf:param name="statisticsBeanId" value="ui-sc-components.ImportExportReportStatistics" />
    </syswf:component>
</c:if>

<syswf:block className="UI Block Common">
    <syswf:component name="/core/table" prefix="table">
        <syswf:param name="customizationId" value="shared.viewArtifact.reportArtifact.properties.exportReport"/>
        <syswf:param name="artifact" value="${report}"/>
        <c:choose>
            <c:when test="${reportStatus eq 'NOT_COMPLETE'}">
                <syswf:param name="overrideFilter" value="none"/>
            </c:when>
            <c:otherwise>
                <syswf:param name="overrideFilter" value="auto"/>
            </c:otherwise>
        </c:choose>
    </syswf:component>
</syswf:block>