<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="cmess" />

<div class="UI Align">
    <div class="Right"><a href="javascript:void(0)" id="${prefix}handler" class="UI Icon Add">
        <fmt:message bundle="${cmess}" key="catMgm.addCategory" />
    </a></div>
    <div class="Left"><syswf:out context="HtmlBody" value="${text}"/></div>
</div>
<div class="clear"></div>

<div id="${prefix}categoriesTable" class="UI Table ManageCategories"></div>

<script type="text/javascript">
//<![CDATA[

Ext.onReady(function(){
    var myData = {'data': [
           <c:forEach var="row" items="${holder.taxonomies}" varStatus="status">
                  {
                   'name':'<syswf:out value="${row.value.name}" context="HtmlBody"/>',
                   'description':'<syswf:out value="${row.value.description}" context="HtmlBody"/>',
                   'remove':'<syswf:addSlashes><syswf:control mode="anchor" action="removeTaxonomy" caption="&nbsp;" id="remove${status.index}"><syswf:param name="tModelKey" value="${row.key}" /><syswf:attribute name="class" value="UI Icon Delete Context" /></syswf:control></syswf:addSlashes>'
                  }
                  <c:if test="${not status.last}">,</c:if>
           </c:forEach>
                       ]
                   };
    var store = new Ext.data.JsonStore({
        totalProperty: 'total',
        root: 'data',
        fields: [
            {name: 'name'}, 
            {name: 'description'}, 
            {name: 'remove'}
        ],
        sortInfo: {
            field: 'name', 
            direction: 'ASC'
        },
        remoteSort: false
    });

    store.loadData(myData);

    var cm = new Ext.grid.ColumnModel([{
        id: 'name', 
        dataIndex: 'name', 
        header: '<fmt:message bundle="${labels}" key="Name" />', 
        sortable: true, 
        hideable: false
    },{
        id: 'remove', 
        dataIndex: 'remove', 
        header: '', 
        width: 25, 
        sortable: false, 
        menuDisabled: true, 
        resizable: false, 
        hideable: false, 
        align: 'right'
    }]);

    cm.defaultSortable = true;
    
    var ${prefix}C_Selectable = new Ext.ux.plugins.MakeSelectable();
        
    var ${prefix}categories = new Ext.grid.GridPanel({
        id: '${prefix}categories',
        el: '${prefix}categoriesTable',
        store: store,
        cm: cm,
        plugins: [${prefix}C_Selectable],
        enableColLock: true,
        loadMask: true,
        autoExpandColumn: 'description',
        viewConfig: {
            forceFit: true,
            enableRowBody:true,
            showPreview:true,
            getRowClass: function(record, rowIndex, p, store) {
                    p.body = '<p class="TextExcerpt">'+record.data.description+'</p>';
                    return 'x-grid3-row-expanded';
                }
        },
        autoHeight: true,    
        autoScroll: true,    
        trackMouseOver: false
    });

    // render the grid to the specified div in the page
    ${prefix}categories.render();
});

//]]>
</script>

<div class="webfw-Window" id="${prefix}-webfw-Window">    
<div id="${prefix}manageCategories_window" class="x-hidden">
<div class="x-window-header">Select Categories</div>
<div class="x-window-body">
<div class="UI Offset">

<syswf:component name="/core/impl/window" prefix="selectCategories">
    <syswf:param name="component" value="/core/impl/customization/categories/selectCategories"/>
    <syswf:param name="windowControlName" value="${prefix}_render" />
    <syswf:param name="holder" value="${holder}" />
    <syswf:param name="selectionBag" value="${taxonomySelectionBag}" />
    <syswf:param name="limitTaxonomiesToViewId" value="${limitTaxonomiesToViewId}" />
</syswf:component>

</div>
</div>
</div>
</div>

<%-- action control - fires action after user presses OK --%>
<syswf:control mode="script" action="addTaxonomies" caption="${prefix}selectCategories" />

<c:set var="customButtons">
    [{
        text     : 'Add Selected',
        disabled : false,
        handler  : function() {
            SPopup.Window.Instance['${prefix}manageCategories_window'].hide();
            ${prefix}selectCategories();
        },
        id: '${prefix}_okButton'
    }]
</c:set>

<script type="text/javascript">
//<![CDATA[

           
var ${prefix}open = function() {
    ${prefix}_render();
    SPopup.Window.forceOpen('${prefix}manageCategories_window','${prefix}manageCategories_window',{
        autoHeight: true, buttons: <c:out value="${customButtons}" escapeXml="false"/>,
        buttonAlign: 'center', width: 600, resizable: false, centerOnScreen: true
    });
}

attachOn('${prefix}handler','click',${prefix}open);

<%-- Popup window needs to be reinitialized on AJAX update --%>
Ext.onReady(function() {
	SPopup.Window.Instance['${prefix}manageCategories_window'] = undefined;
	moveWindow('${prefix}-webfw-Window','popupWindows');
})

//]]>
</script>