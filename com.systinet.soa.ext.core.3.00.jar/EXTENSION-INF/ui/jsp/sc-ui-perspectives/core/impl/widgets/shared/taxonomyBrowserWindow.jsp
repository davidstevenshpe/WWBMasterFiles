<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages" />

<c:if test="${empty openFce}">
    <c:set var="openFce" value="${prefix}openWindow" />
</c:if>

<%-- set button id if not set --%>
<c:if test="${empty addCategoryButtonId}">
    <c:set var="addCategoryButtonId" value="${prefix}_addCategoryBtn"/>
</c:if>

<c:if test="${empty showButton or showButton}">
	<fmt:message key="addCategory" bundle="${widgetMessages}" var="default" />
	<a style="display:inline-block" href="javascript:void(0)" id="${addCategoryButtonId}" class="btn btn-gray btn-labeled em fa fa-${not empty iconType ? iconType : 'plus-circle'}"><span><c:out value="${buttonText}" default="${default}" /></span></a>
</c:if>

<c:set var="tableId" value="${prefix}_tableId"/>
<c:set var="windowId" value="${prefix}_add_category_content"/>

<div class="webfw-Window" id="${prefix}-webfw-Window">
<div id="${windowId}" class="x-hidden">
<div class="x-window-header"><fmt:message key="selectCategoryToAdd" bundle="${widgetMessages}"/></div>
<div class="x-window-body">
    <syswf:component name="/core/impl/window" prefix="taxonomyBrowser">
        <syswf:param name="component" value="/core/impl/widget/util/taxonomyBrowser" />
        <syswf:param name="windowControlName" value="${prefix}render" />
        
        <syswf:param name="selectedCategories" value="${selectedCategories}"/>
        <syswf:param name="taxonomyBrowserListener" value="${taxonomyBrowserListener}"></syswf:param>
        <syswf:param name="hiddenShowAllTaxonomies" value="${hiddenShowAllTaxonomies}"/>
        <syswf:param name="singleSelection" value="${singleSelection}"/>
        <syswf:param name="artifactType" value="${artifactType}" />
        <syswf:param name="windowContentId" value="${windowId}" />
        <syswf:param name="tableId" value="${tableId}" />
        
        <syswf:param name="taxonomyDSCache" value="${taxonomyDSCache}" />
        <syswf:param name="categoryDSCache" value="${categoryDSCache}" />
        
        <syswf:param name="cancelFunc" value="${prefix}cancel" />
    </syswf:component>
</div>
</div>

<%-- Cancel was moved inside taxonomyBrowser because of Bug #61958, however,
this control needs to stay here because of affects, which is added automaticaly when
used in window. When moved inside, affects would target just the taxonomyBrowser and that's not
what we want --%>
<syswf:control mode="script" action="${prefix}_taxonomyBrowser_window$onSave" caption="${prefix}save">
    <syswf:param name="${tableId}_resetPaging" value="true" />
    <syswf:param name="${tableId}_resetFilter" value="true" />
</syswf:control>

<c:set var="buttons">
[{
    text     : '<fmt:message key="button.ok" bundle="${widgetMessages}"/>',
    disabled : false,
    xtype    :'flatbutton',
    iconCls  :'btn btn-primary',
    handler  : function() {
        ${prefix}save();
        SPopup.Window.Instance['${windowId}'].hide();
    },
    id:'${prefix}_addButton'
},{
    text     : '<fmt:message key="button.cancel" bundle="${widgetMessages}"/>',
    xtype    :'flatbutton',
    iconCls  :'btn btn-gray',
    handler  : function(){
        ${prefix}cancel();
        SPopup.Window.Instance['${windowId}'].hide();
    },
    id:'${prefix}_cancelButton'
}]
</c:set>

<script type="text/javascript">
//<![CDATA[

var ${openFce} = function() {
	${prefix}render();
        SPopup.Window.forceOpen(
            '${windowId}',
            '${windowId}',
            {
                width:650,
                autoHeight:true, 
                border: false,
                autoScroll:true,
                buttons: ${buttons},
                centerOnScreen: true
            }
        );


    SPopup.Window.Instance['${windowId}'].on('resize', function() {
        //console.log('resize out');
        var cmp = Ext.getCmp('${tableId}');
        if (cmp) {
        	//console.log('resize in');
            cmp.getEl().setStyle({width: '100%'});
            cmp.getGridEl().setStyle({width: '100%'});
            cmp.syncSize();
        }
    });

    var cmp = Ext.getCmp('${tableId}');
    //console.log('syncSize out');
    if (cmp) {
    	//console.log('syncSize in');
        cmp.getEl().setStyle({width: '100%'});
        cmp.getGridEl().setStyle({width: '100%'});
        cmp.syncSize();
    };
}

<%-- Popup window needs to be reinitialized on AJAX update --%>
Ext.onReady(function() {
    SPopup.Window.Instance['${windowId}'] = undefined;
    Ext.get('${addCategoryButtonId}').on('click', ${openFce});
})

//]]>
</script>

</div>