<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="artifactLifecycleData" type="com.hp.systinet.lifecycle.ui.common.ArtifactLifecycleData"--%>
<%--@elvariable id="artifactUuid" type="com.hp.systinet.repository.sdm.properties.Uuid"--%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="bundle"/>

<c:if test="${artifactLifecycleData.inLastRevision && not artifact._deleted}">
    
        <div class="Content">
            <c:choose>
                <c:when test="${artifactLifecycleData.governed}">
                    <c:choose>
                        <c:when test="${artifactLifecycleData.root}">
                            <%-- Request Approval --%>
                            <syswf:component name="/newUi/lc/catalog/button/requestApprovalButton" prefix="lifecycleTab.requestApproval">
                                <syswf:param name="uuid" value="${artifactUuid}"/>
                                <syswf:param name="artifactLifecycleData" value="${artifactLifecycleData}"/>
                                <syswf:param name="insideTaskBox" value="false"/>
                            </syswf:component>
                            <%-- Notify Approvers --%>
                            <syswf:component name="/newUi/lc/catalog/button/notifyApproversButton" prefix="lifecycleTab.notifyApprovers">
                                <syswf:param name="uuid" value="${artifactUuid}"/>
                                <syswf:param name="artifactLifecycleData" value="${artifactLifecycleData}"/>
                            </syswf:component>
                            <%-- Cancel Approval --%>
                            <syswf:component name="/newUi/lc/catalog/button/cancelApprovalButton" prefix="lifecycleTab.cancelApproval">
                                <syswf:param name="uuid" value="${artifactUuid}"/>
                                <syswf:param name="artifactLifecycleData" value="${artifactLifecycleData}"/>
                                <syswf:param name="insideTaskBox" value="false"/>
                            </syswf:component>
                            <%-- Move To --%>
                            <c:if test="${!(artifactLifecycleData.governanceRecord.lfcStatus eq 'VOTING')}">
                                <syswf:component name="/newUi/lc/catalog/button/moveToButton" prefix="lifecycleTab.moveTo">
                                    <syswf:param name="uuid" value="${artifactUuid}"/>
                                    <syswf:param name="artifactLifecycleData" value="${artifactLifecycleData}"/>
                                </syswf:component>
                            </c:if>
                            <%-- View Changes --%>
                            <syswf:component name="/newUi/lc/catalog/button/viewChangesButton" prefix="lifecycleTab.viewChanges">
                                <syswf:param name="uuid" value="${artifactUuid}"/>
                                <syswf:param name="artifactLifecycleData" value="${artifactLifecycleData}"/>
                            </syswf:component>
                            <c:if test="${!(artifactLifecycleData.governanceRecord.lfcStatus eq 'VOTING')}">
                                <%-- Set Process --%>
                                <syswf:component name="/newUi/lc/catalog/button/setProcessButton" prefix="lifecycleTab.setProcess">
                                    <syswf:param name="uuid" value="${artifactUuid}"/>
                                </syswf:component>
                            </c:if>
                            <%-- End Governance--%>
                            <syswf:component name="/newUi/lc/catalog/button/endGovernanceButton"
                                     prefix="lifecycleTab.endGovernance">
                                <syswf:param name="uuid" value="${artifactUuid}"/>
                                <syswf:param name="artifactLifecycleData" value="${artifactLifecycleData}"/>
                            </syswf:component>
                            <%-- History --%>
                            <syswf:component name="/newUi/lc/catalog/button/historyButton"
                                     prefix="lifecycleTab.history">
                                <syswf:param name="uuid" value="${artifactUuid}"/>
                            </syswf:component>
                        </c:when>
                        <c:otherwise>
                            <%-- TODO simon: replace icon if ready --%>
                            <fmt:message var="linkTitle" key="lftab_button_viewRootArtifact" bundle="${bundle}"/>
                            <syswf:control mode="anchor" targetTask="/artifact/${artifactLifecycleData.rootArtifactUuid}" caption="${linkTitle}">
                                <syswf:param name="tabId" value="lifecycle"/>
                                <syswf:attribute name="class" value="UI PageAction GoUp"/>
                            </syswf:control>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <syswf:component name="/newUi/lc/catalog/button/startGovernanceButton" prefix="lifecycleTab.startGovernance">
                        <syswf:param name="uuid" value="${artifactUuid}"/>
                    </syswf:component>
                </c:otherwise>

            </c:choose>
       </div>
</c:if>