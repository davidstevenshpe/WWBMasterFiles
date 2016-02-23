<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<!-- Div for rendering of the table -->
<div id="${prefix}PropertiesCategoriesTable" class="UI Table"></div>

<syswf:control mode="script" caption="${prefix}selectCategory" action="selectCategory" affects=".." />
<syswf:control mode="script" caption="${prefix}removeSelected" action="removeSelected" />

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){
        var myData = {'data': [
            <c:forEach var="row" items="${this.categories}" varStatus="status">
                <c:set var="id" value="${prefix}$${row.id}" />{
                    'select':false,
                    'id':'${id}',
                    'name':'<span><syswf:out value="${row.categoryRow.name}" context="HtmlBody"/></span>',
                    'taxonomy':'<syswf:out value="${row.categoryRow.taxonomy.name}" context="HtmlBody"/>',
                    'addCategory':'<syswf:selectOne name="${row.id}_add" value="${row}" property="property" mode="radio" optionValues="add" optionCaptions=" " displayAsRow="true" />',
                    'removeCategory':'<syswf:selectOne name="${row.id}_add" value="${row}" property="property" mode="radio" optionValues="rem" optionCaptions=" " displayAsRow="true" />'}
                <c:if test="${not status.last}">,</c:if>
            </c:forEach>
        ]};

        var store = new Ext.data.JsonStore({
            totalProperty: 'total',
            root: 'data',
            fields: [
                    {name: 'select'},
                    {name: 'id'},
                    {name: 'name'}, 
                    {name: 'taxonomy'},
                    {name: 'addCategory'},
                    {name: 'removeCategory'}
            ],
            sortInfo: {
                field: 'name', 
                direction: 'ASC'
            },
            remoteSort: false
        });
    
        store.loadData(myData);
    
        var cm = new Ext.grid.ColumnModel([{
            id: 'select', 
            dataIndex: 'select', 
            header: "", 
            width: 25, 
            sortable: false, 
            resizable: false, 
            menuDisabled: true, 
            hideable: false,
            renderer: Datagrid.Renderer.Checkbox
        },{
            id: 'name', 
            dataIndex: 'name', 
            header: '<fmt:message bundle="${labels}" key="Category" />', 
            width: 170, 
            sortable: true 
        },{
            id: 'taxonomy', 
            dataIndex: 'taxonomy', 
            header: '<fmt:message bundle="${labels}" key="Taxonomy" />', 
            width: 170, 
            sortable: true
        },{
            id: 'add_cat', 
            dataIndex: 'addCategory', 
            header: '<fmt:message bundle="${labels}" key="Add" />', 
            width: 50, 
            sortable: false, 
            menuDisabled: true, 
            resizable: false, 
            hideable: false, 
            align: 'center'
        },{
            id: 'rem_cat', 
            dataIndex: 'removeCategory', 
            header: '<fmt:message bundle="${labels}" key="Remove" />', 
            width: 50, 
            sortable: false, 
            menuDisabled: true, 
            resizable: false, 
            hideable: false, 
            align: 'center'
        }]);
    
        cm.defaultSortable = true;
        
        var ${prefix}PCT_Selectable = new Ext.ux.plugins.MakeSelectable();
            
        var editproperties_bulk_categories = new Ext.grid.GridPanel({
            id: 'editproperties_bulk_categories',
            el: '${prefix}PropertiesCategoriesTable',        
            store: store,
            cm: cm,
            plugins: [${prefix}PCT_Selectable],   
            enableColLock: true,
            loadMask: true,
            autoExpandColumn: 'name',
            viewConfig: {
                forceFit: true
            },
            autoHeight: true,    
            autoScroll: true,    
            trackMouseOver: false,
            // inline toolbars
            bbar: [{
                text: '<fmt:message bundle="${messages}" key="changeProperties.selectCategory" />',
                tooltip: '<fmt:message bundle="${messages}" key="changeProperties.selectCategoryTooltip" />',
                iconCls: 'UI ExtButton Add',
                id: '${prefix}_addCategoryBtn'
            }, '-', {
                text: '<fmt:message bundle="${messages}" key="general.removeSelected" />',
                tooltip: '<fmt:message bundle="${messages}" key="changeProperties.removeSelectedCategoriesTooltip" />',
                iconCls: 'UI ExtButton Remove',
                handler: ${prefix}removeSelected
            }]
        });

        // render the grid to the specified div in the page
        editproperties_bulk_categories.render();
    });


//]]>
</script>


<syswf:component name="/core/impl/widget/util/taxonomyBrowserButton" prefix="button">
    <syswf:param name="selectedCategories" value="${this.categoryRows}" />
    <syswf:param name="addCategoryButtonId" value="${prefix}_addCategoryBtn" />
    <syswf:param name="artifactType" value="${artifactType}" />
    <syswf:param name="showButton" value="${false}" />
</syswf:component>