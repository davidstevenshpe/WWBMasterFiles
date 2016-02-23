<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.schema.schemaMessages" var="schemaMessages"/>

<fmt:message var="inspectLabel" key="schemaElement.hintInspect" bundle="${schemaMessages}"/>

<c:set var="element" value="${elementHolder.element}" />
<c:set var="params" value="${elementHolder.params}" />
<c:set var="node" value="${element.node}" />
<c:set var="attributeHelp" value="Attributes available on the declaring element" />

<c:if test="${not empty node}" >
    <div style="display:none">
        <div id="${boxid}Tip">
            <div class="TipDocumentation">
                <c:out value="${element.documentation}" />
            </div>
            <div class="TipAttributes">
                <table>
                    <tr>
                        <th></th><th></th>
                    </tr>
                    <c:if test="${not empty params['name']}" >
                        <tr>
                            <td class="TipAttributeHead"><div title="${attributeHelp}" class="XSDAttributeName" align="right">name:</div></td>
                            <td class="TipAttribute"><div align="left" title="">${params['name']}</div></td>
                        </tr>
                    </c:if>
                    
                    <c:if test="${not empty base.typeQName}" >
                        <tr>
                            <td class="TipAttributeHead"><div title="${attributeHelp}" class="XSDAttributeName" align="right">type:</div></td>
                            <td class="TipAttribute"><div align="left" title="${element.typeQName.namespace}">${base.typeQName.localName}</div></td>
                        </tr>
                    </c:if>
                    
                    <c:set var="minOccursValue" value="${params['minOccurs']}" />
                    <c:if test="${not empty minOccursValue}" >
                        <tr>
                            <td class="TipAttributeHead" title="${attributeHelp}"><div class="XSDAttributeName" align="right">minOccurs:</div></td>
                            <td class="TipAttribute"><div align="left">${minOccursValue}</div></td>
                        </tr>
                    </c:if>
                    
                    <c:set var="maxOccursValue" value="${params['maxOccurs']}" />
                    <c:if test="${not empty maxOccursValue}" >
                        <tr>
                            <td class="TipAttributeHead" title="${attributeHelp}"><div class="XSDAttributeName" align="right">maxOccurs:</div></td>
                            <td class="TipAttribute"><div align="left">${maxOccursValue}</div></td>
                        </tr>
                    </c:if>
                    
                    <c:set var="defaltValue" value="${params['default']}"/>
                    <c:if test="${not empty defaltValue}" >
                        <tr>
                            <td class="TipAttributeHead" title="${attributeHelp}"><div class="XSDAttributeName" align="right">default:</div></td>
                            <td class="TipAttribute"><div align="left">${defaltValue}</div></td>
                        </tr>
                    </c:if>                
                    
                    <c:set var="useValue" value="${params['use']}" />
                    <c:if test="${not empty useValue}" >
                        <tr>
                            <td class="TipAttributeHead" title="${attributeHelp}"><div class="XSDAttributeName" align="right">use:</div></td>
                            <td class="TipAttribute"><div align="left">${useValue}</div></td>
                        </tr>
                    </c:if>
                    
                    <c:set var="substitutionGroupValue" value="${params['substitutionGroup']}" />
                    <c:if test="${not empty substitutionGroupValue}" >
                        <tr>
                            <td class="TipAttributeHead" title="${attributeHelp}"><div class="XSDAttributeName" align="right">substitutionGroup:</div></td>
                            <td class="TipAttribute"><div align="left">${substitutionGroupValue}</div></td>
                        </tr>
                    </c:if>
                </table>
            </div>

            <c:if test="${!noInspect and (empty base.typeClass or base.typeClass == 'userdef')}">
                <br/>
                <c:choose>
                	<c:when test="${not empty element.localName}">
		                <c:set var="targetName" value="${element.localName}" />	
                	</c:when>
                	<c:otherwise>
        	        	<c:set var="targetName" value="${params['name']}" />
                	</c:otherwise>
               	</c:choose>	
                
                <a href="javascript:void(0);"  onclick="${goToFunction}({elementViewType: 'schemaElement', elementLocalName: '${targetName}', elementNamespace: '${element.namespace}', elementType: '${element.type}'})" >
                    <c:out value="${inspectLabel}" />
                </a>
            </c:if>
            
        </div>
    </div>
    <script>
    //<![CDATA[
          var e=Ext.get('${boxid}');
          if (e!=null)
          {
              tooltipIDs[tooltipsCounter]='${boxid}';
              tooltips[tooltipsCounter++]=new Ext.ToolTip({
                      target: '${boxid}',
                      items: [{
                                 xtype: 'component',
                                 applyTo: '${boxid}Tip'
                             }],
                      title: '<c:if test="${not empty base.typeQName.localName}">${base.typeQName.localName}:</c:if> ${params['name']}',
                      anchorToTarget:true,
                      autoHide: false,
                      closable: true,
                      draggable:true,
                      showDelay:300000
                  });
              e.on('click', function() {tooltips[tooltipIDs.indexOf('${boxid}')].show(); } );
          }
    
//]]>
</script>
</c:if>    