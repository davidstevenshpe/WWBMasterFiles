<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:input id="${prefix}selected" name="selected" mode="hidden" value="${selection}" property="selectedPathAsString"/>

<div id="<c:out value="${prefix}"/>Container">
</div>


<script>
//<![CDATA[
var data${prefix}=
<syswf:component name="/core/impl/tree/table/renderJsonRootNode" prefix="data" wrap="false">
   <syswf:param name="node" value="${node}"/>
   <syswf:param name="table" value="${table}"/>
</syswf:component>;

Ext.onReady(function(){

    var columns=[
            <c:forEach var="column" items="${table.columns}" varStatus="columnStatus">
            {dataIndex:'${column.id}', header:'${column.label}', id:'${column.id}'
               <c:forEach var="property" items="${column.properties}">
                  ,${property.name}: ${property.value}
               </c:forEach>
            }<c:if test="${not columnStatus.last}">,</c:if>
            </c:forEach>];


   var ${prefix}loader=new AjaxTreeLoader({
            prefix:'${prefix}',
            data:data${prefix},
            uiProviders:{
                'col': Ext.extend(Ext.tree.ColumnNodeUI, { selection:'${selection.type}'})
            }
        });

    var tree = new Ext.tree.ColumnTree({
        <c:choose>
          <c:when test="${selection.type eq 'MULTIPLE'}">
             selModel: new Ext.tree.ColumnTreeMultipleSelectionModel(),
             selection: 'MULTIPLE',
          </c:when>
          <c:otherwise>
             selection: 'SINGLE',
          </c:otherwise>
        </c:choose>

        rootVisible:false,
        <c:forEach var="property" items="${table.properties}">
           <c:if test="${not (property.name eq 'rootVisible')}">
              ${property.name}: ${property.value},
           </c:if>
        </c:forEach>
        renderTo: '${prefix}Container',
        autoScroll: true,
        prefix:'${prefix}',
        columns:columns,
        loader: ${prefix}loader,
        width : 'auto',
        root: new Ext.tree.AsyncTreeNode({
            text:'Root',
            id:'root'
        })
    });


});


//]]>
</script>





