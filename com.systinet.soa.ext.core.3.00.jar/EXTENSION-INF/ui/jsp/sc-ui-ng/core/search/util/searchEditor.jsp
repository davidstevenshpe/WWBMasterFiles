<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.search.searchmessages" var="searchmessages"/>

<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="editorBean" type="com.hp.systinet.sc.ui.search.util.SearchEditorComponent.SearchEditorBean"--%>
<%--@elvariable id="availableArtifactTypes" type="java.util.Collection"--%>
<%--@elvariable id="sharedDataSourceWrapper" type="com.hp.systinet.sc.ui.search.struct.DataSourceWrapper"--%>
<%--@elvariable id="criteriaCustomizationId" type="java.lang.String"--%>
<%--@elvariable id="tableCustomizationId" type="java.lang.String"--%>
<%--@elvariable id="searchExecutionListener" type="com.hp.systinet.sc.ui.search.SearchCriteriaComponent.SearchExecutionListener"--%>
<%--@elvariable id="confirmButtonClass" type="java.lang.String" (optional) - if value is empty, default value is used  --%>

<syswf:component prefix="criteria" name="/core/search/searchCriteria">
    <syswf:param name="customizationId" value="${criteriaCustomizationId}"/>
    <syswf:param name="searchDefinition" value="${editorBean.searchDefinition}"/>
    <syswf:param name="allowSave" value="${false}"/>
    <syswf:param name="searchButtonLabel"><fmt:message key="searchEditor.previewButton"
                                                       bundle="${searchmessages}"/></syswf:param>
    <syswf:param name="dontExecuteOnFirstRender" value="${true}"/>
    <syswf:param name="availableArtifactTypes" value="${availableArtifactTypes}"/>
    <syswf:param name="refreshAfterExecution" value="${false}" />
    <syswf:param name="afterExecutionCallback" value="${prefix}Preview" />
    <syswf:param name="sharedDataSourceWrapper" value="${sharedDataSourceWrapper}"/>
</syswf:component>


	<syswf:control caption="${prefix}Preview" mode="script" action="showPreview" affects="."/>


    <c:set var="winOpenFn" value="${prefix}_open"/>
    <c:set var="winCloseFn" value="${prefix}_close"/>
    <c:set var="winId" value="${prefix}_win"/>
    
    <syswf:component name="/core/window" prefix="preview">
        <syswf:param name="winId" value="${winId}"/>
        <syswf:param name="winTitle"><fmt:message key="searchEditor.previewDialogTitle"
                                                  bundle="${searchmessages}"/></syswf:param>
        <syswf:param name="winOpenFunctionName" value="${winOpenFn}"/>
        <syswf:param name="winCustomButtons">
            [{
                text     : '<fmt:message key="searchEditor.previewDialogClose" bundle="${searchmessages}"/>',
                handler  : function() {
                    SPopup.Window.Instance['${winId}'].hide();
                    return false;
                },
                id: '${prefix}_closeButton'
            }]
        </syswf:param>
        <syswf:param name="winResizable" value="true"/>
        <syswf:param name="winWidth" value="800"/>
        <syswf:param name="winButtonAlign" value="right"/>
        <syswf:param name="winComponent" value="/core/table"/>
        <syswf:param name="winRenderAlways" value="true"/>
        <syswf:param name="customizationId" value="${tableCustomizationId}"/>
        <syswf:param name="datasource" value="${sharedDataSourceWrapper.dataSource}"/>
    </syswf:component>


	<c:if test="${openPreview}">
		<script type="text/javascript">
//<![CDATA[

		  	Ext.onReady(function() {
		  		${prefix}_open();
		  	});
		
//]]>
</script>	
	</c:if>


