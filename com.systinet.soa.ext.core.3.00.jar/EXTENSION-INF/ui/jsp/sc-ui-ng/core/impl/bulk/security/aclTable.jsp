<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<div id="${prefix}AclTable" class="UI Table"></div>

<syswf:component name="/core/principal/selector" prefix="pricipalSelector">
    <syswf:param name="jsOpenFunction" value="${prefix}selectOwnerWindow" />
    <syswf:param name="holder" value="${holder}" />
    <syswf:param name="overrideselectionModel" value="multiple" />
    <syswf:param name="winOnRenderCallback" value="${null}" passNull="true"/>
</syswf:component>

<syswf:control mode="script" caption="${prefix}removeSelected" action="removeSelected" />

<script type="text/javascript">
${prefix}selectOwner = function() {
    ${saveStateFce}();
    ${prefix}selectOwnerWindow();
}

<c:if test="${not empty winOnRenderCallback}">
function ${winOnRenderCallback}() {
    ${prefix}selectOwnerWindow();
}
</c:if>

        Ext.onReady(function(){
        <syswf:jsonValue var="myData" type="hash">
            <syswf:jsonValue name="data" type="array">
            <c:forEach var="row" items="${holder.acls}" varStatus="status">
            <c:set var="id" value="${status.index}" />
                    <syswf:jsonValue type="hash">
                        <syswf:jsonValue name="select" value="false" />
                        <syswf:jsonValue name="id"><c:out value="${prefix}$${row.principalBean.id}" /></syswf:jsonValue>
                        <syswf:jsonValue name="name"><c:out value="${row.principalBean.name}" /></syswf:jsonValue>
                        <syswf:jsonValue name="type" value="${row.principalBean.label}" />
                        <syswf:jsonValue name="addRead"><syswf:selectOne name="${id}_add_read" value="${row}" property="addRead" mode="checkbox" optionValues="true" optionCaptions=" " dataType="boolean" displayAsRow="true" /><script type="text/javascript">Ext.get('${prefix}_${id}_add_read_0').on("click", function() { pairSelect('${prefix}_${id}_add_read_0','${prefix}_${id}_remove_read_0'); bindForbidden('${prefix}_${id}_add_read_0','${prefix}_${id}_add_write_0'); });</script></syswf:jsonValue>
                        <syswf:jsonValue name="addWrite"><syswf:selectOne name="${id}_add_write" value="${row}" property="addWrite" mode="checkbox" optionValues="true" optionCaptions=" " dataType="boolean" displayAsRow="true" /><script type="text/javascript">Ext.get('${prefix}_${id}_add_write_0').on("click", function() { pairSelect('${prefix}_${id}_add_write_0','${prefix}_${id}_remove_write_0'); bindRequired('${prefix}_${id}_add_write_0','${prefix}_${id}_add_read_0'); });</script></syswf:jsonValue>
                        <syswf:jsonValue name="removeRead"><syswf:selectOne name="${id}_remove_read" value="${row}" property="removeRead" mode="checkbox" optionValues="true" optionCaptions=" " dataType="boolean" displayAsRow="true" /><script type="text/javascript">Ext.get('${prefix}_${id}_remove_read_0').on("click", function() { pairSelect('${prefix}_${id}_remove_read_0','${prefix}_${id}_add_read_0'); bindRequired('${prefix}_${id}_remove_read_0','${prefix}_${id}_remove_write_0'); });</script></syswf:jsonValue>
                        <syswf:jsonValue name="removeWrite"><syswf:selectOne name="${id}_remove_write" value="${row}" property="removeWrite" mode="checkbox" optionValues="true" optionCaptions=" " dataType="boolean" displayAsRow="true" /><script type="text/javascript">Ext.get('${prefix}_${id}_remove_write_0').on("click", function() { pairSelect('${prefix}_${id}_remove_write_0','${prefix}_${id}_add_write_0'); bindForbidden('${prefix}_${id}_remove_write_0','${prefix}_${id}_remove_read_0'); });</script></syswf:jsonValue>
                    </syswf:jsonValue>
                </c:forEach>
            </syswf:jsonValue>
         </syswf:jsonValue>
         var myData = <c:out value="${myData}" escapeXml="false" />;
         
            var store = new Ext.data.JsonStore({
                totalProperty: 'total',
                root: 'data',
                fields: [
                    {name: 'select'},
                    {name: 'id'},
                    {name: 'name'}, 
                    {name: 'type'}, 
                    {name: 'addRead'},
                    {name: 'addWrite'},
                    {name: 'removeRead'},
                    {name: 'removeWrite'}
                ]
            });

            store.loadData(myData);

			var groupheader = new Ext.ux.grid.ColumnHeaderGroup({
				rows: [[{header: ' ', colspan: 3, align: 'center'}, 
					{id: 'acl_add', header: '<fmt:message bundle="${labels}" key="Add" />', dataIndex: 'acl_add_rw', colspan: 2, align: 'center', tooltip: '<fmt:message bundle="${labels}" key="Add" />'}, 
					{id: 'acl_remove', header: '<fmt:message bundle="${labels}" key="Remove" />', dataIndex: 'acl_remove_rw', colspan: 2, align: 'center', tooltip: '<fmt:message bundle="${labels}" key="Remove" />'}]]
			});
	
            var cm = new Ext.grid.ColumnModel([{
                id: 'select',
                dataIndex: 'select',
                width: 25,
                header: "",
                menuDisabled: true,
                hideable: false,
                sortable: false,
                resizable: false,
                renderer: Datagrid.Renderer.Checkbox
            },{
                id: 'name',
                dataIndex: 'name',
                sortable: true,
                header: '<fmt:message bundle="${labels}" key="Name" />'
            }, {
                id: 'type',
                dataIndex: 'type',
                header: '<fmt:message bundle="${labels}" key="Type" />',
                width: 50,
                sortable: true
            }, {
                id: 'addRead',
                dataIndex: 'addRead',
                header: '<fmt:message bundle="${labels}" key="Read" />',
                tooltip: '<fmt:message bundle="${labels}" key="Read" />',
                sortable: true,
                resizable: false,
                menuDisabled: true,
                hideable: false,
                align: 'center',
                width: 50
            }, {
                id: 'addWrite',
                dataIndex: 'addWrite',        
                header: '<fmt:message bundle="${labels}" key="Write" />',
                tooltip: '<fmt:message bundle="${labels}" key="Write" />',
                sortable: true,
                resizable: false,        
                menuDisabled: true,
                hideable: false,
                align: 'center',        
                width: 50
            }, {
                id: 'removeRead',
                dataIndex: 'removeRead',
                header: '<fmt:message bundle="${labels}" key="Read" />',
                tooltip: '<fmt:message bundle="${labels}" key="Read" />',
                sortable: true,
                resizable: false,        
                menuDisabled: true,
                hideable: false,
                align: 'center',        
                width: 50
            }, {
                id: 'removeWrite',
                dataIndex: 'removeWrite',
                header: '<fmt:message bundle="${labels}" key="Write" />',
                tooltip: '<fmt:message bundle="${labels}" key="Write" />',
                sortable: true,
                resizable: false,        
                menuDisabled: true,
                hideable: false,
                align: 'center',        
                width: 50    
            }, {
                id: 'acl_add',
                dataIndex: 'acl_add_rw',
                hidden: true, 
                resizable: false,        
                hideable: false,
                menuDisabled: true
            }, {
                id: 'acl_remove',
                dataIndex: 'acl_remove_rw',
                hidden: true,
                resizable: false,        
                hideable: false,
                menuDisabled: true
            }]);
            cm.defaultSortable = true;
            
            var ${prefix}Selectable = new Ext.ux.plugins.MakeSelectable();
            
            var ${prefix}dg_accessrights = new Ext.grid.GridPanel({
                id: 'bulk_accessrights',
                el: '${prefix}AclTable',        
                store: store,
                cm: cm,
                plugins: [${prefix}Selectable],    
                enableColLock: true,
                loadMask: true,
                plugins: [groupheader],
                autoExpandColumn: 'name',
                viewConfig: {
                    forceFit: true
                },
                width: 623,
                autoHeight: true,
                autoScroll: true,
                trackMouseOver: false,
                listeners: {
                    'render': {
                        fn: function() {
                            setHdColumnsBackground(this);
                            Datagrid.Utils.ParseScripts(${prefix}dg_accessrights, '${prefix}AclTable');
                            ${prefix}dg_accessrights.getView().refresh();
                        }
					},
					'sortchange': {
                        fn: function() {
                            setHdColumnsBackground(this);
                            Datagrid.Utils.ParseScripts(${prefix}dg_accessrights, '${prefix}AclTable');
                            ${prefix}dg_accessrights.getView().refresh();
                        }
					}
                },
                bbar: [{
                    text: '<fmt:message bundle="${messages}" key="changeAcl.addPrincipal" />',
                    tooltip: '<fmt:message bundle="${messages}" key="changeAcl.addPrincipalTooltip" />',
                    iconCls: 'UI ExtButton Add',
                    ctCls:' x-btn-highlight',
                    id: 'select_actor',
                    handler: ${prefix}selectOwner
                }, '-', {
                    text: '<fmt:message bundle="${messages}" key="general.removeSelected" />',
                    tooltip: '<fmt:message bundle="${messages}" key="changeAcl.removeSelectedTooltip" />',
                    iconCls: 'UI ExtButton Remove',
                    ctCls:' x-btn-highlight',
                    handler: ${prefix}removeSelected
                }]        
            });

            ${prefix}dg_accessrights.render();
        });

        function toggleRemoveColumn(dg) {
            var cm = dg.getColumnModel();
            var colIdx_r = cm.findColumnIndex('removeRead');
            var colIdx_w = cm.findColumnIndex('removeWrite');
            // change headers
            var hdr_cell_r = Ext.get(dg.getView().getHeaderCell(colIdx_r));
            hdr_cell_r.toggleClass('x-grid3-hd-disabled');

            var hdr_cell_w = Ext.get(dg.getView().getHeaderCell(colIdx_w));
            hdr_cell_w.toggleClass('x-grid3-hd-disabled');    
            
            var hdr_cell_rw = Ext.get(dg.getView().mainHd.query('td.x-grid3-td-acl_remove'));
            hdr_cell_rw.each(function(cell) {
                cell.toggleClass('x-grid3-hd-disabled');
            });
            
            // change rows
            var row = 0;
            dg.getStore().each(function(record) {
                var cell_r = Ext.get(dg.getView().getCell(row, colIdx_r));
                var input_r = cell_r.select('input');
                var cell_w = Ext.get(dg.getView().getCell(row, colIdx_w));
                var input_w = cell_w.select('input');
                
                if (!record.disabled) {
                    cell_r.addClass('x-grid3-cell-disabled');
                    cell_w.addClass('x-grid3-cell-disabled');
                    
                    input_r.each(function(el, scope, index) {
                        el.dom.disabled = true;
                    });
                    input_w.each(function(el, scope, index) {
                        el.dom.disabled = true;
                    });
                    
                    record.disabled = true;
                } else {
                    cell_r.removeClass('x-grid3-cell-disabled');
                    cell_w.removeClass('x-grid3-cell-disabled');
                    
                    input_r.each(function(el, scope, index) {
                        el.dom.disabled = false;
                    });
                    input_w.each(function(el, scope, index) {
                        el.dom.disabled = false;
                    });
                    
                    record.disabled = false;
                }
                
                row++;
            });
        }

        function setHdColumnsBackground(dg) {
            var cm = dg.getColumnModel();
            
            var col_add_r = cm.findColumnIndex('addRead');
            var hd_cell_add_r = Ext.get(dg.getView().getHeaderCell(col_add_r));
            hd_cell_add_r.addClass('x-grid3-hd-add');
                        
            var col_add_w = cm.findColumnIndex('addWrite');
            var hd_cell_add_w = Ext.get(dg.getView().getHeaderCell(col_add_w));
            hd_cell_add_w.addClass('x-grid3-hd-add');   
            
			var col_add_rw = cm.findColumnIndex('acl_add_rw');  
            var hd_cell_add_rw = Ext.get(dg.getView().mainHd.query('td.x-grid3-td-' + cm.getColumnId(col_add_rw)));
            hd_cell_add_rw.each(function(cell) {
                cell.toggleClass('x-grid3-hd-add');
            });

            var col_rem_r = cm.findColumnIndex('removeRead');
            var hd_cell_rem_r = Ext.get(dg.getView().getHeaderCell(col_rem_r));
            hd_cell_rem_r.addClass('x-grid3-hd-remove');
            var col_rem_w = cm.findColumnIndex('removeWrite');
            var hd_cell_rem_w = Ext.get(dg.getView().getHeaderCell(col_rem_w));
            hd_cell_rem_w.addClass('x-grid3-hd-remove');    

            var col_remove_rw = cm.findColumnIndex('acl_remove_rw');    
            var hd_cell_remove_rw = Ext.get(dg.getView().mainHd.query('td.x-grid3-td-' + cm.getColumnId(col_remove_rw)));
            hd_cell_remove_rw.each(function(cell) {
                cell.toggleClass('x-grid3-hd-remove');
            });
        }
                

        function pairSelect(first, second) {
            if (Ext.get(first).dom.checked==true) {
                Ext.get(second).dom.checked=false;
            }
        }
        
        function bindRequired(first, second) {
            if (Ext.get(first).dom.checked==true) {
                Ext.get(second).dom.checked=true;
            }
        }
        
        function bindForbidden(first, second) {
            if (Ext.get(first).dom.checked==false) {
                Ext.get(second).dom.checked=false;
            }
        }
        

</script>