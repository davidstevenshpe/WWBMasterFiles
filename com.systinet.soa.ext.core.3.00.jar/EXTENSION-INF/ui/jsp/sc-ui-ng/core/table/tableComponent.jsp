<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.uimessages" var="uiMessages"/>
<fmt:message key="TABLE_COMPONENT_SHOW_PREVIEW" bundle="${uiMessages}" var="showPreviewLabel"/>
<fmt:message key="TABLE_COMPONENT_HIDE_PREVIEW" bundle="${uiMessages}" var="hidePreviewLabel"/>
<fmt:message key="TABLE_COMPONENT_RESET" bundle="${uiMessages}" var="resetLabel"/>
<fmt:message key="TABLE_COMPONENT_RESET_HINT" bundle="${uiMessages}" var="resetHint"/>
<fmt:message key="TABLE_COMPONENT_STATUS" bundle="${uiMessages}" var="statusLabel"/>
<fmt:message key="TABLE_COMPONENT_FILTER_HINT" bundle="${uiMessages}" var="filterHint"/>
<fmt:message key="TABLE_COMPONENT_APPLY_FILTER" bundle="${uiMessages}" var="filterApply"/>
<fmt:message key="TABLE_COMPONENT_CANCEL_FILTER" bundle="${uiMessages}" var="filterCancel"/>
<fmt:message key="TABLE_COMPONENT_PAGE_SIZE" bundle="${uiMessages}" var="pageSizeLabel"/>
<fmt:message key="TABLE_COMPONENT_PAGE_SIZE_HINT" bundle="${uiMessages}" var="pageSizeHint"/>

