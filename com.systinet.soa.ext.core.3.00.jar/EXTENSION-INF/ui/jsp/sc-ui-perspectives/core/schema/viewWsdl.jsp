<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.schema.schemaMessages" var="schemaMessages"/>
<fmt:message var="operationNameLabel" key="wsdl.operationName" bundle="${schemaMessages}"/>
<fmt:message var="portTypeLabel" key="wsdl.portType" bundle="${schemaMessages}"/>
<fmt:message var="inputLabel" key="wsdl.input" bundle="${schemaMessages}"/>
<fmt:message var="outputLabel" key="wsdl.output" bundle="${schemaMessages}"/>
<fmt:message var="faultsLabel" key="wsdl.faults" bundle="${schemaMessages}"/>

        <c:set var="idCounter" value="${0}" />
        <syswf:jsonValue var="myData" type="hash">
            <syswf:jsonValue name="data" type="array">
                <c:forEach var="portType" items="${wsdlModel.portTypes}" varStatus="statusTypes">
                    <c:forEach var="operation" items="${portType.operations}" varStatus="status">
                        <c:set var="input">
                            <c:forEach var="inputPartKey" items="${operation.input.message.parts}" varStatus="statusParts">
                                <c:choose>
                                    <c:when test="${not empty inputPartKey.value.elementName}" >
                                        ${inputPartKey.value.elementName.localPart}:
                                        <a href="javascript:void(0);" 
                                            onclick="${goToFunction}({elementViewType: 'schemaElement', elementLocalName: '${inputPartKey.value.elementName.localPart}', elementNamespace: '${inputPartKey.value.elementName.namespaceURI}', elementType: 'element', elementLocalNameAlias: '${inputPartKey.value.name}'})" >
                                                    ${inputPartKey.value.name}</a>
                                    </c:when>
                                    <c:when test="${not empty inputPartKey.value.typeName}" >
                                        ${inputPartKey.value.typeName.localPart}:
                                        <c:choose>
                                            <c:when test="${inputPartKey.value.typeName.namespaceURI eq 'http://www.w3.org/2001/XMLSchema'}">
                                                <c:out value="${inputPartKey.value.name}" />
                                            </c:when>
                                            <c:otherwise>
                                                <a href="javascript:void(0);" 
                                                    onclick="${goToFunction}({elementViewType: 'schemaElement', elementLocalName: '${inputPartKey.value.typeName.localPart}', elementNamespace: '${inputPartKey.value.typeName.namespaceURI}', elementType: 'type', elementLocalNameAlias: '${inputPartKey.value.name}'})" >
                                                            <c:out value="${inputPartKey.value.name}" /></a>                                            
                                            </c:otherwise>
                                         </c:choose>
                                    </c:when>
                                </c:choose>
                                <c:if test="${not statusParts.last}">,</c:if>
                            </c:forEach>
                        </c:set>
                        
                        <c:set var="output">
                            <c:forEach var="outputPart" items="${operation.output.message.parts}" varStatus="statusOutput">
                                <c:choose>
                                    <c:when test="${not empty outputPart.value.elementName}" >
                                        ${outputPart.value.elementName.localPart}:
                                        <a href="javascript:void(0);" 
                                            onclick="${goToFunction}({elementViewType: 'schemaElement', elementLocalName: '${outputPart.value.elementName.localPart}', elementNamespace: '${outputPart.value.elementName.namespaceURI}', elementType: 'element', elementLocalNameAlias: '${outputPart.value.name}'})" >
                                                    ${outputPart.value.name}</a>
                                    </c:when>
                                    <c:when test="${not empty outputPart.value.typeName}" >
                                        ${outputPart.value.typeName.localPart}:
                                        <c:choose>
                                            <c:when test="${outputPart.value.typeName.namespaceURI eq 'http://www.w3.org/2001/XMLSchema'}">
                                                <c:out value="${outputPart.value.name}" />
                                            </c:when>
                                            <c:otherwise>
                                                <a href="javascript:void(0);" 
                                                    onclick="${goToFunction}({elementViewType: 'schemaElement', elementLocalName: '${outputPart.value.typeName.localPart}', elementNamespace: '${outputPart.value.typeName.namespaceURI}', elementType: 'type', elementLocalNameAlias: '${outputPart.value.name}'})" >
                                                            <c:out value="${outputPart.value.name}" /></a>
                                            </c:otherwise>
                                         </c:choose>
                                    </c:when>
                                </c:choose>
                                <c:if test="${not statusOutput.last}">,</c:if>
                            </c:forEach>
                        </c:set>
                        
                        
                        <c:set var="faults">
                            <c:forEach var="fault" items="${operation.faults}" varStatus="statusFault">
                                <c:forEach var="faultPart" items="${fault.value.message.parts}" varStatus="statusPart">
                                    <c:choose>
                                        <c:when test="${not empty faultPart.value.elementName}" >
                                            ${faultPart.value.elementName.localPart}:
                                            <a href="javascript:void(0);" 
                                                onclick="${goToFunction}({elementViewType: 'schemaElement', elementLocalName: '${faultPart.value.elementName.localPart}', elementNamespace: '${faultPart.value.elementName.namespaceURI}', elementType: 'element', elementLocalNameAlias: '${faultPart.value.name}'})" >
                                                        ${faultPart.value.name}</a>
                                        </c:when>
                                        <c:when test="${not empty faultPart.value.typeName}" >
                                            ${faultPart.value.typeName.localPart}:
                                            <a href="javascript:void(0);" 
                                                onclick="${goToFunction}({elementViewType: 'schemaElement', elementLocalName: '${faultPart.value.typeName.localPart}', elementNamespace: '${faultPart.value.typeName.namespaceURI}', elementType: 'type', elementLocalNameAlias: '${faultPart.value.name}'})" >
                                                        ${faultPart.value.name}</a>
                                        </c:when>
                                    </c:choose>
                                    <c:if test="${not statusPart.last}">,</c:if>
                                </c:forEach>
                                <c:if test="${not statusFault.last}">,</c:if>
                            </c:forEach>
                           
                        </c:set>
                        
                        <c:set var="documentation">
                            <c:if test="${not empty operation.documentationElement.nodeValue}">
                                ${operation.documentationElement.nodeValue}
                            </c:if>
                        </c:set>

                        
                        <syswf:jsonValue type="hash">
                            <syswf:jsonValue name="id" value="${idCounter}" />
                            <syswf:jsonValue name="operation" value="${operation.name}" />
                            <syswf:jsonValue name="portType" value="${portType.QName.localPart}" />
                            <syswf:jsonValue name="documentation" value="${documentation}" />
                            <syswf:jsonValue name="input" value="${input}" />
                            <syswf:jsonValue name="output" value="${output}"/>
                            <syswf:jsonValue name="faults" value="${faults}"/>
                        </syswf:jsonValue>
                        <c:set var="idCounter" value="${idCounter+1}" />
                    </c:forEach>
                </c:forEach>
            </syswf:jsonValue>
         </syswf:jsonValue>

