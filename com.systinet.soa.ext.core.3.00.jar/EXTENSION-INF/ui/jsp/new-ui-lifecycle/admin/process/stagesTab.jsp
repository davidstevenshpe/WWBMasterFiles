<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="process" type="com.hp.systinet.platform.lifecycle.GovernanceProcess"--%>
<%--@elvariable id="visualizerState" type="com.hp.systinet.lifecycle.ui.common.visualization.VisualizerStateBean"--%>
<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<c:set var="flashFileNameWoSuffix" value="process-visualization"/>
<%-- Right Panel with Actions --%>
<div class="UI Block Container">
<syswf:component name="/newUi/lc/admin/process/rightPanel" prefix="contextButton"/>            
    <c:choose>
        <c:when test="${empty process.states}">
            <div class="Paragraph Tip">
                <p><fmt:message key="processTabStages.emptyProcessMessage" bundle="${messages}"/><br/><br/></p>
            </div>
            
        </c:when>
        <c:otherwise>
                <%-- Flex Visualization --%>
                <syswf:component name="/newUi/lc/common/visualization/visualizer" prefix="visualizer">
                    <syswf:param name="flashFileNameWoSuffix" value="process-visualization"/>
                    <syswf:param name="processUuid" value="${process.baseUuid}"/>
                    <syswf:param name="visualizerState" value="${visualizerState}"/>
                </syswf:component>

                <%-- Green Panel Under Flex --%>
                <syswf:component name="/newUi/lc/admin/visualization/processDescriptionBox"
                                 prefix="description">
                    <syswf:param name="flashObjectId" value="${flashFileNameWoSuffix}"/>
                    <syswf:param name="visualizerState" value="${visualizerState}"/>
                </syswf:component>
        </c:otherwise>
    </c:choose>
</div>