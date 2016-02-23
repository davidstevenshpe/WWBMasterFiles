<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%-- Import the JSTL fmt. --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundles. --%>
<fmt:setBundle basename="com.systinet.platform.ui.integration.stm.StmIntegrationL10n" var="integrationMessages"/>

<c:if test="${not empty missingServers}" >
    <div class="Title"><h3><fmt:message key="stm.server.quality.label" bundle="${integrationMessages}"/></h3></div>
    <div class="Content">
        <i><fmt:message key="stm.server.noDetails" bundle="${integrationMessages}"/></i><br>
        <c:choose>
        <%--ToDo: icon is missing --%>
        <c:when test="${fn:length(missingServers) > 1}">
            <div id="${prefix}RegisterStmBtn" class="MenuButton"/>
            <script type="text/javascript">
//<![CDATA[

                new Ext.Button({
                    renderTo: '${prefix}RegisterStmBtn',
                    arrowAlign: 'right',
                    menu: [
                    <c:forEach var="stmServer" items="${missingServers}" varStatus="status">
                        {text: '${stmServer.serverName}',
                         href: '${stmServer.publishUrl}'}
                        <c:if test="${not status.last}">,</c:if>
                    </c:forEach>
                   ],
                    split: true,
                    text: '<fmt:message key="CAP_Register_STM_select" bundle="${integrationMessages}"/>'
                });
            
//]]>
</script>
        </c:when>
        <c:otherwise>
            <c:forEach var="stmServer" items="${missingServers}">
            <a href="${stmServer.publishUrl}">
                <fmt:message key="CAP_Register_STM" bundle="${integrationMessages}">
                    <fmt:param><syswf:out value="${stmServer.serverName}" context="HtmlBody"/></fmt:param>
                </fmt:message>
            </a>
            </c:forEach>
        </c:otherwise>
        </c:choose>
    </div>
</c:if>

<c:if test="${empty missingServers || not empty serversEnvironments}">
    <div class="Title">
        <h3><fmt:message key="stm.server.quality.label" bundle="${integrationMessages}"/></h3>
    </div>
    <div class="Content">
        <div class="UI SystemMessage Warning">
            <div class="MessageContainer">
                <div class="Text"><span class="UI Icon Warning"> </span>
                    <c:choose>
                        <c:when test="${empty serversEnvironments}">
                            <syswf:message key="stm.server.warning.noStm" bundle="${integrationMessages}" />
                        </c:when>
                        <c:otherwise>
                            <syswf:message key="MESS_Service_No_Proper_Environment" bundle="${integrationMessages}" />
                            <c:out value='${serversEnvironments}'/>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="x-clear"></div>
            </div>
        </div>
    </div>
</c:if>