<div id="${prefix}Table" class="UI Table"></div>
<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){

         var myData = ${myData};
     
         var reader = new Ext.data.JsonReader({
            root:'data',
            totalProperty: 'total',
            id: 'id',  
            fields: [
                     {name: 'id'},
                     {name: 'operation'},
                     {name: 'portType'},
                     {name: 'documentation'},
                     {name: 'input'},
                     {name: 'output'},
                     {name: 'faults'} 
              ] 
          });

         
        
        var store = new Ext.data.GroupingStore({ 
            reader: reader, 
            sortInfo: {field: 'operation', direction: 'ASC'},
            groupField: 'portType'
         });
        store.loadData(myData);
    
        var cm = new Ext.grid.ColumnModel([
            {
                id: 'operation',
                dataIndex: 'operation',
                sortable: true,
                header: '${operationNameLabel}'
            },{
                id: 'portType',
                dataIndex: 'portType',
                sortable: true, 
                header: "${portTypeLabel}", 
                hidden:true
            }, {
                id: 'input',
                dataIndex: 'input',
                sortable: true,
                header: "${inputLabel}"
            }, {
            	id: 'output',
                dataIndex: 'output',
                sortable: true,
                header: "${outputLabel}"
            },{
                id: 'faults',
                dataIndex: 'faults',
                sortable: true, 
                header: "${faultsLabel}", 
                hidden:true
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
                groupTextTpl: '{text} ({[values.rs.length]} {[values.rs.length > 1 ? "Operations" : "Operation"]})',
                enableRowBody:true,
                showPreview: true,
                getRowClass: function(record, rowIndex, p, store){
                	if(this.showPreview){
                	   p.body = '<p class="TextExcerpt">'+record.data.documentation+'</p>';
                	   return 'x-grid3-row-expanded';
                	} else {
                	   return 'x-grid3-row-collapsed';
                	}
                }
                    
            }),
            enableColLock: true,
            loadMask: true,
            autoExpandColumn: 'name',
            viewConfig: {
                forceFit: true
            },
            width: '100%',
            autoHeight: true,
            autoScroll: true,
            trackMouseOver: false,
            listeners: {
                'render': {
                    fn: function() {
                        Datagrid.Utils.ParseScripts(${prefix}dg_accessrights, '${prefix}Table');
                        ${prefix}dg_accessrights.getView().refresh();
                    }
                }
            }
        });
    
        ${prefix}dg_accessrights.render();
    });

//]]>
</script>
