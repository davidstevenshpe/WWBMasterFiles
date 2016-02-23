<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<!-- Div for rendering of the table -->
<div id="${prefix}PropertiesKeywordsTable" class="UI Table"></div>

<syswf:control mode="script" caption="${prefix}selectKeyword" action="selectKeyword" affects=".." />
<syswf:control mode="script" caption="${prefix}removeSelected" action="removeSelected" />

<syswf:component name="/core/keywords/keywordsSelector" prefix="keywordsSelector">
    <syswf:param name="jsOpenFunction" value="${prefix}selectKeywordsWindowFce" />
    <syswf:param name="keywordsSelectorListener" value="${this.keywordsHolder}" />
    <syswf:param name="clearSelection" value="${true}" />
</syswf:component>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){
    <syswf:jsonValue var="myData" type="hash">
        <syswf:jsonValue name="data" type="array">
            <c:forEach var="row" items="${keywords}" varStatus="status">
                <c:set var="id" value="kwd_${status.index}" />
                <c:set var="rowId">${row.id}</c:set>
                <syswf:jsonValue type="hash">
                    <syswf:jsonValue name="select"><syswf:selectOne name="${rowId}" value="" mode="checkbox" optionCaptions=" " optionValues="true" displayAsRow="true" /></syswf:jsonValue>
                    <syswf:jsonValue name="keyword"><span><c:out value="${row.keyword.keyword}" /></span></syswf:jsonValue>
                    <syswf:jsonValue name="addKeyword"><syswf:selectOne name="${id}_add" value="${row}" property="property" mode="radio" optionValues="add" optionCaptions=" " displayAsRow="true" /></syswf:jsonValue>
                    <syswf:jsonValue name="removeKeyword"><syswf:selectOne name="${id}_add" value="${row}" property="property" mode="radio" optionValues="rem" optionCaptions=" " displayAsRow="true" /></syswf:jsonValue>
                </syswf:jsonValue>
            </c:forEach>
        </syswf:jsonValue>
     </syswf:jsonValue>

        var ${prefix}store = new Ext.data.JsonStore({
                    totalProperty: 'total',
                    root: 'data',
                    fields: [
                         {name: 'select'},
                         {name: 'id'},
                         {name: 'keyword'}, 
                         {name: 'addKeyword'},
                         {name: 'removeKeyword'}
                     ],
                         sortInfo: {
                             field: 'keyword', 
                             direction: 'ASC'
                         },
                         remoteSort: false
            });

        var myData = ${myData};
        
        ${prefix}store.loadData(myData);

        var ${prefix}cm = new Ext.grid.ColumnModel([{
                id: 'select', 
                dataIndex: 'select', 
                header: "", 
                width: 25, 
                sortable: false, 
                resizable: false, 
                menuDisabled: true, 
                hideable: false
            },{
                id: 'keyword', 
                dataIndex: 'keyword', 
                header: '<fmt:message bundle="${labels}" key="Keyword" />', 
                width: 170, 
                sortable: true
            },{
                id: 'add_cat', 
                dataIndex: 'addKeyword', 
                header: '<fmt:message bundle="${labels}" key="Add" />', 
                width: 50, 
                sortable: false, 
                menuDisabled: true, 
                resizable: false, 
                hideable: false, 
                align: 'center'
            },{
                id: 'rem_cat', 
                dataIndex: 'removeKeyword', 
                header: '<fmt:message bundle="${labels}" key="Remove" />',
                width: 50, 
                sortable: false, 
                menuDisabled: true, 
                resizable: false, 
                hideable: false, 
                align: 'center'
            }]);

        ${prefix}cm.defaultSortable = true;
        
        var ${prefix}EBK_Selectable = new Ext.ux.plugins.MakeSelectable();
                
        var ${prefix}editproperties_bulk_keywords = new Ext.grid.GridPanel({
                id: 'editproperties_bulk_keywords',
                el: '${prefix}PropertiesKeywordsTable',           
                store: ${prefix}store,
                cm: ${prefix}cm,
                plugins: [${prefix}EBK_Selectable],
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
                    text: '<fmt:message bundle="${labels}" key="Add" />',
                    tooltip: '<fmt:message bundle="${messages}" key="changeProperties.addKeywordTooltip" />',
                    iconCls: 'UI ExtButton Add',
                       handler: ${prefix}selectKeywordsWindowFce
                }, '-', {
                    text: '<fmt:message bundle="${messages}" key="general.removeSelected" />',
                    tooltip: '<fmt:message bundle="${messages}" key="changeProperties.removeSelectedKeywordTooltip" />',
                    iconCls: 'UI ExtButton Remove',
                    handler: ${prefix}removeSelected
                }]
            });

        // render the grid to the specified div in the page
        ${prefix}editproperties_bulk_keywords.render();
    });

//]]>
</script>
