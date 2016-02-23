<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />
</c:if>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n"/>

<c:set var="serverLink">
    <syswf:component name="/integration2/uddi/report/uddiServerLinkWidget" prefix="serverLink">
        <syswf:param name="registryBean" value="${registryBean}" />
    </syswf:component>
</c:set>
<syswf:component name="/core/report/reportStatus" prefix="reportStatus">
    <syswf:param name="reportArtifact" value="${report}" />
    <syswf:param name="actionComponents" value="${actionComponents}"/>
    <syswf:param name="serverLink" value="${serverLink}" />
</syswf:component>

<c:choose> 
    <c:when test="${waitingForUserInput}">
        <c:choose>
            <c:when test="${requestType eq 'missingTaxonomies'}">
                <syswf:component name="/integration/uddi/report/missingTaxonomies" prefix="missingTaxonomies">
                    <syswf:param name="reportArtifact" value="${report}" />
                </syswf:component>
            </c:when>
            <c:otherwise>
                <syswf:block className="UI Block Common Publishing">               
                    <div class="Title">
                        <h3><fmt:message key="uddi.report.uddiIntegrationReport.unknown_report_type" bundle="${l10n}"/></h3>
                    </div>
                    <div class="Content">
                        <p class="Comment"><fmt:message key="uddi.report.uddiIntegrationReport.unknown_report_type" bundle="${l10n}"/></p>
                    </div>                
                </syswf:block>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <syswf:block className="UI Block Common">
            <fmt:message var="saveCredentialTitle" key="uddi.report.saveCredentialTitle" bundle="${l10n}"/>
            <syswf:component name="/core/credstore/editCredential" prefix="addCredential">
                <syswf:param name="openDialogFunction" value="__openCredStoreDialog" /> 
                <syswf:param name="winTitle" value="${saveCredentialTitle}" />
            </syswf:component>
	        <div class="webfw-Window" id="${prefix}-webfw-Window">                
	            <syswf:component name="/core/table" prefix="table">
	                <syswf:param name="customizationId" value="integration.uddi.report.properties.uddiImportReport"/>
	                <syswf:param name="artifact" value="${report}"/>
	                <syswf:param name="registryBean" value="${registryBean}"/>
                    <c:choose>
                        <c:when test="${reportStatus eq 'NOT_COMPLETE'}">
                            <syswf:param name="overrideFilter" value="none"/>
                        </c:when>
                        <c:otherwise>
                            <syswf:param name="overrideFilter" value="auto"/>
                        </c:otherwise>
                    </c:choose>
	            </syswf:component>
	        </div>
        </syswf:block>
    </c:otherwise>
</c:choose>