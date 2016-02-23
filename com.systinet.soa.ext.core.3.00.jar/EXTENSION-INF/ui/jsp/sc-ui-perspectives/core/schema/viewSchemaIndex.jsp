<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.schema.schemaMessages" var="schemaMessages"/>
<fmt:message var="nameLabel" key="schema.name" bundle="${schemaMessages}"/>
<fmt:message var="constructTypeLabel" key="schema.constructType" bundle="${schemaMessages}"/>
<fmt:message var="definedInLabel" key="schema.definedIn" bundle="${schemaMessages}"/>
<fmt:message var="namespaceLabel" key="schema.namespace" bundle="${schemaMessages}"/>
<fmt:message var="constructLabel" key="schema.construct" bundle="${schemaMessages}"/>
<fmt:message var="constructsLabel" key="schema.constructs" bundle="${schemaMessages}"/>

<div class="UI Table">
    <div id="${prefix}Table" ></div>
</div>

    <syswf:jsonValue var="myData" type="hash">
        <syswf:jsonValue name="records" type="array">
            <c:forEach var="element" items="${xsdModel.elements}" varStatus="status">
                <c:set var="name">
                    <c:choose>
                        <c:when test="${empty element.typeClass or 'userdef' == element.typeClass}" >
                            <a href="javascript:void(0);" 
                               onclick="${goToFunction}({elementViewType: 'schemaElement', elementUuid: '${uuid}', elementRevision: '${revision}', elementLocalName: '${element.localName}', elementNamespace: '${element.namespace}', elementType: '${element.type}'})" >
                                <syswf:out value="${element.localName}" context="HtmlBody"/></a>
                        </c:when>
                        <c:otherwise>
                            <syswf:out value="${element.localName}" context="HtmlBody"/>
                        </c:otherwise>
                    </c:choose>
                </c:set>
                <syswf:jsonValue type="hash">
                    <syswf:jsonValue name="id" value="${status.index}" />
                    <syswf:jsonValue name="name" value="${name}" />
                    <syswf:jsonValue name="namespace" value="${element.namespace}" />
                    <syswf:jsonValue name="definedIn" value="${element.definedIn}" />
                    <syswf:jsonValue name="type" value="${element.type}" />
                    <syswf:jsonValue name="documentation" value="${element.documentation}"/>
                </syswf:jsonValue>
            </c:forEach>
        </syswf:jsonValue>
     </syswf:jsonValue>
         
<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){

         
         var myData = ${myData};
         //myData = scTableUnescapeJSON(myData);

         var reader = new Ext.data.JsonReader({
            root:'records',
            totalProperty: 'total',
            id: 'id',  
            fields: [
                     {name: 'id'},
                     {name: 'name'},
                     {name: 'namespace'},
                     {name: 'definedIn'},
                     {name: 'type'},
                     {name: 'documentation'} 
              ] 
          });

         
        
        var store = new Ext.data.GroupingStore({ 
            reader: reader, 
            sortInfo: {field: 'name', direction: 'ASC'},
            groupField: 'type'
         });
        store.loadData(myData);
    
        var cm = new Ext.grid.ColumnModel([
            {
                id: 'name',
                dataIndex: 'name',
                sortable: true,
                header: '${nameLabel}'
            },{
                id: 'type',
                dataIndex: 'type',
                sortable: true, 
                header: "${constructTypeLabel}", 
                hidden:true
            }, {
                id: 'namespace',
                dataIndex: 'namespace',
                sortable: true,
                header: "${namespaceLabel}"
            }, {
            	id: 'definedIn',
                dataIndex: 'definedIn',
                sortable: true,
                header: "${definedInLabel}"
            }
        ]);
        
        cm.defaultSortable = true;
        
        var ${tableId}Selectable = new Ext.ux.plugins.MakeSelectable();
        
        var ${prefix}dg_accessrights = new Ext.grid.GridPanel({
            id: '${tableId}',
            el: '${prefix}Table',        
            store: store,
            cm: cm,
            plugins: [${tableId}Selectable],
            view: new Ext.grid.GroupingView({
                forceFit:true,
                groupTextTpl: '{text} ({[values.rs.length]} {[values.rs.length > 1 ? "${constructsLabel}" : "${constructLabel}"]})'
            }),
            enableColLock: true,
            loadMask: true,
            autoExpandColumn: 'name',
            autoHeight: true,
            autoScroll: true,
            trackMouseOver: false,
            listeners: {
                'render': {
                    fn: function() {
                        Datagrid.Utils.ParseScripts(${prefix}dg_accessrights, '${prefix}Table');
                        ${prefix}dg_accessrights.getView().refresh();
                        ${prefix}dg_accessrights.doLayout();
                    }
                }
            }    
        });
    
        ${prefix}dg_accessrights.render();
    });

//]]>
</script>
