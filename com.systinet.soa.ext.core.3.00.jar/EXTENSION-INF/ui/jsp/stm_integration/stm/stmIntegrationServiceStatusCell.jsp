<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.systinet.platform.ui.integration.stm.StmIntegrationL10n" var="integrationMessages"/>
<fmt:setBundle basename="com.systinet.platform.ui.integration.IntegrationL10n" var="integrationL10n"/>

<syswf:message key="CAP_Defects_Report" var="CAP_Defects_Report" bundle="${integrationMessages}"/>
<syswf:message key="CAP_No_Defects_Def" var="CAP_No_Defects_Def" bundle="${integrationMessages}"/>
<syswf:message key="STR_Defects_Singular" var="STR_Defects_Singular" bundle="${integrationMessages}"/>
<syswf:message key="STR_Defects_Plural" var="STR_Defects_Plural" bundle="${integrationMessages}"/>

<syswf:message key="CAP_ReqCoverage_Report" var="CAP_ReqCoverage_Report" bundle="${integrationMessages}"/>
<syswf:message key="CAP_No_Req_Def" var="CAP_No_Req_Def" bundle="${integrationMessages}"/>
<syswf:message key="STR_Req_Singular" var="STR_Req_Singular" bundle="${integrationMessages}"/>
<syswf:message key="STR_Req_Plural" var="STR_Req_Plural" bundle="${integrationMessages}"/>

<syswf:message key="CAP_Tests_Report" var="CAP_Tests_Report" bundle="${integrationMessages}"/>
<syswf:message key="CAP_No_Tests_Def" var="CAP_No_Tests_Def" bundle="${integrationMessages}"/>
<syswf:message key="STR_Tests_Singular" var="STR_Tests_Singular" bundle="${integrationMessages}"/>
<syswf:message key="STR_Tests_Plural" var="STR_Tests_Plural" bundle="${integrationMessages}"/>
<syswf:message key="MESS_Service_Without_Wsdl" var="MESS_Service_Without_Wsdl" bundle="${integrationMessages}"/>

<%-- <c:set var="stmServiceStatus" value="${almServiceStatusContextInfo.almServiceStatus}"/> --%>
<%--@elvariable id="almServiceStatusContextInfo" type="com.systinet.platform.ui.integration.alm.struct.AlmServiceStatusContextInfo"--%>

<c:choose>
<%-- Firstly check, if processed flag is set to false. If yes, process and propagate Context.
    This flag automatically is set to true inside the logic, when process is finished!
--%>
<c:when test="${almServiceStatusContextInfo.processed == false}">
    <div class="Title">
        <h3><fmt:message key="stm.server.quality.label" bundle="${integrationMessages}"/></h3>
    </div>
    <div id="<c:out value="divReload${prefix}"/>">
            <%-- do AJAX call --%>
        <syswf:control mode="script" action="ajax" formName="ContentForm" caption="Reload${prefix}" affects=".">
            <syswf:param name="artifact" value="${artifact}" />
            <syswf:param name="almServiceStatusContextInfo" value="${almServiceStatusContextInfo}"/>
        </syswf:control>
        <script type="text/javascript">
//<![CDATA[

            manageInterval('<c:out value="Reload${prefix}"/>');
        
//]]>
</script>

        <div class="UI Icon Working">
            <fmt:message key="stm.stmIntegrationServiceStatusCell_checking" bundle="${integrationMessages}"/>
        </div>
    </div>
