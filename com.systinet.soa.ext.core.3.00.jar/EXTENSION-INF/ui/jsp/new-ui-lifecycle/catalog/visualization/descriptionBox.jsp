<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="visualizerState" type="com.hp.systinet.lifecycle.ui.common.visualization.VisualizerStateBean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="reloadFinished" type="java.lang.Boolean"--%>
<%--@elvariable id="descriptionBoxBean" type="com.hp.systinet.lifecycle.ui.catalog.visualization.DescriptionBoxBean"--%>
<%--@elvariable id="flashObjectId" type="java.lang.String"--%>
<%--@elvariable id="artifactLifecycleData" type="com.hp.systinet.lifecycle.ui.common.ArtifactLifecycleData"--%>
<%--@elvariable id="generalUpdateRegions" type="java.util.Set"--%>

<syswf:control id="myAjaxReload" mode="script" caption="reloadBoxFn" action="reload" affects="."/>

<syswf:input id="${prefix}_historyRecordId" name="historyRecordId" value="${visualizerState}"
             property="historyRecordId" mode="hidden" dataType="long"/>
<syswf:input id="${prefix}_stageValue" name="stageValue" value="${visualizerState}"
             property="stageValue" mode="hidden"/>

<script language="JavaScript" type="text/javascript">
//<![CDATA[
    <%-- Receive data from Flex --%>
    function onSelection(historyRecordId, stageValue) {
        Ext.get('${prefix}_historyRecordId').dom.value = (historyRecordId == null) ? '' : historyRecordId;
        Ext.get('${prefix}_stageValue').dom.value = (stageValue == null) ? '' : stageValue;
        reloadBoxFn();
    }

    <%-- Send data to Flex --%>
    function callStageRedrawnFlex(flashObjectId) {
        getFlexApp(flashObjectId).stageRedrawn();
    }

    <%-- Confirm to Flex that description box was redrawn --%>
    <c:if test="${reloadFinished}">
        callStageRedrawnFlex('${flashObjectId}');
    </c:if>
//]]>
</script>

<div class="LifecycleStage ${descriptionBoxBean.descriptionBoxStyleClass}">

    <c:if test="${not descriptionBoxBean.future}">
        <syswf:component prefix="header" name="/newUi/lc/catalog/visualization/headerSection">
            <syswf:param name="artifactUuid" value="${artifactLifecycleData.artifact._uuid}"/>
            <syswf:param name="descriptionBoxBean" value="${descriptionBoxBean}"/>
            <syswf:param name="generalUpdateRegions" value="${generalUpdateRegions}"/>
        </syswf:component>                              
    </c:if>

    <syswf:component prefix="tasks" name="/newUi/lc/catalog/visualization/tasksSection">
        <syswf:param name="runtimeData" value="${descriptionBoxBean.runtimeData.taskData}" passNull="true"/>
        <syswf:param name="status" value="${descriptionBoxBean.runtimeData.status}"/>
        <syswf:param name="present" value="${descriptionBoxBean.present}"/>
        <syswf:param name="definitionData" value="${descriptionBoxBean.definitionData.taskData}"/>
        <syswf:param name="generalUpdateRegions" value="${generalUpdateRegions}"/>
    </syswf:component>

    <syswf:component prefix="policies" name="/newUi/lc/catalog/visualization/policiesSection">
        <syswf:param name="runtimeData" value="${descriptionBoxBean.runtimeData.policyData}" passNull="true"/>
        <syswf:param name="status" value="${descriptionBoxBean.runtimeData.status}"/>
        <syswf:param name="present" value="${descriptionBoxBean.present}"/>
        <syswf:param name="artifactUuid" value="${artifactLifecycleData.artifact._uuid}"/>
        <syswf:param name="definitionData" value="${descriptionBoxBean.definitionData.policyData}"/>
        <syswf:param name="generalUpdateRegions" value="${generalUpdateRegions}"/>
    </syswf:component>

    <syswf:component prefix="approvers" name="/newUi/lc/catalog/visualization/approversSection">
        <c:choose>
            <c:when test="${not empty descriptionBoxBean.runtimeData.approverData.voters}">
                <syswf:param name="definitionData" value="${descriptionBoxBean.runtimeData.approverData.voters}"/>
            </c:when>
            <c:otherwise>
                <syswf:param name="definitionData" value="${descriptionBoxBean.definitionData.approverData}"/>
            </c:otherwise>
        </c:choose>
    </syswf:component>

</div>