<div class="UI Block Green">
	<c:if test="${contentInfo.couldHaveContent}">
	    <c:set var="facets">
	        <syswf:component name="/core/impl/table/facets" prefix="ffcp">
	          <syswf:param name="datasource" value="${datasourceInstance}"/>
	          <syswf:param name="facets" value="${facets}"/>
	          <syswf:param name="tableId" value="${tableId}"/>
	        </syswf:component>
	    </c:set>
	
	    <c:set var="dataComponent">
	        <%-- here we populate table with data, this component is designed to be refreshable by ajax --%>
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
	            <syswf:param name="componentStateId" value="${componentStateId}"/>
	            <syswf:param name="checkedSelectionBag" value="${checkedSelectionBag}"/>
	        </syswf:component>
	    </c:set>
	</c:if>
	
	<c:set var="hasActions" value="${(not empty actions && not contentInfo.hasContent) || (hasSelection && not empty table.rowId) || (contentInfo.hasContent && (empty actions || !actions.disableExports))}" />
	
	<%-- Place actions after data component to ensure correct order of populating --%>
	
	<c:if test="${hasActions}">
	    <syswf:component prefix="toolbar" name="/core/impl/table/actions">
	        <syswf:param name="actions" value="${actions}"/>
	        <syswf:param name="tableId" value="${tableId}"/>
	        <syswf:param name="selectionBag" value="${selectionBag}"/>
	        <syswf:param name="contentInfo" value="${contentInfo}"/>
	        <syswf:param name="selectionMode" value="${table.selectionModel}"/>
	        <syswf:param name="datasource" value="${datasourceInstance}"/>
	        <syswf:param name="tableColumns" value="${table.dataColumns}"/>
	        <syswf:param name="tableGroupColumns" value="${table.columns}"/>
	        <syswf:param name="rowPreview" value="${table.rowPreview}"/>
	    </syswf:component>
	
	    <c:if test="${not contentInfo.hasContent}">
	        <div id="${tableId}Toolbar"></div>
	        <script type="text/javascript">
	//<![CDATA[
	 
	        Ext.onReady(function(){
	            if (${tableId}Toolbar.length > 0) {
	                var tb = new Ext.Toolbar();
	                tb.add(${tableId}Toolbar);
	                tb.render('${tableId}Toolbar');
	            }
	        });
	        
	//]]>
	</script>
	    </c:if>
	</c:if>
	
	<c:if test="${contentInfo.couldHaveContent}">
	    <c:choose>
	    <c:when test="${contentInfo.hasContent}">
	        <c:out value="${facets}" escapeXml="false"/>
	        <c:if test="${table.filter == 'hidden' && contentInfo.multipage}">
	            <c:choose>
	                <c:when test="${not hasFilter}">
	                    <syswf:control mode="postAnchor" caption="Show filter" action="showFilter"/>
	                </c:when>
	                <c:otherwise>
	                    <syswf:control mode="postAnchor" caption="Hide filter" action="hideFilter"/>
	                </c:otherwise>
	            </c:choose>
	        </c:if>
	
	        <div class="UI Table"><div id="<c:out value="${tableId}"/>Container"></div></div>
	
	        <syswf:control mode="script" id="saveState" caption="${tableId}_submit" affects="${prefix}_data"/>
	        <syswf:control mode="script" caption="${tableId}_reset" action="resetPreferences" affects="." id="${tableId}_reset"/>
	
	        <syswf:component prefix="editPageSize" name="/core/impl/table/pagesize/editPageSize">
	            <syswf:param name="openFce" value="${tableId}_changePageSize"/>
	            <syswf:param name="kind" value="${kind}"/>
	            <syswf:param name="affects" value="${prefix}"/>
	            <syswf:param name="tableId" value="${tableId}"/>
	            <syswf:param name="showButton" value="false"/>
	            <syswf:param name="contentInfo" value="${contentInfo}"/>
	        </syswf:component>
	        
	       <script type="text/javascript">
	//<![CDATA[
	
	       var ${tableId}Store = new Ext.data.Store({
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
	            <c:if test="${hasSelection}">
	            {name: '_selection'},
	            </c:if>
	            <c:if test="${hasHighlight}">
	            {name: '_highlightedRow'},
	            </c:if>
	            <c:forEach var="column" items="${table.dataColumns}" varStatus="columnStatus">
	                {name: '${column.id}'}<c:if test="${not columnStatus.last}">, </c:if>
	            </c:forEach>
	            <c:if test="${not empty table.rowPreview}">
	                ,{name: '${table.rowPreview.id}'}
	            </c:if>
	          ]),
	          sortInfo:{field: '${order.tableColumn}', direction: <c:choose><c:when test="${order.ascending}">'ASC'</c:when><c:otherwise>'DESC'</c:otherwise></c:choose>},
	          remoteSort: true,
	          proxy: new Ext.data.SCSubmitProxy("${prefix}_data", ${tableId}_submit)
	        });
	        <c:if test="${hasSelection}">
	            <c:set var="headerSelectWidth" value="36" />
	            <c:choose>
	                <c:when test="${table.selectionModel == 'one'}">
	                    <c:set var="selectAllCheckbox">'&nbsp;'</c:set>
	                </c:when>
	                <c:otherwise>
	                    <c:choose>
	                        <c:when test="${enableSelectAll && contentInfo.multipage}">
	                            <c:set var="selectAllCheckboxId" value="${tableId}_selectAll_checkbox" />
	                            <c:set var="selectAllCheckbox">
	                                scTableUnescapeString('#gt;div id="${tableId}_chbox_selectall_ct" class="x-btn-multiselect"#lt;#gt;/div#lt;#gt;script type="text/javascript"#lt;var button = new Ext.HP.CheckSplitButton({id: "${tableId}_selectAll", text: "", renderTo: "${tableId}_chbox_selectall_ct",  menu: new Ext.menu.Menu({ items: [] }) });var item = button.menu.addItem(new Ext.menu.Item({id: "${tableId}_selectallitem", href: "javascript:void(0);", text: String.format("<fmt:message key="TABLE_COMPONENT_SELECTALL" bundle="${uiMessages}" />",${tableId}Store.getTotalCount()), handler: function() { chkbox = Ext.get("${selectAllCheckboxId}"); chkbox.dom.checked=true; scTableEnableToolbar("${tableId}",chkbox); ${tableId}ShowLoading(); ${tableId}_selectAll(); }}));new SCSelectAllLabel("<fmt:message key="TABLE_COMPONENT_SELECTALL" bundle="${uiMessages}" />",${tableId}Store,item);Ext.get("${selectAllCheckboxId}").on("click", function() { Datagrid.Handler.SwitchSelectAll(this, "${tableId}Container"); SCsynchronizeSelectionAll("${tableId}Container");<c:if test="${(not empty actions) || ((hasSelection && not empty table.rowId)  || (contentInfo.hasContent && (not empty actions && !actions.disableExports)))}"> var chkbox = Ext.get("${selectAllCheckboxId}"); SCenabledisableToolbar2("${tableId}",chkbox.dom.checked,true);</c:if>});SCsychronizeSelectAllCheckbox("${selectAllCheckboxId}","${tableId}Container","${tableId}", false);var item2 = button.menu.addItem(new Ext.menu.Item({id: "${tableId}_unselectallitem", href: "javascript:void(0);", text: "<fmt:message key="TABLE_COMPONENT_UNSELECTALL" bundle="${uiMessages}" />", handler: function() { chkbox = Ext.get("${selectAllCheckboxId}"); chkbox.dom.checked=false; ${tableId}ShowLoading(); ${tableId}_unselectAll(); SCenabledisableToolbar("${tableId}",chkbox, true);}}));#gt;/script#lt;')
	                            </c:set>
	                            <c:set var="headerSelectWidth" value="60" />
	                        </c:when>
	                        <c:otherwise>
	                            <c:set var="selectAllCheckboxId" value="${tableId}_selectAll" />
	                            <c:set var="selectAllCheckbox">
	                                scTableUnescapeString('#gt;input type="checkbox" id="${tableId}_selectAll" name="${tableId}_selectAll" value="true" style="margin-left: 4px;" class="UI Form Checkbox"/#lt;#gt;script type="text/javascript"#lt;Ext.get("${tableId}_selectAll").on("click",function(){Datagrid.Handler.SwitchSelectAll(this,"${tableId}Container");SCsynchronizeSelectionAll("${tableId}Container");<c:if test="${(not empty actions) || (hasActions)}"> SCenabledisableToolbar2("${tableId}",this.dom.checked,true);</c:if> });SCsychronizeSelectAllCheckbox("${selectAllCheckboxId}","${tableId}Container","${tableId}", false);#gt;/script#lt;')
	                            </c:set>
	                        </c:otherwise>
	                    </c:choose>
	                </c:otherwise>
	            </c:choose>
	        </c:if>
	
	        <c:if test="${hasFilter && contentInfo.multipage || table.filter == 'visible'}">
	            var ${tableId}Filters = new Ext.HP.GridFilters({
	                local: true,
	                filters: [
	                    <c:forEach var="column" items="${flatColumns}" varStatus="columnStatus">
	                    {
	                        <c:if test="${hasFilter && not empty filterableColumns[column.id] && (contentInfo.multipage || table.filter == 'visible')}">
	                        filter: {
	                            <c:set var="columnFilterWidget" value="${filterableColumns[column.id]}"/>
	                            <c:choose>
	                                <c:when test="${not empty columnFilterWidget.component}">
	                                    id: '${tableId}_${column.id}',
	                                    xtype: '<c:choose><c:when test="${not empty columnFilterWidget.filterUiType}"><c:out value="${columnFilterWidget.filterUiType}"/></c:when><c:otherwise>hpddbutton</c:otherwise></c:choose>',
	                                    name: '${tableId}_${column.id}',
	                                    listWidth: 203,
	                                    content: '${tableId}_${column.id}_src',
	                                    buttons: [{
	                                        id: '${tableId}_${column.id}_ok_button',                                    
	                                        text: '${filterApply}',
	                                        handler: function() {
	                                            var fb = Ext.getCmp('${tableId}-${column.id}');
	                                            if (fb) {
	                                                fb.list.toggle();
	                                            }
	                                            ${tableId}ShowLoading();
	                                            ${tableId}_${column.id}_applyFilter();
	                                        }
	                                    }, {
	                                        text: '${filterCancel}'
	                                    }]
	                                </c:when>
	                                <c:otherwise>
	                                    //id: '${tableId}_${column.id}',
	                                    xtype: '<c:choose><c:when test="${not empty columnFilterWidget.filterUiType}"><c:out value="${columnFilterWidget.filterUiType}"/></c:when><c:otherwise>hpfilterfield</c:otherwise></c:choose>',
	                                    name: '${column.id}'//,
	                                    //emptyText: '${filterHint}'
	                                    <c:if test="${(not empty contentInfo.stateHolder) and (not empty contentInfo.stateHolder.filterValues[column.id]) and (not empty contentInfo.stateHolder.filterValues[column.id].value)}">,value:'<c:out value="${contentInfo.stateHolder.filterValues[column.id].value}"/>'</c:if>
	                                </c:otherwise>
	                            </c:choose>
	                        },
	                        </c:if>
	                        dataIndex:'${column.id}'
	                    }<c:if test="${not columnStatus.last}">,</c:if>
	                    </c:forEach>
	                ]
	            });
	       </c:if>
	
	
	        <c:if test="${hasColumnGroups}">
	           var ${tableId}GroupHeader = new Ext.ux.grid.ColumnHeaderGroup ({
	               rows: [[
	                   <c:forEach var="colHeader" items="${columnGroupHeaders}" varStatus="hStatus">
	                       {colspan: ${colHeader.colspan}<c:if test="${not empty colHeader.id}">, dataIndex: '${colHeader.id}', header: '<c:out value="${colHeader.label}"/>'<c:if test="${not empty colHeader.description}">, tooltip: '<c:out value="${colHeader.description}"/>'</c:if></c:if>, align: 'left', menuDisabled: true}<c:if test="${not hStatus.last}">,</c:if>
	                   </c:forEach>
	               ]],
	               hierarchicalColMenu: true
	           });             
	        </c:if>        
	
	        <c:set var="useExpander" value="${hasExpander and (not empty table.rowPreview)}"/>
	        
	        <c:if test="${useExpander}">
	            <c:set var="expanderTemplate">
	                '{${table.rowPreview.id}}'
	            </c:set>
	        
	            var ${tableId}Expander = new Ext.ux.grid.RowExpander({
	                childrenColName: '${table.rowPreview.id}',
	                tpl : new Ext.XTemplate(
	                    ${expanderTemplate}
	                )
	            });
	        </c:if>
	
	        var ${tableId}Columns = <c:if test="${not empty useExtColumnModel}">new Ext.grid.ColumnModel({ columns: </c:if>[
	            <c:if test="${useExpander}">
	            ${tableId}Expander,
	            </c:if>
	             <c:if test="${hasSelection}">
	             {header:${selectAllCheckbox}, width:${headerSelectWidth}, dataIndex:'_selection', id:'_selection', sortable:false, menuDisabled:true, fixed: true, resizable: false, hideable: false},
	             </c:if>
	             <c:forEach var="column" items="${flatColumns}" varStatus="columnStatus">
	            {dataIndex:'${column.id}', header:'<syswf:out value="${column.label}" context="HtmlJSHtml"/>', id:'${column.id}'
	                    <c:forEach var="property" items="${column.properties}">
	                       ,${property.name}: ${property.javascriptValue}
	                    </c:forEach>
	                  }<c:if test="${not columnStatus.last}">,</c:if>
	                 </c:forEach>
	                ]<c:if test="${not empty useExtColumnModel}">})</c:if>;
	
	            <c:choose>
	                <c:when test="${(not empty actions) || (hasActions)}">
	                    <c:choose>
	                      <c:when test="${actions.displayOnBottom && contentInfo.hasContent && !contentInfo.multipage}">
	                        <c:set var="pager" value="${false}"/>
	                      </c:when>
	                      <c:otherwise>
	                        <c:set var="pager" value="${true}"/>
	                      </c:otherwise>
	                    </c:choose>
	                </c:when>
	                <c:otherwise>
	                    <c:set var="pager" value="${true}"/>
	                </c:otherwise>
	            </c:choose>
	
	            var ${tableId}PagingToolbar = new Ext.SCPagingToolbar({
	                store: ${tableId}Store,
	                pageSize: ${paginator.count},
	                displayInfo: true,
	                displayMsg: '${statusLabel}&nbsp;'
	                , items:[
	                    <c:if test="${(not empty table.rowPreview) && pager && (not useExpander)}">
	                        '-', {
	                            pressed: <c:choose>
	                                <c:when test="${table.rowPreview.propertiesAsMap['visible']}">true</c:when>
	                                <c:otherwise>false</c:otherwise>
	                            </c:choose>,
	                            enableToggle:true,
	                            text: <c:choose>
	                                <c:when test="${table.rowPreview.propertiesAsMap['visible']}">'${hidePreviewLabel}'</c:when>
	                                <c:otherwise>'${showPreviewLabel}'</c:otherwise>
	                            </c:choose>,
	                            cls: 'x-btn-text details',
	                            toggleHandler: function(btn, pressed){
	                                var view = ${tableId}grid.getView();
	                                view.showPreview = pressed;
	                                view.refresh();
	                                if (pressed) {
	                                    btn.setText('${hidePreviewLabel}');
	                                } else {
	                                    btn.setText('${showPreviewLabel}');
	                                }
	                                SCsynchronizeSelectionAllReverse("${tableId}Container");
	                            }
	                        },
	                    </c:if>
	                    <c:if test="${showResetButton}">
	                        '-',{
	                            text: '${resetLabel}',
	                            tooltip: '${resetHint}',
	                            cls: 'x-btn-text details',
	                            handler: function(btn, pressed){
	                                ${tableId}_reset();
	                            }
	                        },
	                    </c:if>
	                        '-',{
	                            text: '${pageSizeLabel}',
	                            tooltip: '${pageSizeHint}',
	                            cls: 'x-btn-text details',
	                            handler: function(btn, pressed){
	                                ${tableId}_changePageSize();
	                            }
	                        }
	                ]                
	            });
	
	            var ${tableId}Fit = new Ext.ux.plugins.FitToParent();
	            var ${tableId}Selectable = new Ext.ux.plugins.MakeSelectable();
	
	            var ${tableId}grid;
	            var ${tableId}mask;
	
	            <c:set var="plugins">${tableId}Fit,${tableId}Selectable</c:set>
	            <c:if test="${hasColumnGroups}">
	                <c:set var="plugins">${plugins},${tableId}GroupHeader</c:set>
	            </c:if>
	            <c:if test="${useExpander}">
	                <c:set var="plugins">${plugins},${tableId}Expander</c:set>
	            </c:if>
	            <c:if test="${hasFilter && contentInfo.multipage || table.filter == 'visible'}">
	                <c:set var="plugins">${plugins},${tableId}Filters</c:set>
	            </c:if>
	
	            Ext.onReady(function(){
	
	            if (${tableId}grid) {
	                ${tableId}grid.destroy();
	            }
	
	            ${tableId}grid = new Ext.grid.GridPanel({            
	                id: '${tableId}',
	                store: ${tableId}Store,
	                <c:choose>
	                <c:when test="${not empty useExtColumnModel}">
	                cm : ${tableId}Columns,
	                </c:when>
	                <c:otherwise>
	                columns : ${tableId}Columns,
	                </c:otherwise>
	                </c:choose>
	                //cls: 'x-multiheader-panel',
	                enableColLock: false,
	                el: '${tableId}Container',
	                loadMask: true,
	                disableSelection: false,
	
	                <c:if test="${empty table.propertiesAsMap['autoHeight']}">
	                    autoHeight:true,
	                </c:if>
	                trackMouseOver: false,
	                plugins: [${plugins}],
	                <c:choose>
	                <c:when test="${not empty useHPGridView}">
	                view: new Ext.HP.GridView({
	                </c:when>
	                <c:otherwise>
	                viewConfig: {
	                </c:otherwise>
	                </c:choose>
	                    forceFit:true,
	                    enableRowBody:true,
	                    <%--scrollOffset: 0,--%>
	                    showPreview:<c:choose>
	                                    <c:when test="${(not useExpander) && (not empty table.rowPreview) && (table.rowPreview.propertiesAsMap['visible'])}">true</c:when>
	                                    <c:otherwise>false</c:otherwise>
	                                </c:choose>,
	                    getRowClass : function(record, rowIndex, p, store){
	
	                        <c:choose>
	                        <c:when test="${(not empty table.rowPreview) && (not useExpander)}">
	                        var result = '';
	                        if(this.showPreview){
	                            p.body = '<p class="TextExcerpt">'+record.data.${table.rowPreview.id}+'</p>';
	                            result += 'x-grid3-row-expanded';
	                        } else {
	                            result += 'x-grid3-row-collapsed';
	                        }
	                        </c:when>
	                        <c:otherwise>
	                        var result = 'x-grid3-row-collapsed';
	                        </c:otherwise>
	                        </c:choose>
	                        <c:if test="${hasHighlight}">
	                        if (record.data._highlightedRow) {
	                            result += ' '+record.data._highlightedRow;
	                        }
	                        </c:if>
	                        return result;
	                    }
                        <c:if test="${disableTableSort eq 'true'}">
						, onHeaderClick: function(b, a) {
							// Do-Nothing Here
						},
						handleHdOver: function(c, b) {
							// Do-Nothing Here
						}
						</c:if>
	                }<c:if test="${not empty useHPGridView}">)</c:if>,
	                listeners: {
	                    'render': {
	                        fn: function() {
	                            ${tableId}mask = new Ext.LoadMask(${tableId}grid.el);
	                            ${tableId}mask.show();
	                        }
	                    }
	                },
	                statefull: true,
	                stateId: '${componentStateId}',
	                stateEvents: ["columnmove", "columnresize"]
	                <c:choose>
	                <c:when test="${hasActions}">
	                <c:choose>
	                  <c:when test="${actions.displayOnBottom && contentInfo.hasContent && !contentInfo.multipage}">
	                  ,bbar: ${tableId}Toolbar
	                  </c:when>
	                  <c:otherwise>
	                  ,tbar: ${tableId}Toolbar
	                  ,bbar: ${tableId}PagingToolbar
	                  </c:otherwise>
	                </c:choose>
	                </c:when>
	                <c:otherwise>
	                ,bbar: ${tableId}PagingToolbar
	                </c:otherwise>
	                </c:choose>
	                <c:forEach var="property" items="${table.properties}">
	                   ,${property.name}: ${property.javascriptValue}
	                </c:forEach>
	            });
	
	            Datagrid.Utils.ParseScripts(${tableId}grid, '<c:out value="${tableId}"/>Container');
	            ${tableId}grid.render();
	            
	            ${tableId}grid.on('afterparsescripts',function() {
	                handleNestedWindows(Ext.query('.webfw-Window #${tableId}Container .webfw-Window'));
	                if (${tableId}mask) {
	                    ${tableId}mask.hide();
	                }
	                
	                //add more space between no-paging-toolbar table and footer
	                if(${tableId}PagingToolbar.pageSize >= ${tableId}Store.getTotalCount()){
	                	Ext.get('${tableId}Container').setStyle('margin', '0 0 7px 0');
	                }
	            });
	
	            ${tableId}grid.colModel.on('hiddenchange', function(cm, index, hidden) {
	                if (!hidden) {
	                    ${tableId}ShowLoading();
	                    ${tableId}grid.view.colMenu.hide(true);
	                }
	            });
	            
	            <c:if test="${(not empty actions) || (hasActions)}">
	                if ((typeof ${tableId}Toolbar != 'undefined') && ${tableId}Toolbar.length == 0) {
	                    if (${tableId}grid.getTopToolbar()) {
	                        ${tableId}grid.getTopToolbar().hide();
	                    }
	                }
	            </c:if>
	
	            <c:if test="${not empty parentWindowId}">
	               var parentWindow = SPopup.Window.Instance['${parentWindowId}'];
	               if (!parentWindow) {
	                   parentWindow = Ext.getCmp('${parentWindowId}');
	               }
	               if (parentWindow) {
	                   parentWindow.on('resize', function() {
	                        var cmp = Ext.getCmp('${tableId}');
	                        if (cmp) {
	                            cmp.getEl().setStyle({width: '100%'});
	                            cmp.getGridEl().setStyle({width: '100%'});
	                            cmp.syncSize();
	                        }
	                    });
	                }
	            </c:if>
	            });
	
	            <c:set var="loadingDefined" value="true"/>
	            function ${tableId}ShowLoading() {
	                if (${tableId}grid.loadMask) {
	                    ${tableId}grid.loadMask.show();
	                }
	                if (${tableId}grid.filters) {
	                    ${tableId}grid.filters.disableFilters();
	                }
	
	                return true;
	            }
	
	            function ${tableId}GetPrefix() {
	                return '${prefix}';
	            }
	        
	//]]>
	</script>
	
	        <syswf:component prefix="userState" name="/core/impl/util/componentUserState">
	            <syswf:param name="componentStateId" value="${componentStateId}"/>
	            <syswf:param name="componentStateListener" value="${componentStateListener}"/> 
	        </syswf:component>
	
	        <%-- render markup for complex table filter widgets here --%>
	        <c:if test="${hasFilter && (contentInfo.multipage || table.filter == 'visible')}">
	            <c:forEach var="column" items="${flatColumns}" varStatus="columnStatus">
	                <c:set var="columnFilterWidget" value="${filterableColumns[column.id]}"/>
	                <c:if test="${(not empty columnFilterWidget) and (not empty columnFilterWidget.component)}">
	                    <syswf:component prefix="${column.id}" name="${columnFilterWidget.component}">
	                        <syswf:param name="filterId" value="${tableId}_${column.id}"/>
	                        <syswf:param name="filterContentId" value="${tableId}_${column.id}_src"/>
	                        <syswf:param name="applyFilterControlName" value="${tableId}_${column.id}_applyFilter"/>
	                        <syswf:param name="dataComponentPrefix" value="${prefix}_data"/>
	                        <syswf:param name="model" value="${filterWidgetModels[column.id]}"/>
	                        <syswf:param name="datasource" value="${datasourceInstance}"/>
	                        <syswf:param name="contentInfo" value="${contentInfo}"/> 
	                        <c:if test="${not empty columnFilterWidget.params}">
	                            <c:forEach var="otherParam" items="${columnFilterWidget.params}">
	                                <syswf:param name="${otherParam.name}" value="${otherParam.value}"/>
	                            </c:forEach>
	                        </c:if>
	                    </syswf:component>
	                </c:if>
	            </c:forEach>
	        </c:if>
	
	    </c:when>
	    <c:otherwise>
	        <script type="text/javascript">
	//<![CDATA[
	
	            function ${tableId}ShowLoading() {
	                return true;
	            }
	        
	//]]>
	</script>
	    </c:otherwise>
	    </c:choose>
	
	    <c:out value="${dataComponent}" escapeXml="false"/>
	
	</c:if>
	
	<c:if test="${empty loadingDefined}">
	    <script type="text/javascript">
	//<![CDATA[
	
	        function ${tableId}ShowLoading() {
	            return true;
	        }
	    
	//]]>
	</script>
	</c:if>
	
	<c:if test="${table.selectionModel == 'multiple' && not empty selectAllCheckboxId}">
	    <script type="text/javascript">
	//<![CDATA[
	
	    Ext.onReady(function() {
	        <c:if test="${(not empty actions) || ((hasSelection && not empty table.rowId)  || (contentInfo.hasContent && (not empty actions && !actions.disableExports)))}">
	        SCenabledisableToolbar2('${tableId}',${selectionBag.somethingSelected},true);
	        </c:if>
	    });
	    
	//]]>
	</script>
	</c:if>
	<c:if test="${countRetrievalMethod == 'parallel'}">
	    <syswf:component name="/core/impl/table/countingComponent" prefix="countingComponent">
	        <syswf:param name="datasource" value="${datasourceInstance}"/>
	        <syswf:param name="pagingBar" value="${tableId}PagingToolbar"/>
	        <syswf:param name="store" value="${tableId}Store"/>
	        <syswf:param name="grid" value="${tableId}grid"/>
	        <syswf:param name="tableId" value="${tableId}"/>
	    </syswf:component>
	</c:if>
</div>
<script type="text/javascript">
//<![CDATA[
if(typeof storedTableIds == 'undefined') {
	storedTableIds = [];
}
storedTableIds[storedTableIds.length] = '${tableId}';
//]]>
</script>