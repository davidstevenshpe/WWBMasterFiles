<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<%--@elvariable id="processBean" type="com.hp.systinet.lifecycle.ui.admin.process.ProcessBean"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="typeLabels" type="java.util.List"--%>

<c:set var="openButtonId" value="${prefix}_anchor"/>
<c:set var="winOpenFn" value="${prefix}_open"/>
<c:set var="winOkFn" value="${prefix}_ok"/>
<c:set var="winCancelFn" value="${prefix}_cancel"/>
<c:set var="getSubtypesFn" value="${prefix}_getSubtypesFn"/>

<c:if test="${not empty typeLabels}">
    <c:forEach items="${typeLabels}" var="type" varStatus="status"><c:if test="${!status.first}">,</c:if>
        <c:out value="${type}"/></c:forEach>
    <br/>
</c:if>
<c:choose>
    <c:when test="${empty processBean.subArtifactValues}">
        <a class="Btn Icon" id="${openButtonId}" onclick="javascript:${winOpenFn}()" href="javascript:void(0)">
            <span><span class="Edit"><fmt:message
                   key="processEditor.selectButton" bundle="${messages}" /></span></span></a>
    </c:when>
    <c:otherwise>
        <a class="UI Icon Edit" id="${openButtonId}" href="javascript:void(0);">
            <span><span class="Edit"><fmt:message
                   key="processEditor.changeButton" bundle="${messages}" /></span></span></a>
    </c:otherwise>
</c:choose>

<syswf:component name="/core/window" prefix="addInitialStageWindow">
    <syswf:param name="winTitle"><fmt:message key="processEditor.selectSubArtifactTypesDialog.title"
                                              bundle="${messages}"/></syswf:param>
    <syswf:param name="winComponent" value="/core/util/artifactTree"/>
    <syswf:param name="winOpenFunctionName" value="${winOpenFn}" />
    <syswf:param name="winOkAction" value="${winOkFn}" />
    <syswf:param name="winCancelAction" value="${winCancelFn}" />
    <syswf:param name="winResizable" value="true"/>
    <syswf:param name="winRenderContents" value="true"/>
    <syswf:param name="winWidth" value="300"/>
    <syswf:param name="autoHeight" value="false"/>
    <syswf:param name="winButtonAlign" value="right"/>

    <syswf:param name="preselectedSdmNames" value="${processBean.subArtifactValues}"/>
    <syswf:param name="funcGetChecked" value="${getSubtypesFn}"/>
    <syswf:param name="includedArtifacts" value="${includedArtifacts}"/>
</syswf:component>

<c:set var="saveFn" value="${prefix}_reloadFn"/>
<syswf:control mode="script" action="save" caption="${saveFn}" affects="."/>
<syswf:control mode="script" action="cancel" caption="${winCancelFn}" affects="."/>

<c:set var="selectedSdmNamesField" value="selectedSdmNames"/>
<syswf:input id="${selectedSdmNamesField}" name="${selectedSdmNamesField}" value="" mode="hidden"/>

<script type="text/javascript">
//<![CDATA[

    attachOn('${openButtonId}','click', function() {
        ${winOpenFn}();
    });

    function ${winOkFn}() {
        var selectedSdmNames = ${getSubtypesFn}();
        Ext.get('${selectedSdmNamesField}').dom.value = selectedSdmNames;
        ${saveFn}();
    }

//]]>
</script>
