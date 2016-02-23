<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:if test="${not empty globalSession['userName']}">
	<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.systinet.platform.ui.layouts.LayoutsMessages" var="layouts_Message"/>
<fmt:setBundle basename="com.hp.systinet.platform.rebranding" var="rebranding_Messages"/>

<fmt:message key="rebranding.productName" var="varSystinet2" bundle="${rebranding_Messages}"/>


<!DOCTYPE HTML>
<html lang="en" ng-app="emApp">
<head>
	<c:choose>
		<c:when test="${fn:contains(header['User-Agent'],'MSIE')}">
			<c:set var="httpEquiv" value="X-UA-Compatible"/>
			<c:set var="contentType" value="IE=edge"/>
		</c:when>
		<c:otherwise>
			<c:set var="httpEquiv" value="Content-Type"/>
		</c:otherwise>
	</c:choose>
	<meta http-equiv="<c:out value="${httpEquiv}"/>" content="<c:out value="${contentType}"/>" />
    <title>
        <c:choose>
            <c:when test="${not empty viewInstance.browserTitle}">
                <c:out value="${viewInstance.browserTitle} - ${varSystinet2}"/>
            </c:when>
            <c:when test="${not empty viewInstance.taskCaption}">
                <c:out value="${viewInstance.taskCaption} - ${varSystinet2}"/>
            </c:when>
            <c:otherwise>
                <c:out value="${varSystinet2}"/>
            </c:otherwise>
        </c:choose>
    </title>
	<link rel="icon" href="<c:out value='${webResourcePath}'/>/skin/img/default/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="<c:out value='${webResourcePath}'/>/skin/img/default/favicon.ico" type="image/x-icon" />
