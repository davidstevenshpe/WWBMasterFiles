<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%-- COMPONENT PARAMETERS: --%>
<%--@elvariable id="process" type="com.hp.systinet.platform.lifecycle.GovernanceProcess"--%>
<%--@elvariable id="flashObjectId" type="java.lang.String"--%>
<%--@elvariable id="visualizerState" type="com.hp.systinet.lifecycle.ui.common.visualization.VisualizerStateBean"--%>
<%--@elvariable id="descriptionBoxBean" type="com.hp.systinet.lifecycle.ui.admin.visualization.ProcessDescriptionBoxBean"--%>
<%-- OTHER: --%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<syswf:control id="myAjaxReload" mode="script" caption="reloadBoxFn" action="reload" affects="." loadingMask="true"/>

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
    <%-- Tasks --%>
    <syswf:component name="/newUi/lc/admin/visualization/tasksSection" prefix="tasks">
        <syswf:param name="processUuid" value="${process.baseUuid}"/>
        <syswf:param name="visualizerState" value="${visualizerState}"/>
        <syswf:param name="descriptionBoxBean" value="${descriptionBoxBean}"/>
    </syswf:component>
    <%-- Policies --%>
    <syswf:component name="/newUi/lc/admin/visualization/policiesSection" prefix="policies">
        <syswf:param name="descriptionBoxBean" value="${descriptionBoxBean}"/>        
    </syswf:component>
    
    <%-- Approvers --%>
    <syswf:component name="/newUi/lc/admin/visualization/approversSection" prefix="approvers">
        <syswf:param name="process" value="${process}"/>
        <syswf:param name="descriptionBoxBean" value="${descriptionBoxBean}"/>
    </syswf:component>

    <%-- Aautomatic Actions --%>
    <syswf:component prefix="automaticActions" name="/newUi/lc/admin/automaticaction/automaticActionsSection">
        <syswf:param name="descriptionBoxBean" value="${descriptionBoxBean}"/>
        <syswf:param name="visualizerState" value="${visualizerState}"/>
    </syswf:component>
</div>