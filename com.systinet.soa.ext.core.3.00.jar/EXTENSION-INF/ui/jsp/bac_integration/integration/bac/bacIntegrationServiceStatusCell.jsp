<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="globalSession" type="java.util.Map"--%>
<%--@elvariable id="bacServiceStatusContextInfo" type="com.systinet.platform.ui.bacintegration.struct.BacServiceStatusContextInfo"--%>
<%--@elvariable id="artifact" type="com.hp.systinet.repository.sdm.ArtifactBase"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="bacServiceStatusLink" type="java.lang.String"--%>
<%--@elvariable id="bacDataTypeValues" type="java.awt.List<java.lang.String>"--%>
<%--@elvariable id="bacDataTypeCaptions" type="java.awt.List<java.lang.String>"--%>
<%--@elvariable id="bacDataRangeValues" type="java.awt.List<java.lang.String>"--%>
<%--@elvariable id="bacDataRangeCaptions" type="java.awt.List<java.lang.String>"--%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>
<fmt:setBundle basename="com.systinet.platform.ui.bacintegration.BacIntegrationUiL10n" var="bacIntegrationUiL10n"/>
<fmt:setBundle basename="com.systinet.platform.ui.integration.IntegrationL10n" var="integrationL10n"/>
<fmt:setBundle basename="com.systinet.platform.ui.bacintegration.BacIntegrationL10n" var="BacIntegrationL10n"/>

<c:set var="bacServiceStatus" value="${bacServiceStatusContextInfo.bacServiceStatus}"/>

<fmt:message key="bac.bacIntegrationServiceStatusCell_reload" var="reload" bundle="${bacIntegrationUiL10n}"/>
<syswf:control mode="script" action="ajax" formName="ContentForm" caption="Reload${prefix}" affects=".">
    <syswf:param name="artifact" value="${artifact}"/>
    <syswf:param name="bacServiceStatusContextInfo" value="${bacServiceStatusContextInfo}"/>
</syswf:control>

<fmt:message var="areaCaption" key="bac.bacIntegrationServiceStatus_perform" bundle="${bacIntegrationUiL10n}"/>
<syswf:block className="UI Block Common">
    <div class="Title">
        <h3><syswf:out value="${areaCaption}" context="HtmlBody"/> (<syswf:out value="${bacServiceStatusContextInfo.bacServerName}" context="HtmlBody"/>)</h3>
    </div>
    <div class="Content">
        <c:choose>
            <c:when test="${bacServiceStatus == null}">
                <div id="<c:out value="divReload${prefix}"/>">
                        <%-- do AJAX call --%>
                    <script type="text/javascript">
                        //<![CDATA[

                        manageInterval('<c:out value="Reload${prefix}"/>');
                        //]]>
                    </script>

	    	  <span class="UI Icon Working">
                  <fmt:message key="bac.bacIntegrationServiceStatusCell_checking" bundle="${bacIntegrationUiL10n}"/>
              </span>
                </div>
            </c:when>

            <c:otherwise>
                <%-- AJAX response received, depict --%>
                <fmt:message var="ok_status" key="MESSAGE_Stat_OK" bundle="${BacIntegrationL10n}"/>
                <c:choose>
                    <c:when test="${bacServiceStatus.generalStatus ne ok_status}">
                        <c:choose>
                            <c:when test="${bacServiceStatus.errorType eq 'error'}">
                                <c:set var="serverArtifactLink">
                                    <syswf:control mode="anchor" caption="${bacServiceStatusContextInfo.bacServerName}"
                                                   targetTask="/artifact/${bacServiceStatusContextInfo.bacServerArtifactUuid}"/>
                                </c:set>

                                <fmt:message key="checkServerSettings" var="checkServerSettings"
                                             bundle="${integrationL10n}">
                                    <fmt:param value="${serverArtifactLink}"/>
                                </fmt:message>
                                <div class="UI SystemMessage ${bacServiceStatus.errorType}">
                                    <div class="MessageContainer">
                                        <div class="Text"><span class="UI Icon ${bacServiceStatus.errorType}"> </span>
                                            <syswf:out value="${bacServiceStatus.generalStatus}" context="HtmlBody"/> <syswf:out value="${checkServerSettings}" context="HtmlBody"/>
                                        </div>
                                        <div class="x-clear"></div>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="UI SystemMessage ${bacServiceStatus.errorType}">
                                    <div class="MessageContainer">
                                        <div class="Text"><span class="UI Icon ${bacServiceStatus.errorType}"> </span>
                                            <syswf:out value="${bacServiceStatus.generalStatus}" context="HtmlBody"/>
                                        </div>
                                        <div class="x-clear"></div>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <div id="<c:out value="divReload${prefix}"/>">

                            <div>
                                <table class="UI Table Properties">
                                    <colgroup>
                                        <col class="MidLabelCol"/>
                                        <col/>
                                    </colgroup>
                                    <tbody>
                                    <c:forEach var="metricItem" items="${bacServiceStatus.metrics}">
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
                            </div>
                            <hr/>
                            <fmt:message key="bac.bacIntegrationServiceStatusCell_dataRangeLabel"
                                         bundle="${bacIntegrationUiL10n}"/>
                            <syswf:selectOne id="${prefix}bacDataType" name="bacDataType" mode="menu"
                                             optionValues="${bacDataTypeValues}"
                                             optionCaptions="${bacDataTypeCaptions}"
                                             value="${bacServiceStatusContextInfo}" property="dataType">
                                <syswf:attribute name="onChange" value="${reload}${prefix}()"/>
                            </syswf:selectOne>
                            from
                            <syswf:selectOne id="${prefix}bacDataRange" name="bacDataRange" mode="menu"
                                             optionValues="${bacDataRangeValues}"
                                             optionCaptions="${bacDataRangeCaptions}"
                                             value="${bacServiceStatusContextInfo}" property="dataRange">
                                <syswf:attribute name="onChange" value="${reload}${prefix}()"/>
                                <syswf:attribute name="class" value="mediumText"/>
                            </syswf:selectOne>
                            <fmt:message key="bac.bacIntegrationServiceStatusCell_altLinkHealthReport"
                                         var="altLinkHealthReport" bundle="${bacIntegrationUiL10n}"/>
                            |
                            <a class="shrNewWindow" title="${altLinkHealthReport}"
                               href="<c:out value='${bacServiceStatusLink}'/>" target="_new">
                                <fmt:message key="bac.bacIntegrationServiceStatusCell_viewService"
                                             bundle="${bacIntegrationUiL10n}"/>
                            </a>

                        </div>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </div>
</syswf:block>

