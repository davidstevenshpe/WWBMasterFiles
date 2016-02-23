<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--@elvariable id="visualizerState" type="com.hp.systinet.lifecycle.ui.common.visualization.VisualizerStateBean"--%>
<%--@elvariable id="artifactLifecycleData" type="com.hp.systinet.lifecycle.ui.common.ArtifactLifecycleData"--%>
<%--@elvariable id="canStartGovernance" type="java.lang.Boolean"--%>
<%--@elvariable id="hasDefaultProcess" type="java.lang.Boolean"--%>
<%--@elvariable id="generalUpdateRegions" type="java.util.Set"--%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>

<c:set var="flashFileNameWoSuffix" value="process-visualization"/>

<c:choose>
    <c:when test="${artifactLifecycleData.governed and artifactLifecycleData.underSameProcessSinceRevision}">
        <div class="OffsetLeft OffsetTop">
            <syswf:component name="/newUi/lc/common/visualization/visualizer" prefix="visualizer">
                <syswf:param name="flashFileNameWoSuffix" value="${flashFileNameWoSuffix}"/>
                <syswf:param name="artifactUuid" value="${artifactLifecycleData.artifactUuidStr}"/>
                <syswf:param name="visualizerState" value="${visualizerState}"/>
                <syswf:param name="processUuid" value="${artifactLifecycleData.governanceProcessUuidStr}"/>
                <syswf:param name="processName" value="${artifactLifecycleData.governanceProcess.name}"/>
                <c:if test="${not artifactLifecycleData.inLastRevision}">
                    <syswf:param name="revision" value="${artifactLifecycleData.revision}"/>
                </c:if>
                <syswf:param name="interactive"
                             value="${artifactLifecycleData.inLastRevision and artifactLifecycleData.root}"/>
                <syswf:param name="showRule"
                             value="${artifactLifecycleData.inLastRevision and artifactLifecycleData.root}"/>
            </syswf:component>

            <c:choose>
                <c:when test="${artifactLifecycleData.inLastRevision and artifactLifecycleData.root}">
                    <syswf:component name="/newUi/lc/catalog/visualization/descriptionBox" prefix="description">
                        <syswf:param name="flashObjectId" value="${flashFileNameWoSuffix}"/>
                        <syswf:param name="artifactLifecycleData" value="${artifactLifecycleData}"/>
                        <syswf:param name="visualizerState" value="${visualizerState}"/>
                        <syswf:param name="generalUpdateRegions" value="${generalUpdateRegions}"/>
                    </syswf:component>
                </c:when>
                <c:when test="${artifactLifecycleData.inLastRevision and not artifactLifecycleData.root}">
                    <%-- Show info message with link to root artifact --%>
                    <fmt:message var="infoMsgLink" key="lftab_info_goToRootArtifact_link" bundle="${bundle}"/>
                    <fmt:message var="infoMsg" key="lftab_info_goToRootArtifact_msg" bundle="${bundle}">
                        <fmt:param>
                            <syswf:control mode="anchor"
                                           targetTask="/artifact/${artifactLifecycleData.rootArtifactUuid}"
                                           caption="${infoMsgLink}">
                                <syswf:param name="tabId" value="lifecycle"/>
                            </syswf:control>
                        </fmt:param>
                    </fmt:message>
                    <div class="Content">
                        <syswf:component name="/newUi/lc/common/widget/infoMessage" prefix="info">
                            <syswf:param name="message"><c:out value="${infoMsg}" escapeXml="false" /></syswf:param>
                        </syswf:component>
                    </div>
                </c:when>
                <c:otherwise>
                    <%-- Show info message with link to latest revision --%>
                    <fmt:message var="infoMsgLink" key="lftab_info_goToLastRevision_link" bundle="${bundle}"/>
                    <fmt:message var="infoMsg" key="lftab_info_goToLastRevision_msg" bundle="${bundle}">
                        <fmt:param>
                            <syswf:control mode="anchor" targetTask="/artifact/${artifactLifecycleData.artifactUuidStr}"
                                           caption="${infoMsgLink}">
                                <syswf:param name="tabId" value="lifecycle"/>
                            </syswf:control>
                        </fmt:param>
                    </fmt:message>
                    <div class="Content">
                        <syswf:component name="/newUi/lc/common/widget/infoMessage" prefix="info">
                            <syswf:param name="message"><c:out value="${infoMsg}" escapeXml="false" /></syswf:param>
                        </syswf:component>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </c:when>
    <c:when test="${artifactLifecycleData.governed and not artifactLifecycleData.underSameProcessSinceRevision}">
        <div class="Content">
            <syswf:component name="/newUi/lc/common/widget/infoMessage" prefix="info">
                <syswf:param name="message"><fmt:message key="lftab_info_notUnderSameProcess"
                                                         bundle="${bundle}"/></syswf:param>
            </syswf:component>
        </div>
    </c:when>
    <c:when test="${not artifactLifecycleData.governed and artifactLifecycleData.governedInRevision}">
        <div class="Content">
            <syswf:component name="/newUi/lc/common/widget/infoMessage" prefix="info">
                <syswf:param name="message"><fmt:message key="lftab_info_governedInRevision"
                                                         bundle="${bundle}"/></syswf:param>
            </syswf:component>
        </div>
    </c:when>
    <c:when test="${not artifactLifecycleData.governed and not artifactLifecycleData.inLastRevision}">
        <div class="Content">
            <syswf:component name="/newUi/lc/common/widget/infoMessage" prefix="info">
                <syswf:param name="message"><fmt:message key="lftab_info_nonGovernedInRevision"
                                                         bundle="${bundle}"/></syswf:param>
            </syswf:component>
        </div>
    </c:when>
    <c:otherwise>
        <%-- Show info message with link to start governance --%>
        <fmt:message var="infoMsgLink" key="lftab_info_startGovernance_link" bundle="${bundle}"/>
        <fmt:message var="infoMsg" key="lftab_info_startGovernance_msg" bundle="${bundle}"/>
        <c:if test="${canStartGovernance}">
            <fmt:message var="infoMsg2" key="lftab_info_startGovernance_msg_link" bundle="${bundle}">
                <fmt:param>
                    <a id="infoMsgStartGovLink" href="javascript:void(0);"><c:out value="${infoMsgLink}"/></a>
                </fmt:param>
            </fmt:message>
        </c:if>
        <div class="Content">
            <syswf:component name="/newUi/lc/common/widget/infoMessage" prefix="info">
                <syswf:param name="message">
                    <c:out value="${infoMsg}" escapeXml="false" />
                    <c:if test="${canStartGovernance}">
                        <c:out value=" ${infoMsg2}" escapeXml="false" />
                    </c:if>
                </syswf:param>
            </syswf:component>
            <c:if test="${canStartGovernance}">
            <%-- Important: we reference the link in startGovernanceButton.jsp --%>
            <script type="text/javascript">
//<![CDATA[

                attachOn('infoMsgStartGovLink','click',function() {
                    <c:if test="${not hasDefaultProcess}">
                        StartGovernance_open();
                        StartGovernance_enableOk();
                    </c:if>
                    <c:if test="${hasDefaultProcess}">
                        startDefaultGovernancePost();
                    </c:if>
                });
            
//]]>
</script>
            </c:if>
        </div>
    </c:otherwise>
</c:choose>
