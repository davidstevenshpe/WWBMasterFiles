<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--
input paramentres:
   * sdmName or sdmNameList - artifact sdm name or list of artifact sdm names - required; properties are gathered from this artifact(s)
   * propertyListSelectionListener - listener for properties selection; =com.hp.systinet.sc.ui.util.SelectionListener=
   * showRelated - should be relational properties offered
   * sections - enables dropdown for selecting group (properties will be added to this group; parameter in listener interface)
--%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.utilmessages" var="bundle"/>

<c:choose>
    <c:when test="${not empty sections and showAddToSection eq 'true'}">
        <c:set var="showDropDown" value="true" />
    </c:when>
    <c:otherwise>
        <c:set var="showDropDown" value="false" />
    </c:otherwise>
</c:choose>

<syswf:control mode="script" caption="functionAdd" action="selectAction"/>

<syswf:jsonValue var="myData" type="hash">
    <syswf:jsonValue name="total" value="${fn:length(propertyListWrapper.properties)}" />
        <syswf:jsonValue name="data" type="array">
            <c:forEach var="property" items="${propertyListWrapper.properties}" varStatus="status">
                <syswf:jsonValue type="hash">
                    <syswf:jsonValue name="id">
                        <syswf:selectOne mode="checkbox"
                                         id="propertySelector_${status.index}"
                                         name="propertySelector_${status.index}"
                                         optionValues="true" optionCaptions=""
                                         value="${property}" property="selected"/>
                    </syswf:jsonValue>
                    <syswf:jsonValue name="name">
                        ${property.label}
                        <%-- label is not beacause filtering is not working with label
                        <label for="propertySelector_${status.index}">${property.label}</label>
                        --%>
                    </syswf:jsonValue>
                </syswf:jsonValue>
            </c:forEach>
        </syswf:jsonValue>
</syswf:jsonValue>

<table class="UI Table Properties">
    <col />
    <tr>
        <td>
            <syswf:input id="${prefix}_filterExpression" name="filterExpression" property="filterExpression" value="${propertyListWrapper}"/>
            <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function() {
                    var input = new Ext.form.TextField({
                        id: '${prefix}_filterExpression',
                        applyTo: '${prefix}_filterExpression',
                        emptyText: '<fmt:message key="propertySelector.input.emptyText" bundle="${bundle}"/>',
                        width:274,
                        enableKeyEvents:true
                    });
                    
                    input.on('keyup',function(){
                        // Handle the filtering
                        var grid = Ext.getCmp('${prefix}_customize_add_column_list');
                        var searchString = input.getValue();
                        grid.store.filter('name',searchString);
                    });
                });
            
//]]>
</script>
        </td>
    </tr>
    <tr>
        <td>
            <div id="${prefix}_customize_add_column_list_container" class="UI Table"></div>
        </td>
    </tr>
</table>
            
<c:if test="${showDropDown}">
<hr  />
<table class="UI Table Properties">
    <col class="LabelCol" />
    <col />
    <tr>
        <td><label for="${prefix}_sectionSelector"><fmt:message key="propertySelector.dropDown.label" bundle="${bundle}"/></label></td>
        <td>
            <syswf:selectOne id="${prefix}_sectionSelector" name="sectionSelector" mode="menu"
                value="${propertyListWrapper}" property="selectedSectionId"
                optionValues="${sections}" optionValuesProperty="value"
                optionCaptions="${sections}" optionCaptionsProperty="label">
            </syswf:selectOne>
            <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                var cmb = new Ext.form.ComboBox({
                    id : '${prefix}_sectionSelector',
                    transform : '${prefix}_sectionSelector',
                    disableKeyFilter : true,
                    mode : 'local',
                    autoHeight : true,
                    resizable : true,
                    listWidth : 174,
                    width : 174,
                    editable:false,
                    triggerAction : 'all'
                });
            });
            
//]]>
</script>
        </td>
    </tr>
</table>
</c:if>

<script type="text/javascript">
//<![CDATA[

Ext.onReady(function(){
    var store = new Ext.data.JsonStore({
        totalProperty: 'total',
        root: 'data',
        fields: [
            {name:'id'},
            {name:'name'}
        ],
        sortInfo: {field: 'name', direction: 'ASC'},
        remoteSort: false
    });

    store.loadData(${myData});
    
    var rawcols = [
        {id:'id',header: "&nbsp;", width: 28, sortable: false, dataIndex: 'id'},
        {id:'name',header: "Name",width:196, sortable: false, dataIndex: 'name'}
    ];
    
    var ${prefix}CACL_Selectable = new Ext.ux.plugins.MakeSelectable();
    
    var grid = new Ext.grid.GridPanel({
        id: '${prefix}_customize_add_column_list',
        el: '${prefix}_customize_add_column_list_container',
        store: store,
        cm: new Ext.grid.ColumnModel(rawcols),
        plugins: [${prefix}CACL_Selectable],
        loadMask: false,

        <c:choose>
            <c:when test="${showDropDown}">
        height: 190,
            </c:when>
            <c:otherwise>
        height: 230,
            </c:otherwise>
        </c:choose>
        
        hideHeaders:true,
        viewConfig:{
            forceFit:true
        },
		autoScroll: true,
        autoExpandColumn: 'name',
        
        listeners: {
            bodyresize: function(grid) {
                // FIXME !!! 
                grid.getEl().select('.'+grid.bodyCls).item(0).setHeight(190);
                grid.setWidth(275);
            }
        }
    });
    
    grid.render();

});

//]]>
</script>