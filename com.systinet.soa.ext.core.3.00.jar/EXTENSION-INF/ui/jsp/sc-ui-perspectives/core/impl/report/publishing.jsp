<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.report.reportMessages" var="reportMessages"/>
<fmt:message var="rollbackReportLinkLabel" key="rollbackReportLinkLabel" bundle="${reportMessages}"/>
<fmt:message var="unknownRequestType" key="unknownRequestType" bundle="${reportMessages}"/>
<fmt:message var="unknownRequestTypeDescription" key="unknownRequestTypeDescription" bundle="${reportMessages}"/>
<fmt:message var="saveCredentialTitle" key="saveCredential" bundle="${reportMessages}"/>


<syswf:component name="/core/report/reportStatus" prefix="reportStatus">
    <syswf:param name="reportArtifact" value="${report}" />
    <syswf:param name="actionComponents" value="${actionComponents}"/>
    <syswf:param name="reportDataTableComponentId" value="${prefix}_table_customized_data"/>
</syswf:component>

<c:if test="${not empty rollbackReportArtifacts}">
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
                            <label class="UI Label Inline">${rollbackReportLinkLabel}</label>
                        </th>
                        <td>
                            <c:forEach items="${rollbackReportArtifacts}" var="rollbackReportArtifact" varStatus="status">
                                <syswf:control mode="anchor" caption="${rollbackReportArtifact.name}" targetTask="/artifact/${rollbackReportArtifact._uuid}" id="rollbackReportArtifact${status.index}" wrapper="span" targetDepth="0">
                                    <syswf:attribute name="class" value="UI Icon Report"/>
                                </syswf:control>
                                <c:if test="${not status.last}">,</c:if>
                            </c:forEach>
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
        <syswf:param name="statisticsBeanId" value="ui-sc-perspectives.PublishingReportStatistic" />
    </syswf:component>
</c:if>

<c:choose>
    <c:when test="${waitingForUserInput}">
        <c:choose>
            <c:when test="${requestType eq 'collision'}">
                <syswf:component name="/core/impl/imports/collisionsResolution" prefix="collisions">
                    <syswf:param name="reportArtifact" value="${report}" />
                </syswf:component>
            </c:when>
            <c:when test="${requestType eq 'duplicate'}">
                <syswf:component name="/core/impl/imports/duplicatesResolution" prefix="duplicates">
                    <syswf:param name="reportArtifact" value="${report}" />
                </syswf:component>
            </c:when>
            <c:when test="${requestType eq 'wsdlPublishing'}">
                <syswf:component name="/core/impl/imports/wsdlPublishingResolution" prefix="wsdlPublishing">
                    <syswf:param name="reportArtifact" value="${report}" />
                </syswf:component>
            </c:when>
            <c:otherwise>
                <syswf:block className="UI Block Common Publishing">               
                    <div class="Title">
                        <h3>${unknownRequestType}</h3>
                    </div>
                    <div class="Content">
                        <p class="Comment">${unknownRequestTypeDescription}</p>
                    </div>                
                </syswf:block>
            </c:otherwise>
        </c:choose>     
    </c:when>
    <c:otherwise>
        <syswf:block className="UI Block Common">
            <syswf:component name="/core/credstore/editCredential" prefix="saveCredential">
                <syswf:param name="openDialogFunction" value="__openCredStoreDialog" /> 
                <syswf:param name="winTitle" value="${saveCredentialTitle}" />
            </syswf:component>
            
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
    </c:otherwise>
</c:choose>