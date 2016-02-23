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
<html xmlns="http://www.w3.org/1999/xhtml">
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
    
<jsp:include page="../sc-ui-ng/core/globalJsVariables.jsp"/>
    
	<syswf:localizedFileName fileName="${webResourcePath}/skin/ext3/adapter/ext/ext-base.js" var="jsExtBase"/>
	<syswf:localizedFileName fileName="${webResourcePath}/skin/ext3/ext-all.js" var="jsExtAll"/>
	<syswf:localizedFileName fileName="${webResourcePath}/skin/ext3/ext-patch-34.js" var="jsExtPatch34"/>
    <%-- there is a patch in jquery.js, therefore is not yet in min version, TODO for designers --%>
    <syswf:localizedFileName fileName="${webResourcePath}/skinem/bootstrap/js/jquery-2.1.1.min.js" var="jsJqueryMin"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ext_hp-adapter.js" var="jsExtHpAdapter"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/lang_en.js" var="jsLang"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_spopup.js" var="jsComSPopup"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_advancedoptions.js" var="jsComAdvancedOptions"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_datagrid.js" var="jsComDataGrid"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_infotip.js" var="jsComInfoTip"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ext_extensions/FilteredGridPanel.js" var="jsExtFilteredGrid"/>    
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_progressbar.js" var="jsComProgressBar"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_htmleditor.js" var="jsComHtmlEditor"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_input.js" var="jsComInput"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_combobox.js" var="jsComCombobox"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_comboboxmulti.js" var="jsComComboboxMulti"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_dropdown.js" var="jsComDropDown"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_dropdownbutton.js" var="jsComDropDownButton"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_checksplitbutton.js" var="jsCheckSplitButton"/>
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

    <syswf:localizedFileName fileName="${webResourcePath}/skinem/js/layoutManager.js" var="jsLayoutHandle"/>

    <syswf:localizedFileName fileName="${webContext}/${productBuildId}/js/ajaxExt.js" var="ajax"/>
    <syswf:localizedFileName fileName="${webContext}/${productBuildId}/js/table.js" var="jsTable"/>

    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/chart/raphael-min.js" var="raphaelMin"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/chart/g.raphael-min.js" var="graphaelMin"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/chart/g.pie.js" var="gPie"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/ux/chart/g.bar.js" var="gBar"/>

    <syswf:localizedFileName fileName="${webResourcePath}/skin/jquery/ux/chili/jquery.chili-2.2.js" var="chili"/>
    <syswf:localizedFileName fileName="${webResourcePath}/skin/jquery/ux/chili/" var="chiliRecipeFolder"/>

    <syswf:localizedFileName fileName="${webResourcePath}/skin/js/com_richcode.js" var="richcode"/>

	<script type="text/javascript" src="<c:out value="${jsExtBase}"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsExtAll}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsExtPatch34}"/>"></script>
    <script type="text/javascript" src="<c:out value="${jsJqueryMin}"/>"></script>
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
    <script type="text/javascript" src="<c:out value="${jsLayoutHandle}"/>"></script>
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

    <script type="text/javascript" src="<c:out value="${richcode}"/>"></script>       

    <!-- JQuery Syntax Highlither Chili [ http://code.google.com/p/jquery-chili-js/ ] -->
    <script type="text/javascript" src="<c:out value="${chili}"/>"></script>
    <script type="text/javascript">
//<![CDATA[

        ChiliBook.recipeFolder = "<c:out value="${chiliRecipeFolder}"/>";
        ChiliBook.automatic = true;
        ChiliBook.lineNumbers = false;
        //]]>
    </script>

    <link rel="stylesheet" media="screen" type="text/css" href="<c:out value='${webResourcePath}'/>/skin/ext3/resources/css/ext-all.css" />
    <link rel="stylesheet" media="screen" type="text/css" href="<c:out value='${webResourcePath}'/>/skin/css/index.css" />
    
    <!-- New CSS -->
    <link href="<c:out value='${webResourcePath}'/>/skin410/css/index.css" rel="stylesheet" type="text/css" />
    <link href="<c:out value='${webResourcePath}'/>/skinem/css/index.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" media="screen" type="text/css" href="<c:out value='${webResourcePath}'/>/skinem/bootstrap/css/font-awesome.min.css" />
	<!-- *** -->

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
</head>
<body style="height: 100%;">
    <script type="text/javascript" >
    //<![CDATA[
        Ext.onReady( function () {
            Ext.state.Manager.setProvider(new Ext.state.SCStateProvider());
            Ext.QuickTips.init();
        	layoutManager.init();
        	layoutManager.manage();
        });
        //]]>
    </script>
    <div style="display:none" id="windowContent"></div>
	<syswf:form id="ContentForm" method="post" enctype="multipart/form-data">		
	    <div class="NewPageHeader">
	    	<div class="header-column header-column-left">
		    	<c:out value="${panel.areas['header'].code}" escapeXml="false"/>
	    		<c:out value="${panel.areas['navigation'].code}" escapeXml="false" />		    	
	    	</div>
	    	<div class="header-column header-column-right">
	    		<c:out value="${panel.areas['domainselection'].code}" escapeXml="false" />
	    		<c:out value="${panel.areas['search'].code}" escapeXml="false" />
		    	<c:out value="${panel.areas['userevent'].code}" escapeXml="false" />
	    	</div>
	    </div>
		<div class="UI Page" id="pagecontentdata">
        	<syswf:component name="/core/impl/layout/uiMessageRenderer" prefix="messages"/>
        	<c:out value="${panel.areas['content'].code}" escapeXml="false" />
		</div>
		<div id="popupWindows"></div>
	</syswf:form>
	<c:out value="${panel.areas['flash'].code}" escapeXml="false" />
	<syswf:component name="/newui/nifty" prefix="nifty_angular">
		<syswf:param name="callback">function(){$(document).trigger('bootstrapReady')}</syswf:param>
	</syswf:component>
</body>
</html>