<jsp:include page="../../../core/globalJsVariables.jsp"/>
  <%--<syswf:localizedFileName fileName="${webResourcePath}/skin/js/compat.js" var="jsCompat"/>--%>
	<syswf:localizedFileName fileName="${webResourcePath}/skin/ext3/adapter/ext/ext-base.js" var="jsExtBase"/>
	<syswf:localizedFileName fileName="${webResourcePath}/skin/ext3/ext-all.js" var="jsExtAll"/>
	<syswf:localizedFileName fileName="${webResourcePath}/skin/ext3/ext-patch-34.js" var="jsExtPatch34"/>

    <%-- there is a patch in jquery.js, therefore is not yet in min version, TODO for designers --%>
    <syswf:localizedFileName fileName="${webResourcePath}/skinem/bootstrap/js/jquery-2.1.1.min.js" var="jsJqueryMin"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skinem/bootstrap/js/jquery-migrate-1.2.1.min.js" var="jsJqueryMgt"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/jquery/jquery-ui.js" var="jsJqueryUi"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ext_hp-adapter.js" var="jsExtHpAdapter"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/lang_en.js" var="jsLang"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_spopup.js" var="jsComSPopup"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_advancedoptions.js" var="jsComAdvancedOptions"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_datagrid.js" var="jsComDataGrid"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_infotip.js" var="jsComInfoTip"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ext_extensions/FilteredGridPanel.js" var="jsExtFilteredGrid"/>
    <%--<syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_tree_datagrid.js" var="jsComTreeDataGrid"/>--%>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_progressbar.js" var="jsComProgressBar"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_htmleditor.js" var="jsComHtmlEditor"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_input.js" var="jsComInput"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_combobox.js" var="jsComCombobox"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_comboboxmulti.js" var="jsComComboboxMulti"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_dropdown.js" var="jsComDropDown"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_dropdownbutton.js" var="jsComDropDownButton"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_checksplitbutton.js" var="jsCheckSplitButton"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_actionbutton.js" var="jsActionButton"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_actionmenu.js" var="jsActionMenu"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_actionmenuitem.js" var="jsActionMenuItem"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_keywords.js" var="jsComKeywords"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_uploadfield.js" var="jsComUploadField"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_serverfolders.js" var="jsComServerFolders"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_tree.js" var="jsComTree"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_window.js" var="jsComWindow"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_expression.js" var="jsComExpression"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_richtip.js" var="jsComRichTip"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/RowExpander.js" var="jsRowExpander"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/ckeditor/ckeditor.js" var="jsCKeditor"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/ckeditor/adapters/jquery.js" var="jsCKeditorJQuery"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/menu/EditableItem.js" var="jsEditableItem"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/menu/RangeMenu.js" var="jsRangeMenu"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/grid/hp-gridfilters.js" var="jsGridFilters"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/grid/hp-gridfilters-filterfield.js" var="jsGridFiltersField"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/grid/ColumnHeaderGroup.js" var="groupHeaderPlugin"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/grid/hp-gridview.js" var="gridView"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/grid/hp-row-expander.js" var="jsHpRowExpander"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/grid/hp-selectablecell.js" var="jsHpSelectableCell"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/panel/hp-fit2parent.js" var="jsHpFit"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/menu/hp-menu-mgr.js" var="jsMenuMgr"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/menu/hp-custom-menu.js" var="jsCustomMenu"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_datefield.js" var="jsCustomDateField"/>
	
	<%-- 3rd lib for exporting svg/html to png --%>
	<syswf:localizedFileName fileName="${webResourcePath}/skinem/html2canvas/html2canvas.min.js" var="jshtml2canvas"/>
	<syswf:localizedFileName fileName="${webResourcePath}/skinem/canvg/rgbcolor.js" var="jsrgbcolor"/>
	<syswf:localizedFileName fileName="${webResourcePath}/skinem/canvg/StackBlur.js" var="jsstackblur"/>
	<syswf:localizedFileName fileName="${webResourcePath}/skinem/canvg/canvg.js" var="jscanvg"/>
	<syswf:localizedFileName fileName="${webResourcePath}/skinem/canvastoblob/canvas-toBlob.js" var="jscanvastoblob"/>
	<syswf:localizedFileName fileName="${webResourcePath}/skinem/filesaver/FileSaver.js" var="jsfilecanvas"/>
	

    <syswf:localizedFileName fileName="${webResourcePath}/skin410/js/cookieHandle.js" var="jsCookieHandle"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skinem/js/layoutManager.js" var="jsLayoutHandle"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skinem/js/printPortletManager.js" var="jsPrintPortletManager"/>


    <syswf:localizedFileName fileName="${webContext}/${productBuildId}/js/ajaxExt.js" var="ajax"/>
    <syswf:localizedFileName fileName="${webContext}/${productBuildId}/js/table.js" var="jsTable"/>

    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/chart/raphael-min.js" var="raphaelMin"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/chart/g.raphael-min.js" var="graphaelMin"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/chart/g.pie.js" var="gPie"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/chart/g.bar.js" var="gBar"/>

    <syswf:localizedFileName fileName="${webResourcePath}/skin/jquery/ux/chili/jquery.chili-2.2.js" var="chili"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/jquery/ux/chili/" var="chiliRecipeFolder"/>

    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_richcode.js" var="richcode"/>

    <%--<script type="text/javascript" src="<c:out value="${jsCompat}"/>"></script>--%>
	<script type="text/javascript" src="<c:out value="${jsExtBase}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsExtAll}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsExtPatch34}"/>"></script>

    <script type="text/javascript" src="<c:out value="${jsJqueryMin}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsJqueryMgt}"/>"></script>
    <script type="text/javascript">
     jQuery.curCSS = jQuery.css;
	</script>
    <script type="text/javascript" src="<c:out value="${jsJqueryUi}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsExtHpAdapter}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsLang}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComSPopup}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComAdvancedOptions}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComDataGrid}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComInfoTip}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsExtFilteredGrid}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComProgressBar}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComHtmlEditor}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComInput}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComDropDown}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComDropDownButton}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComCombobox}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComComboboxMulti}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsCheckSplitButton}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsActionButton}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsActionMenu}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsActionMenuItem}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComKeywords}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsRowExpander}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsCKeditor}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsCKeditorJQuery}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsEditableItem}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsRangeMenu}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsGridFilters}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsGridFiltersField}"/>"></script>
    <script type="text/javascript" src="<c:out value="${ajax}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsTable}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsCookieHandle}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsLayoutHandle}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsPrintPortletManager}"/>"></script>    
    <script type="text/javascript" src="<c:out value="${groupHeaderPlugin}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComWindow}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComExpression}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComUploadField}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComServerFolders}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComTree}"/>"></script>
    <script type="text/javascript" src="<c:out value="${gridView}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsHpRowExpander}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsHpSelectableCell}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsHpFit}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsComRichTip}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsMenuMgr}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsCustomMenu}"/>"></script>
    <script type="text/javascript" src="<c:out value="${raphaelMin}"/>"></script>
    <script type="text/javascript" src="<c:out value="${graphaelMin}"/>"></script>
    <script type="text/javascript" src="<c:out value="${gPie}"/>"></script>
    <script type="text/javascript" src="<c:out value="${gBar}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsCustomDateField}"/>"></script>
    
    <%-- 3rd lib for exporting svg/html to png --%>
    <script type="text/javascript" src="<c:out value="${jshtml2canvas}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsrgbcolor}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsstackblur}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jscanvg}"/>"></script>    
    <script type="text/javascript" src="<c:out value="${jscanvastoblob}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsfilecanvas}"/>"></script>
    
    <script type="text/javascript" src="<c:out value="${richcode}"/>"></script>
	
    <!-- JQuery Syntax Highlither Chili [ http://code.google.com/p/jquery-chili-js/ ] -->
    <script type="text/javascript" src="<c:out value="${chili}"/>"></script>
    <script type="text/javascript">
//<![CDATA[
        Ext.chart.Chart.CHART_URL = RESOURCES_URI+"/skin/ext3/resources/charts.swf";
        ChiliBook.recipeFolder = "<c:out value="${chiliRecipeFolder}"/>";
        ChiliBook.automatic = true;
        ChiliBook.lineNumbers = false;
        //]]>
    </script>

    <link rel="stylesheet" media="screen" type="text/css" href="<c:out value='${webResourcePath}'/>/skin/ext3/resources/css/ext-all.css" />
    <link rel="stylesheet" media="screen" type="text/css" href="<c:out value='${webResourcePath}'/>/skin/css/index.css" />
    <link rel="stylesheet" media="screen" type="text/css" href="<c:out value='${webResourcePath}'/>/skinem/bootstrap/css/font-awesome.min.css" />
    <link rel="stylesheet" media="screen" type="text/css" href="<c:out value='${webResourcePath}'/>/skin410/css/icon-fonts.css" />

    <link rel="stylesheet" type="text/css" href="${webResourcePath}/skin/ext42/resources/css/ext-sandbox.css">
    <script type="text/javascript" src="${webResourcePath}/skin/ext42/builds/ext-all-sandbox.js"></script>
    <script type="text/javascript" src="${webResourcePath}/skin/ext42/builds/ext-patch-42.js"></script>
    <link rel="stylesheet" type="text/css" href="${webResourcePath}/skin/js/ux/portal/Portal.css"/>
    <script>
        Ext4.Loader.setPath('Ext4.app', '${webResourcePath}/../../components/ui-sc-components/portal');
        Ext4.Loader.setPath('EA.portal', '${webResourcePath}/../../components/ui-sc-components/portal');
        Ext4.Loader.setPath('EA.model', '${webResourcePath}/../../components/ui-ea/model');
        Ext4.Loader.setPath('EA.portlets', '${webResourcePath}/../../components/ui-ea/portlets');
        Ext4.Loader.setPath('D3', '${webResourcePath}/../../components/d3');
        Ext4.Loader.setPath('EA.scripts', '${webResourcePath}/../../../../../platform/rest/location/scripts');
        Ext4.Loader.setPath('EA', '${webResourcePath}/../../components/EA');

        <syswf:component wrap="false" name="/core/datasource/datasourceDeclaration" prefix="ds"/>
    </script>
    <!-- New CSS -->
    <link href="<c:out value='${webResourcePath}'/>/skin410/css/index.css" rel="stylesheet" type="text/css" />
    <link href="<c:out value='${webResourcePath}'/>/skin${context}/css/index.css" rel="stylesheet" type="text/css" />
	<!-- *** -->

    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/aceeditor/ace/ace.js" var="ace"/>
    <script type="text/javascript" src="<c:out value="${ace}"/>"></script>
    
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/extflot/excanvas.compiled.js" var="flot0"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/extflot/jquery.flot.trunk.pie.js" var="flot1"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/extflot/GetText.js" var="flot2"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/extflot/Flot.js" var="flot3"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/extflot/PieFlot.js" var="flot4"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/extflot/BarFlot.js" var="flot5"/>
    <script type="text/javascript" src="<c:out value="${flot0}"/>"></script>
    <script type="text/javascript" src="<c:out value="${flot1}"/>"></script>
    <script type="text/javascript" src="<c:out value="${flot2}"/>"></script>
    <script type="text/javascript" src="<c:out value="${flot3}"/>"></script>
    <script type="text/javascript" src="<c:out value="${flot4}"/>"></script>
    <script type="text/javascript" src="<c:out value="${flot5}"/>"></script>
    <script type="text/javascript" src="<c:out value='${webResourcePath}'/>/skinem/angular/js/angular.min.js"></script>
	<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/angular/common/controller.js"></script>
	<script type="text/javascript" src="<c:out value='${webResourcePath}'/>/../../js/angular/common/view.js"></script>
</head>
<body>
    <script type="text/javascript" >
//<![CDATA[

        Ext.onReady( function () {
			Ext.state.Manager.setProvider(new Ext.state.SCStateProvider());
			Ext.QuickTips.init();
        	layoutManager.init();
        	layoutManager.manage();
        	$(document).trigger('extReady');
        });
//]]>
    </script>
    <div style="display:none" id="windowContent"></div>
	<syswf:form id="ContentForm" method="post" enctype="multipart/form-data">
	<div id="container" class="effect flex-page">
	    <div class="NewPageHeader">
	    	<div class="header-column header-column-left">
		    	<c:out value="${panel.areas['header'].code}" escapeXml="false"/>
		    	<c:if test="${context ne 'csa'}">
		    		<c:out value="${panel.areas['navigation'].code}" escapeXml="false" />
		    	</c:if>
	    	</div>
	    	<div class="header-column header-column-right">
		    	<c:out value="${panel.areas['domainselection'].code}" escapeXml="false" />
		    	<c:if test="${context ne 'csa'}">
		    		<c:out value="${panel.areas['search'].code}" escapeXml="false" />
		    	</c:if>	    	
		    	<c:out value="${panel.areas['userevent'].code}" escapeXml="false" />
	    	</div>
	    </div>

	    <div class="Menu">
	    	<c:out value="${panel.areas['menu'].code}" escapeXml="false"/>
	    </div>

		<div class="UI Page" id="pagecontentdata">
        <syswf:component name="/core/impl/layout/uiMessageRenderer" prefix="messages"/>
		<c:out value="${panel.areas['content'].code}" escapeXml="false" />
		</div>
		<div class="NewPageFooter">
	        <c:out value="${panel.areas['notices'].code}" escapeXml="false"/>
		</div>
	</div>
	<div id="popupWindows"></div>
	</syswf:form>
	<syswf:component name="/newui/nifty" prefix="nifty_angular">
		<syswf:param name="callback">function(){$(document).trigger('bootstrapReady')}</syswf:param>
	</syswf:component>
</body>
</html>
