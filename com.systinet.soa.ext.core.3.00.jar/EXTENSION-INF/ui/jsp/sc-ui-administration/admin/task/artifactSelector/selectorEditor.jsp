<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.l10n.L10nSCAdministration" var="messages"/>

<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="editedSelectorValue" type="com.hp.systinet.sc.tool.ArtifactSelector"--%>
<%--@elvariable id="editorBean" type="com.hp.systinet.sc.ui.admin.task.artifactSelector.SelectorEditorBean"--%>
<%--@elvariable id="availableArtifactTypes" type="java.util.List"--%>
<%--@elvariable id="sharedDataSourceWrapper" type="com.hp.systinet.sc.ui.search.struct.DataSourceWrapper"--%>

<c:set var="radioIdBase" value="${prefix}_mode"/> <%-- base of id of a mode radio (followed by _0, _1 etc.)   --%>
<%-- base of javascript variable name for a mode radio (followed by _NONE, _SEARCH etc. --%>
<c:set var="radioVarBase" value="${prefix}_radioVar"/>
<c:set var="selectorsId" value="${prefix}_selectors"/> <%-- id of selectors div element --%>
<%-- base for id of selector div element (followed by _NONE, _SEARCH etc.) --%>
<c:set var="selectorIdBase" value="${prefix}_noneSelector"/>
<c:set var="artifactListTableId" value="${prefix}_indivTableId"/> <%-- table id for the artifact list table --%>

<div class="OffsetLeft">
    <syswf:selectOne name="mode" id="${radioIdBase}"
                     value="${editorBean}" property="mode" dataType="enum"
                     optionCaptions="${editorBean.modeCaptions}"
                     optionValues="${editorBean.modeValues}"
                     optionClasses="${editorBean.modeClasses}"
                     mode="radio" displayAsRow="true">
        <syswf:attribute name="class" value="UI Form Checkbox Inline"/>
    </syswf:selectOne>
    <script type="text/javascript">
//<![CDATA[

        <c:forEach items="${editorBean.modeValues}" var="modeValue" varStatus="status">
            <c:set var="radioVar" value="${radioVarBase}_${modeValue}"/>
            <c:set var="radioId" value="${radioIdBase}_${status.index}"/>
            var ${radioVar} = Ext.get('${radioId}');
        </c:forEach>
    
//]]>
</script>
</div>

<div id="${selectorsId}" class="UI OptionAreas">
    <div id="${selectorIdBase}_NONE" class="UI OptionArea ${editorBean.mode.name eq 'NONE' ? '' : 'x-hidden'}"></div>
    <div id="${selectorIdBase}_SEARCH" class="UI OptionArea ${editorBean.mode.name eq 'SEARCH' ? '' : 'x-hidden'}">
        <syswf:component prefix="search" name="/core/search/util/searchEditor">
            <syswf:param name="editedValue" value="${editedSelectorValue.searchSelector}"/>
            <syswf:param name="availableArtifactTypes" value="${availableArtifactTypes}"/>
            <syswf:param name="providerArtifactTypesFilter" value="${providerArtifactTypesFilter}"/>
            <syswf:param name="editorBean" value="${editorBean.searchEditorBean}"/>
            <syswf:param name="criteriaCustomizationId" value="admin.task.artifactSelector.search.criteria"/>
            <syswf:param name="tableCustomizationId" value="admin.task.artifactSelector.search.results"/>
        </syswf:component>
    </div>
    <div id="${selectorIdBase}_INDIVIDUAL"
         class="UI OptionArea ${editorBean.mode.name eq 'INDIVIDUAL' ? '' : 'x-hidden'}">
        <syswf:component prefix="artifactList" name="/admin/task/artifactSelector/individual/artifactListEditor">
            <syswf:param name="editedValue" value="${editedSelectorValue.individualArtifactSelector}"/>
            <syswf:param name="availableArtifactTypes" value="${availableArtifactTypes}"/>
            <syswf:param name="editorBean" value="${editorBean.artifactListEditorBean}"/>
            <syswf:param name="tableId" value="${artifactListTableId}"/>
        </syswf:component>
    </div>
</div>

<%-- function names --%>
<c:set var="showSelectorDivFn" value="${prefix}_showSelectorDiv"/>
<script type="text/javascript">
//<![CDATA[


    function ${showSelectorDivFn}(divId) {
        AdvancedOptions.Form.Switch('${selectorsId}', divId);
    }

    Ext.onReady(function() {
        <c:forEach items="${editorBean.modeValues}" var="modeValue" varStatus="status">
            <c:set var="radioVar" value="${radioVarBase}_${modeValue.name}"/>
            <c:set var="selectorId" value="${selectorIdBase}_${modeValue.name}"/>
            ${radioVar}.on('click', function() {
                if (${radioVar}.dom.checked) {
                    ${showSelectorDivFn}('${selectorId}');
                    <%-- Hack suggested by Lukas Konarik to solve table sizing problems --%>
                    <c:if test="${modeValue.name eq 'INDIVIDUAL'}">
                        Datagrid.Utils.KeepSize(${artifactListTableId}grid);
                    </c:if>
                }
            });
        </c:forEach>
    });


//]]>
</script>






