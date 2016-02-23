<%--
  ~ (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
  --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="globalSession" type="java.util.Map"--%>
<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.ArtifactBase"--%>
<%--@elvariable id="isSoamSynchronizable" type="java.lang.String"--%>
<%--@elvariable id="soamServiceStatusContextInfo" type="com.systinet.platform.ui.integration.soam.struct.SoamServiceStatusContexInfo"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.systinet.platform.ui.integration.soam.SoamIntegrationL10n" var="integrationMessages"/>
<fmt:setBundle basename="com.systinet.platform.ui.integration.IntegrationL10n" var="integrationL10n"/>

<c:set var="soamServiceStatus" value="${soamServiceStatusContextInfo.soamServiceStatus}"/>
<c:set var="soamServiceUrl" value="${soamServiceStatusContextInfo.soamServiceUrl}"/>

<fmt:message var="areaCaption" key="performanceAndAvailability_section_caption" bundle="${integrationL10n}"/>
<syswf:block className="UI Block Common">
    <div class="Title">
        <h3><syswf:out value="${areaCaption}" context="HtmlBody"/> (<syswf:out value="${soamServiceStatusContextInfo.soamServerName}" context="HtmlBody"/>)</h3>
    </div>
    <div class="Content">
        <c:choose>
            <c:when test="${soamServiceStatus == null}">

                <div id="<c:out value="divReload${prefix}"/>">
                        <%-- do AJAX call --%>
                    <syswf:control mode="script" action="ajax" formName="ContentForm" caption="Reload${prefix}"
                                   affects=".">
                        <syswf:param name="artifact" value="${artifact}"/>
                        <syswf:param name="soamServiceStatusContextInfo" value="${soamServiceStatusContextInfo}"/>
                    </syswf:control>
                    <script type="text/javascript">
                    //<![CDATA[

                        manageInterval('<c:out value="Reload${prefix}"/>');
                    
                    //]]>
                    </script>

            <span class="UI Icon Working">
                <fmt:message key="soam.soamIntegrationServiceStatusCell_checking" bundle="${integrationMessages}"/>
            </span>
                </div>

            </c:when>

            <c:otherwise>

                <%-- AJAX response received, depict --%>
                <c:choose>
                    <c:when test="${soamServiceStatus.error}">
                        <%-- error with connectivity, show link to server artifact --%>
                        <c:choose>
                            <c:when test="${soamServiceStatus.errorType eq 'Error'}">
                                <c:set var="serverArtifactLink">
                                    <syswf:control mode="anchor"
                                                   caption="${soamServiceStatusContextInfo.soamServerName}"
                                                   targetTask="/artifact/${soamServiceStatusContextInfo.soamServerArtifactUuid}"/>
                                </c:set>

                                <fmt:message key="checkServerSettings" var="checkServerSettings"
                                             bundle="${integrationL10n}">
                                    <fmt:param value="${serverArtifactLink}"/>
                                </fmt:message>
                                <div class="UI SystemMessage ${soamServiceStatus.errorType}">
                                    <div class="MessageContainer">
                                        <div class="Text"><span class="UI Icon ${soamServiceStatus.errorType}"> </span>
                                            <syswf:out value="${soamServiceStatus}" context="HtmlBody"/> <syswf:out value="${checkServerSettings}" context="HtmlBody"/>
                                        </div>
                                        <div class="x-clear"></div>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="UI SystemMessage ${soamServiceStatus.errorType}">
                                    <div class="MessageContainer">
                                        <div class="Text"><span class="UI Icon ${soamServiceStatus.errorType}"> </span>
                                            <syswf:out value="${soamServiceStatus}" context="HtmlBody"/>
                                        </div>
                                        <div class="x-clear"></div>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${not empty soamServiceStatus.metrics}">
                            <table class="UI Table Properties">
                                <colgroup>
                                    <col class="LongLabelCol"/>
                                    <col/>
                                </colgroup>
                                <tbody>
                                <c:forEach var="metricItem" items="${soamServiceStatus.metrics}">
                                    <tr>
                                        <th>
                                            <label class="UI Label Inline"><c:out
                                                    value='${metricItem.caption}'/>:</label>
                                        </th>
                                        <td>
                                            <c:out value='${metricItem.value}'/>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                        <a class="shrNewWindow" href="<c:out value='${soamServiceUrl}'/>" target="_new"><fmt:message
                                key="soam.soamIntegrationServiceStatus_soamServiceView"
                                bundle="${integrationMessages}"/></a>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </div>
</syswf:block>
