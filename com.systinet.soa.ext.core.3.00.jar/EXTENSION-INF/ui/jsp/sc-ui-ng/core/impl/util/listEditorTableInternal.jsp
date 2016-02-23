<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages"/>

<div id="<c:out value="${tableId}"/>Container" class="UI Table"></div>

<%--
<syswf:control mode="script" id="saveState" caption="${tableId}_submit" affects="${prefix}_data"/>
--%>

<c:if test="${not empty selectionListener}">
    <syswf:input id="${prefix}_selected_row_id" name="${prefix}_selected_row_id" property="rowIndex" value="${selectedRowWrapper}" mode="hidden" />
    
    <c:choose>
        <c:when test="${not empty affectedComponent}">
            <%--
            <syswf:control mode="script" action="rowSelected" caption="${prefix}_rowSelected" affects="${affectedComponent}" loadingMask="true"/>
            --%>
            <syswf:control mode="script" action="rowSelected" caption="${prefix}_rowSelected" affects="."/>
        </c:when>
        <c:otherwise>
            <syswf:control mode="script" action="rowSelected" caption="${prefix}_rowSelected"/>
        </c:otherwise>
    </c:choose>

</c:if>

<script type="text/javascript">
//<![CDATA[


var ${tableId}PagingToolbar;
var ${tableId}grid;
var ${tableId}Store;

Ext.onReady(function(){
${tableId}Store = new Ext.data.Store({
  id: '${tableId}DataStore',
  reader: new Ext.data.JsonReader({
    root: 'records',
    totalProperty: 'totalRecords'
    <c:if test="${not empty idColumn}">
    ,
    id: '${idColumn}'
    </c:if>
  },[
    <c:if test="${not empty idColumn}">
    {name: '${idColumn}'},
    </c:if>
    <c:forEach var="column" items="${table.dataColumns}" varStatus="columnStatus">
        {name: '${column.id}'}<c:if test="${not columnStatus.last}">, </c:if>
    </c:forEach>
  ]),
  remoteSort: false
});

var ${tableId}Columns = [
 <c:forEach var="column" items="${flatColumns}" varStatus="columnStatus">
{dataIndex:'${column.id}', header:'${column.label}', id:'${column.id}'
        <c:forEach var="property" items="${column.properties}">
           ,${property.name}: ${property.javascriptValue}
        </c:forEach>
      }<c:if test="${not columnStatus.last}">,</c:if>
     </c:forEach>
    ];

${tableId}PagingToolbar = new Ext.SCPagingToolbar();

var ${tableId}Selectable = new Ext.ux.plugins.MakeSelectable();

${tableId}grid = new Ext.grid.GridPanel({
    id: '${tableId}',
    store: ${tableId}Store,
    header: false,
    plugins: [${tableId}Selectable],
    enableDragDrop : true,
    ddGroup : '${tableId}-dd',  
    ddText : '<fmt:message bundle="${messages}" key="listEditor.dragInfo" />',
    
    columns : ${tableId}Columns,
    hideHeaders : true,
    autoHeight:true,
    el: '${tableId}Container',
    <c:if test="${not empty selectionListener}">
    listeners:{
        'cellclick':function(grid,rowIndex,columnIndex,e){
                      if (columnIndex == 0) {
                          var record = grid.getStore().getAt(rowIndex);
                          var input = Ext.get('${prefix}_selected_row_id');
                          input.dom.value = rowIndex;
                          ${prefix}_rowSelected();
                      }
        },
        'render': {
            fn: function() {
                setSelected();
            }
        }
    },
    </c:if>

});

function setSelected() {
    ${tableId}grid.getSelectionModel().selectRow(0, true);
    ${tableId}grid.getSelectionModel().selectRow(1, true);
}

${tableId}grid.getSelectionModel().singleSelect = true;

Datagrid.Utils.ParseScripts(${tableId}grid, '${tableId}Container', true);
${tableId}grid.render();

var ${tableId}ddrow = new Ext.dd.DropTarget(${tableId}grid.getView().mainBody, {
    ddGroup : '${tableId}-dd',
    notifyDrop : function(dd, e, data){
        var sm = ${tableId}grid.getSelectionModel();
        var rows = sm.getSelections();
        var cindex = dd.getDragData(e).rowIndex;
        if (sm.hasSelection()) {
            for (i = 0; i < rows.length; i++) {
                ${tableId}Store.remove(${tableId}Store.getById(rows[i].id));
                ${tableId}Store.insert(cindex,rows[i]);
                ${positionSaveFunc}({ id : rows[i].id, position: cindex });
            }
            sm.selectRecords(rows);
        }  
    }
});

});

//]]>
</script>

<c:if test="${contentInfo.hasContent}">

    <syswf:component prefix="data" name="/core/impl/table/tableData">
        <syswf:param name="datasource" value="${datasourceInstance}"/>
        <syswf:param name="order" value="${order}"/>
        <syswf:param name="table" value="${table}"/>
        <syswf:param name="selectionBag" value="${selectionBag}"/>
        <syswf:param name="paginator" value="${paginator}"/>
        <syswf:param name="tableId" value="${tableId}"/>
        <syswf:param name="hasFilter" value="${hasFilter}"/>
        <syswf:param name="contentInfo" value="${contentInfo}"/>
        <syswf:param name="enableSelectAll" value="${enableSelectAll}"/>
        <syswf:param name="filterWidgetModels" value="${filterWidgetModels}"/>
        
        <syswf:param name="dontSort" value="true" />
    </syswf:component>

</c:if>


<script type="text/javascript">
//<![CDATA[

Ext.onReady(function(){
    var table = Ext.getCmp('${tableId}');
    table.getSelectionModel().selectRow(0, true);

});

//]]>
</script>