</c:when>
<c:otherwise>
<%-- AJAX response received, depict --%>
<c:forEach var="stmServer" items="${almServiceStatusContextInfo.almServiceServers}"  varStatus="status">
    <c:set var="defects" value="${stmServer.defectsReport}"/>
    <c:set var="coverage" value="${stmServer.requirementCoverageReport}"/>
    <c:set var="tests" value="${stmServer.testReports}"/>

    <c:if test="${stmServer.statusString != 'SERVICE_MISSING'}">
        <div class="Title">
            <h3><fmt:message key="stm.server.quality.label" bundle="${integrationMessages}"/>
            <c:if test="${not empty stmServer.serverName}">
                <c:out value="(${stmServer.serverName})"/>
            </c:if>
            </h3>
        </div>
        <div class="Content">

        <table class="UI Table Properties">
    </c:if>
    <c:choose>
        <c:when test="${stmServer.statusString == 'OK'}">
            <tr>
                <%-- this part renders requirement coverage report --%>
                <td>
                    <syswf:component name="/integration/ui/common/pieChartComponent" prefix="${status.index}covPieChart">
                        <syswf:param name="sectors" value="${coverage.pieChartSectors}" />
                        <syswf:param name="title">
                            <fmt:message key="stm.server.title.req.coverage" bundle="${integrationMessages}"/> (${coverage.sumValue})
                        </syswf:param>
                        <syswf:param name="height" value="170" />
                    </syswf:component>
                    <c:if test="${not empty coverage.href}">
                        <%-- ToDo: icon is missing --%>
                        <a href="${coverage.href}">
                            <fmt:message key="stm.server.view.in" bundle="${integrationMessages}"/>
                        </a>
                        <br />                        
                    </c:if>
                </td>
                <%-- this part renders defects report --%>
                <td>
                <syswf:component name="/integration/ui/common/pieChartComponent" prefix="${status.index}reqPieChart">
                    <syswf:param name="sectors" value="${defects.pieChartSectors}" />
                    <syswf:param name="title">
                        <fmt:message key="stm.server.title.defects" bundle="${integrationMessages}"/> (${defects.sumValue})
                    </syswf:param>
                    <syswf:param name="height" value="170" />
                </syswf:component>
                <c:if test="${not empty defects.href}">
                    <%-- ToDo: icon is missing --%>
                    <a href="${defects.href}">
                        <fmt:message key="stm.server.view.in" bundle="${integrationMessages}"/>
                    </a>
                    <br />
                </c:if>
                </td>
            </tr>
            <tr>
                <td>
                    <%-- this part renders test report --%>
                     <div class="OffsetTop">
                        <h4 class="Subheader">
                            <fmt:message key="stm.server.title.tests" bundle="${integrationMessages}"/> (${tests.testCount})
                        </h4>
                        <c:if test="${not empty tests.href}">
                            <%-- ToDo: icon is missing --%>
                            <a href="${tests.href}">
                                <fmt:message key="stm.server.view.in" bundle="${integrationMessages}"/>
                            </a>
                        </c:if>
                    </div>
                </td>
            </tr>
        </c:when>
        <c:when test="${stmServer.statusString == 'SERVICE_MISSING'}">
            <%-- do nothing. Servers with missing service should be shown at the end--%>
        </c:when>
        <c:otherwise>
            <c:choose>
                <c:when test="${stmServer.statusString == 'DATA_NOT_AVAILABLE'}">
                    <c:set var="messageKey" value="MESS_Data_Not_Avalable"/>
                </c:when>
                <c:when test="${stmServer.statusString == 'CONNECTIVITY_ERROR'}">
                    <c:set var="messageKey" value="MESS_Connect_Error"/>
                </c:when>
                <c:when test="${stmServer.statusString == 'INTERNAL_ERROR'}">
                    <c:set var="messageKey" value="MESS_Internal_Server_Error"/>
                </c:when>
            </c:choose>
            <div class="UI SystemMessage Error">
                <div class="MessageContainer">
                    <div class="Text"><span class="UI Icon Error"> </span>
                        <fmt:message key="${messageKey}" bundle="${integrationMessages}" />
                        <fmt:message key="checkServerSettings" bundle="${integrationMessages}" />
                    </div>
                    <div class="x-clear"></div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
    <c:if test="${stmServer.statusString != 'SERVICE_MISSING'}">
        </table>
        </div>
    </c:if>

</c:forEach>
<%-- show list of register in links --%>
<c:if test="${! empty almServiceStatusContextInfo.serviceMissingServers}">
	<c:choose>
	    <c:when test="${hasNoWsdlArtifact != null}">
    		<syswf:uimessage type="warning" text="${MESS_Service_Without_Wsdl}"/>
    	</c:when>	
    	<c:otherwise>
    	    <syswf:component name="/integration/stm/servicestatus/servicePublisher" prefix="stmServicePublisher" wrap="false">
        		<syswf:param name="missingServers" value="${almServiceStatusContextInfo.serviceMissingServersWithProperEnvironment}"/>
        		<syswf:param name="serversEnvironments" value="${almServiceStatusContextInfo.serviceMissingServerEnvironments}"/>
		    </syswf:component>
    	</c:otherwise>
    </c:choose>
</c:if>
</c:otherwise>

</c:choose>
