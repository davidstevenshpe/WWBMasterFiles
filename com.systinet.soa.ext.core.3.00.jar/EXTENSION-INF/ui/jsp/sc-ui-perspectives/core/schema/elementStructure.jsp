<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.schema.schemaMessages" var="schemaMessages"/>

<fmt:message var="depthLimitedLabel" key="schemaElement.displayDepthLimited" bundle="${schemaMessages}"/>
<fmt:message var="cyclicDependencyDetectedLabel" key="schemaElement.cyclicDependencyDetected" bundle="${schemaMessages}"/>

 <c:set var="boxid" value="${prefix}a" /> 
 <c:set var="namespace" value="${item.stackItem.namespace}" />
 <c:set var="imgLocation" value="${webResourcePath}/skin/img/default/schema" />
 
<c:set var="element" value="${elementHolder.element}" />
<c:set var="params" value="${elementHolder.params}" />
<c:set var="node" value="${element.node}" />
 
<c:if test="${empty step}">
    <c:set var="step" value="TYPE" />
</c:if>

<c:if test="${empty elType}">
    <c:set var="elType" value="${element.type}" />
</c:if>

<c:choose>
    <c:when test="${typeNestingLevel == 0}"/>
    <c:when test="${(typeNestingLevel mod 2) == 1}">
        <c:set var="color" value="YellowBackground" />
    </c:when>
    <c:when test="${(typeNestingLevel mod 2) == 0}">
        <c:set var="color" value="BlueBackground" />
    </c:when>
</c:choose>

<c:if test="${typeNestingLevel >= 2}">
    <c:set var="visibilityStyle" value="display:none" />
</c:if>

<c:if test="${empty base}" >
    <c:set var="base" value="${element}" />
</c:if>


<c:choose>
    <c:when test="${empty base.params['minOccurs']}">
        <c:set var="minOccurs" value="1" />
    </c:when>
    <c:otherwise>
        <c:set var="minOccurs" value="${base.params['minOccurs']}" />
    </c:otherwise>
</c:choose>
    
<c:choose>
    <c:when test="${empty base.params['maxOccurs']}">
        <c:set var="maxOccurs" value="1" />
    </c:when>
    <c:when test="${base.params['maxOccurs'] == 'unbounded'}">
        <c:set var="maxOccurs" >&#8734;</c:set>
    </c:when>
    <c:otherwise>
        <c:set var="maxOccurs" value="${base.params['maxOccurs']}" />
    </c:otherwise>
</c:choose>

<c:if test="${empty position}">
    <c:set var="position" value="${0}" />
</c:if>

<c:if test="${empty last}">
    <c:set var="last" value="${true}" />
</c:if>

<c:if test="${empty asContainer}">
    <c:set var="asContainer" value="${false}" />
</c:if>

<c:if  test="${empty localNameAlias}">
    <c:set var="localNameAlias" value="${params['name']}" />
</c:if>

<c:if  test="${empty localNameAlias}">
    <c:set var="localNameAlias" value="${base.localName}" />
</c:if>

<c:if  test="${empty localNameAlias}">
    <c:set var="localNameAlias" value="${element.localName}" />
</c:if>

<c:catch var="exception">

        <c:choose>
             
        <c:when test="${alreadyProcessed || element.cyclicDependency}">
            &nbsp;<c:out value="${cyclicDependencyDetectedLabel}" />&nbsp;
        </c:when>
            
        <c:when test="${element.type == 'anyAttribute' or element.type == 'any'}">
            <td class="NoMarginNoPadding" rowspan="2">
                 <c:set var="content">
                     <table class="ElementTable" style="width:auto" title="XML schema 'any' container">
                         <tr class="NoMarginNoPadding">
                             <td class="NoMarginNoPadding" style="vertical-align:top;">
                                 <img class="ElementIcon" src="${imgLocation}/complex.png" align="top"/>
                             </td>
                             <td class="NoMarginNoPadding">
                                 <span style="font-style:italic">ANY</span>
                             </td>
                         </tr>
                     </table>
                 </c:set>
                 
                 <syswf:component name="/core/schema/view/schemaViewBox" prefix="Box" wrap="${false}">
                    <syswf:param name="boxid" value="${boxid}" />
                    <syswf:param name="element" value="${element}" />
                    <syswf:param name="elementHolder" value="${elementHolder}" />
                    <syswf:param name="typeNestingLevel" value="${typeNestingLevel}" />
                    <syswf:param name="content" value="${content}" />
                    <syswf:param name="minOccurs" value="${minOccurs}" />
                    <syswf:param name="maxOccurs" value="${maxOccurs}" />
                </syswf:component>
            </td>
        </c:when>
        
        <c:when test="${element.type == 'simpleType'}">
            <c:choose>
                <c:when test="${typeNestingLevel == 0}">
                        <br/>
                        <br/>
                        <div style="font-size:12px">
                            <div>
                                This simple type is derived from ${element.derivedFrom.namespace}:${element.derivedFrom.localName}
                            </div>
                            <br/>
                            <div>
                                Check the XML view for more details
                            </div>
                        </div>
                  </c:when>
                  <c:when test="${not empty element.derivedFrom}">
                    <c:choose>
                           <c:when test="${element.derivedFromClass == 'userdef'}">
                                <c:set var="type" value="${typeResolver.byName[element.derivedFrom]}" />
                                <c:set var="typeContent2" >
                                    <c:choose>
                                        <c:when test="${empty type}" >
                                            <fmt:message key="couldNotResolve" bundle="${schemaMessages}">
                                                <fmt:param value="${element.derivedFrom.namespace}" />
                                                <fmt:param value="${element.derivedFrom.localName}" />
                                            </fmt:message>
                                        </c:when>
                                        <c:otherwise>
                                            <syswf:component name="/core/schema/elementStructure" prefix="Type" wrap="${false}">
                                                <syswf:param name="goToFunction" value="${goToFunction}" />
                                                <syswf:param name="localNameAlias" value="" />
                                                <syswf:param name="element" value="${type}" />
                                                <syswf:param name="parentHolder" value="${elementHolder}" />
                                                <syswf:param name="parents" value="${copyOfParents}" />
                                                <syswf:param name="base" value="${base}" />
                                                <syswf:param name="inTable" value="${false}" />
                                                <syswf:param name="typeNestingLevel" value="${typeNestingLevel}" />
                                                <syswf:param name="maximumNestingLevel" value="${maximumNestingLevel}" />
                                                <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
                                            </syswf:component>
                                        </c:otherwise>
                                    </c:choose>
                                </c:set>
                                <c:choose>
                                    <c:when test="${inTable}" >
                                        <td class="NoMarginNoPadding" rowspan="2">
                                             ${typeContent2}
                                        </td>
                                    </c:when>
                                    <c:otherwise>
                                        ${typeContent2}
                                    </c:otherwise>    
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                    <c:set var="content" >
                                            <table class="ElementTable" style="width:auto">
                                                <tr class="NoMarginNoPadding">
                                                    <td class="NoMarginNoPadding" style="vertical-align:top;">
                                                        <c:choose>
                                                            <c:when test="${element.derivedFromClass == 'text'}">
                                                                <img class="ElementIcon" src="${imgLocation}/text.png" align="top"/>
                                                            </c:when>
                                                            <c:when test="${element.derivedFromClass == 'number'}">
                                                                <img class="ElementIcon" src="${imgLocation}/number.png" align="top"/>
                                                            </c:when>
                                                            <c:when test="${element.derivedFromClass == 'date'}">
                                                                <img class="ElementIcon" src="${imgLocation}/date.png" align="top"/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img class="ElementIcon" src="${imgLocation}/other.png" align="top"/>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="NoMarginNoPadding">
                                                        <c:choose>
                                                            <c:when test="${not empty localNameAlias}">
                                                                <c:out value="${localNameAlias}" />    
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:out value="${element.derivedFrom.localName}" />    
                                                            </c:otherwise>
                                                        </c:choose>
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                        </c:set>
                                            
                                    <c:set var="content2">
                                        <syswf:component name="/core/schema/view/schemaViewBox" prefix="Box" wrap="${false}">
                                            <syswf:param name="boxid" value="${boxid}" />
                                            <syswf:param name="element" value="${element}" />
                                            <syswf:param name="elementHolder" value="${elementHolder}" />
                                            <syswf:param name="typeNestingLevel" value="${typeNestingLevel}" />
                                            <syswf:param name="inTable" value="${false}" />
                                            <syswf:param name="content" value="${content}" />
                                            <syswf:param name="minOccurs" value="${minOccurs}" />
                                            <syswf:param name="maxOccurs" value="${maxOccurs}" />
                                        </syswf:component>
            
                                        <syswf:component name="/core/schema/view/schemaViewHint" prefix="Hint" wrap="${false}">
                                            <syswf:param name="goToFunction" value="${goToFunction}" />
                                            <syswf:param name="element" value="${element}" />
                                            <syswf:param name="base" value="${base}" />
                                            <syswf:param name="elementHolder" value="${elementHolder}" />
                                            <syswf:param name="inTable" value="${false}" />
                                            <syswf:param name="boxid" value="${boxid}" />
                                            <syswf:param name="noInspect" value="${true}" />
                                        </syswf:component>
                                    </c:set>
                                    
                                    <c:choose>
                                    <c:when test="${inTable}" >
                                        <td class="NoMarginNoPadding" rowspan="2">
                                            ${content2}
                                        </td>
                                     </c:when>
                                     <c:otherwise>
                                        ${content2}
                                     </c:otherwise>
                                 </c:choose>
                            </c:otherwise>
                        </c:choose>
                  </c:when>
              </c:choose>
        </c:when>
            
     	  <c:when test="${not empty element.refQName}">
                <c:set var="ref" value="${refResolver.byName[element.refQName]}" />
                <syswf:component name="/core/schema/elementStructure" prefix="Ref" wrap="${false}">
                    <syswf:param name="goToFunction" value="${goToFunction}" />
                    <syswf:param name="parents" value="${copyOfParents}" />
                    <syswf:param name="localNameAlias" value="" />
                    <syswf:param name="element" value="${ref}" />
                    <syswf:param name="parentHolder" value="${elementHolder}" />
                    <syswf:param name="base" value="${base}" />
                    <syswf:param name="typeNestingLevel" value="${typeNestingLevel}" />
                    <syswf:param name="maximumNestingLevel" value="${maximumNestingLevel}" />
                    <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
                </syswf:component>
            </c:when>
            
            <c:when test="${element.type == 'element'}">
                <c:choose>
                    <c:when test="${localName == 'any'}">
                         <td class="NoMarginNoPadding" rowspan="2">
                            <c:set var="content">
                                <table class="ElementTable" style="width:auto" title="XML schema 'any' container">
                                    <tr class="NoMarginNoPadding">
                                        <td class="NoMarginNoPadding" style="vertical-align:top;">
                                            <img class="ElementIcon" src="${imgLocation}/complex.png" align="top"/>
                                        </td>
                                        <td class="NoMarginNoPadding">
                                            <span style="font-style:italic">ANY</span>
                                        </td>
                                    </tr>
                                </table>
                            </c:set>
                            
                            <syswf:component name="/core/schema/view/schemaViewBox" prefix="Box" wrap="${false}">
                                <syswf:param name="boxid" value="${boxid}" />
                                <syswf:param name="element" value="${element}" />
                                <syswf:param name="elementHolder" value="${elementHolder}" />
                                <syswf:param name="typeNestingLevel" value="${typeNestingLevel}" />
                                <syswf:param name="content" value="${content}" />
                                <syswf:param name="minOccurs" value="${minOccurs}" />
                                <syswf:param name="maxOccurs" value="${maxOccurs}" />
                            </syswf:component>
                         </td>
                    </c:when>
                    <c:when test="${element.typeClass == 'userdef'}">
                        <c:set var="typeElement" value="${typeResolver.byName[element.typeQName]}" />
                        <c:set var="typeContent1" >
                            <c:choose>
                                <c:when test="${empty typeElement}" >
                                    <fmt:message key="couldNotResolve" bundle="${schemaMessages}">
                                        <fmt:param value="${element.typeQName.namespace}" />
                                        <fmt:param value="${element.typeQName.localName}" />
                                    </fmt:message>
                                </c:when>
                                
                                <c:otherwise>
                                        <syswf:component name="/core/schema/elementStructure" prefix="Type" wrap="${false}">
                                            <syswf:param name="goToFunction" value="${goToFunction}" />
                                            <syswf:param name="localNameAlias" value="" />
                                            <syswf:param name="element" value="${typeElement}" />
                                            <syswf:param name="parentHolder" value="${elementHolder}" />
                                            <syswf:param name="parents" value="${copyOfParents}" />
                                            <syswf:param name="base" value="${base}" />
                                            <syswf:param name="inTable" value="${false}" />
                                            <syswf:param name="typeNestingLevel" value="${typeNestingLevel}" />
                                            <syswf:param name="maximumNestingLevel" value="${maximumNestingLevel}" />
                                            <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
                                        </syswf:component>
                                 </c:otherwise>
                            </c:choose>
                        </c:set>
                        
                        <c:choose>
                            <c:when test="${inTable}" >
                                <td class="NoMarginNoPadding" rowspan="2">
                                     ${typeContent1}
                                </td>
                                
                            </c:when>
                            <c:otherwise>
                                    ${typeContent1}
                            </c:otherwise>    
                        </c:choose>
                    </c:when>
                    <c:when test="${not empty element.typeClass}">
                         <td class="NoMarginNoPadding" rowspan="2">
                                    <c:set var="content" >
                                        <table class="ElementTable" style="width:auto">
                                            <tr class="NoMarginNoPadding">
                                                <td class="NoMarginNoPadding" style="vertical-align:top;">
                                                    <c:choose>
                                                        <c:when test="${element.typeClass == 'text'}">
                                                            <img class="ElementIcon" src="${imgLocation}/text.png" align="top"/>
                                                        </c:when>
                                                        <c:when test="${element.typeClass == 'number'}">
                                                            <img class="ElementIcon" src="${imgLocation}/number.png" align="top"/>
                                                        </c:when>
                                                        <c:when test="${element.typeClass == 'date'}">
                                                            <img class="ElementIcon" src="${imgLocation}/date.png" align="top"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img class="ElementIcon" src="${imgLocation}/other.png" align="top"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="NoMarginNoPadding">
                                                    <c:choose>
                                                        <c:when test="${not empty localNameAlias}">
                                                            <c:out value="${localNameAlias}" />    
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:out value="${element.typeQName.localName}" />    
                                                        </c:otherwise>
                                                    </c:choose>
                                                    
                                                </td>
                                            </tr>
                                        </table>
                                    </c:set>
                            <syswf:component name="/core/schema/view/schemaViewBox" prefix="Box" wrap="${false}">
                                <syswf:param name="boxid" value="${boxid}" />
                                <syswf:param name="element" value="${element}" />
                                <syswf:param name="elementHolder" value="${elementHolder}" />
                                <syswf:param name="typeNestingLevel" value="${typeNestingLevel}" />
                                <syswf:param name="content" value="${content}" />
                                <syswf:param name="minOccurs" value="${minOccurs}" />
                                <syswf:param name="maxOccurs" value="${maxOccurs}" />
                            </syswf:component>

                            <syswf:component name="/core/schema/view/schemaViewHint" prefix="Hint" wrap="${false}">
                                <syswf:param name="goToFunction" value="${goToFunction}" />
                                <syswf:param name="element" value="${element}" />
                                <syswf:param name="base" value="${base}" />
                                <syswf:param name="elementHolder" value="${elementHolder}" />
                                <syswf:param name="boxid" value="${boxid}" />
                            </syswf:component>
                        </td>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${element.hasChildren}">
                                <c:set var="content">
                                    <c:forEach var="child" items="${element.children}" varStatus="status">
                                        <syswf:component name="/core/schema/elementStructure" prefix="Str${status.index}" wrap="${false}">
                                            <syswf:param name="goToFunction" value="${goToFunction}" />
                                            <syswf:param name="parents" value="${copyOfParents}" />
                                            <syswf:param name="elType" value="${child.type}" />
                                            <syswf:param name="localNameAlias" value="" />
                                            <syswf:param name="inTable" value="${false}" />
                                            <syswf:param name="element" value="${child}" />
                                            <syswf:param name="parentHolder" value="${elementHolder}" />
                                            <syswf:param name="base" value="${base}" />
                                            <syswf:param name="typeNestingLevel" value="${typeNestingLevel}" />
                                            <syswf:param name="maximumNestingLevel" value="${maximumNestingLevel}" />
                                            <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
                                        </syswf:component>
                                    </c:forEach>    
                                </c:set>
                            
                                <c:choose>
                                    <c:when test="${inTable}" >
                                        <td class="NoMarginNoPadding" rowspan="2">
                                            ${content}
                                        </td>
                                     </c:when>
                                     <c:otherwise>
                                        ${content}
                                     </c:otherwise>
                                 </c:choose>
                             </c:when>
                             <c:otherwise>
                                <c:set var="content">
                                    <table class="ElementTable">
                                        <tr class="NoMarginNoPadding">
                                            <td class="NoMarginNoPadding">
                                                <img src="${imgLocation}/text.png" align="top"/>
                                            </td>
                                            <td class="NoMarginNoPadding">${localNameAlias}</td>
                                        </tr>
                                    </table>
                                </c:set>
                                <c:set var="element.processed" value="${true}" />
                                        
                                <syswf:component name="/core/schema/view/schemaViewBox" prefix="Box" wrap="${false}">
                                    <syswf:param name="boxid" value="${boxid}" />
                                    <syswf:param name="element" value="${element}" />
                                    <syswf:param name="elementHolder" value="${elementHolder}" />
                                    <syswf:param name="typeNestingLevel" value="${typeNestingLevel}" />
                                    <syswf:param name="content" value="${content}" />
                                    <syswf:param name="minOccurs" value="${minOccurs}" />
                                    <syswf:param name="maxOccurs" value="${maxOccurs}" />
                                </syswf:component>                             
                             </c:otherwise>
                         </c:choose>
                    </c:otherwise>
                </c:choose>            
            </c:when>
            
            <c:when test="${element.type == 'attributes'}">
                <td class="NoMarginNoPadding" rowspan="2">
                    <table class="AttributeBox">
                        <tr><td colspan="2" class="AttributeBoxTitle">Attributes</td></tr>
                        <tr height="2px"><td class="AttributeSpacer" colspan="2"></td></tr>
                        <c:forEach var="child" items="${element.children}" varStatus="status">
                            <syswf:component name="/core/schema/elementStructure" prefix="Attr${status.index}" wrap="${false}">
                                <syswf:param name="goToFunction" value="${goToFunction}" />
                                <syswf:param name="parents" value="${copyOfParents}" />
                                <syswf:param name="localNameAlias" value="" />
                                <syswf:param name="element" value="${child}" />
                                <syswf:param name="parentHolder" value="${elementHolder}" />
                                <syswf:param name="base" value="${child}" />
                                <syswf:param name="typeNestingLevel" value="${typeNestingLevel}" />
                                <syswf:param name="maximumNestingLevel" value="${maximumNestingLevel}" />
                                <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
                            </syswf:component>
                        </c:forEach>
                    </table>    
                </td>
            </c:when>

            <c:when test="${element.type == 'attribute'}">
                        <c:choose>
                        
                            <c:when test="${not empty element.refQName}">
                                <c:set var="ref" value="${refResolver.byName[element.refQName]}" />
                                <syswf:component name="/core/schema/elementStructure" prefix="Ref" wrap="${false}">
                                    <syswf:param name="goToFunction" value="${goToFunction}" />
                                    <syswf:param name="parents" value="${copyOfParents}" />
                                    <syswf:param name="localNameAlias" value="" />
                                    <syswf:param name="element" value="${ref}" />
                                    <syswf:param name="parentHolder" value="${elementHolder}" />
                                    <syswf:param name="base" value="${ref}" />
                                    <syswf:param name="typeNestingLevel" value="${typeNestingLevel}" />
                                    <syswf:param name="maximumNestingLevel" value="${maximumNestingLevel}" />
                                    <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
                                </syswf:component>
                            </c:when>
                            <c:when test="${not empty element.typeClass}">
                                <tr id="${boxid}" class="AttributeBoxEntry">
                                    <td class="AttributeType">
                                        <span align="right">${element.typeQName.localName}:</span>
                                    </td>
                                    <td class="AttributeName">
                                        <span align="left">${localNameAlias}</span>
                                        <syswf:component name="/core/schema/view/schemaViewHint" prefix="Hint" wrap="${false}">
                                            <syswf:param name="goToFunction" value="${goToFunction}" />
                                            <syswf:param name="element" value="${element}" />
                                            <syswf:param name="base" value="${base}" />
                                            <syswf:param name="elementHolder" value="${elementHolder}" />
                                            <syswf:param name="boxid" value="${boxid}" />
                                        </syswf:component>
                                    </td>
                                </tr>
                            </c:when>
                            <c:when test="${false}">  <!-- not(empty(xsd:simpleType/xsd:restriction/@base) -->
                                <tr id="${boxid}" class="AttributeBoxEntry">
                                    <td class="AttributeType" align="right"><span title="${localNameAlias}" align="right">${element.localName}</span></td>
                                    <td class="AttributeName" align="left">${localNameAlias}</span></td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <tr id="${boxid}" class="AttributeBoxEntry">
                                    <td class="AttributeType" align="right"><span align="right"><font color="red">undefined:</font></span></td>
                                    <td class="AttributeName" align="left"><span align="left">${localNameAlias}</span>
                                        <syswf:component name="/core/schema/view/schemaViewHint" prefix="Hint" wrap="${false}">
                                            <syswf:param name="goToFunction" value="${goToFunction}" />
                                            <syswf:param name="element" value="${element}" />
                                            <syswf:param name="base" value="${base}" />
                                            <syswf:param name="elementHolder" value="${elementHolder}" />
                                            <syswf:param name="boxid" value="${boxid}" />
                                        </syswf:component>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
            </c:when>
            
            <c:when test="${element.type == 'extension' || element.type == 'restriction'}">
                <td class="NoMarginNoPadding" rowspan="2">
                    <table class="ExtensionBox"  style="margin-right:8px;">
                        <tr class="NoMarginNoPadding">
                            <c:set var="baseString" value="${base.params['base']}" />
                            <c:choose>
                                <c:when test="${element.type == 'extension'}" >
                                    <td title="${hint}" class="ExtensionBoxTitle">Extends:&nbsp;${baseString}</td>                                
                                </c:when>
                                <c:otherwise>
                                    <td title="${hint}" class="ExtensionBoxTitle">Restricts:&nbsp;${baseString}</td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                        <tr class="NoMarginNoPadding">
                            <td class="NoMarginNoPadding">
                                <table class="NoMarginNoPadding">
                                    <tr>
                                        <td class="NoMarginNoPadding">
                                           <img align="absmiddle" class="XSDGraphImg" src="${imgLocation}/horizontal20.png" width="20" height="1"/>
                                        </td>
                                        <td class="ExtensionBoxContent" style="padding-right:8px;">
                                            <table class="NoMarginNoPadding">
                                                <c:choose>
                                                    <c:when test="${not empty element.derivedFrom}">
                                                        <c:set var="from" value="${typeResolver.byName[element.derivedFrom]}" />
                                                        <c:choose>
                                                            <c:when test="${empty from}" >
                                                                <fmt:message key="couldNotResolve" bundle="${schemaMessages}">
                                                                    <fmt:param value="${element.derivedFrom.namespace}" />
                                                                    <fmt:param value="${element.derivedFrom.localName}" />
                                                                </fmt:message>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <syswf:component name="/core/schema/elementStructure" prefix="From" wrap="${false}">
                                                                    <syswf:param name="goToFunction" value="${goToFunction}" />
                                                                    <syswf:param name="parents" value="${copyOfParents}" />
                                                                    <syswf:param name="localNameAlias" value="" />
                                                                    <syswf:param name="element" value="${from}" />
                                                                    <syswf:param name="parentHolder" value="${elementHolder}" />
                                                                    <syswf:param name="base" value="${from}" />
                                                                    <syswf:param name="elType" value="container" />
                                                                    <syswf:param name="typeNestingLevel" value="${typeNestingLevel}" />
                                                                    <syswf:param name="maximumNestingLevel" value="${maximumNestingLevel}" />
                                                                    <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
                                                                </syswf:component>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach var="child" items="${element.children}" varStatus="status">
                                                            <syswf:component name="/core/schema/elementStructure" prefix="Str${status.index}" wrap="${false}">
                                                                <syswf:param name="goToFunction" value="${goToFunction}" />
                                                                <syswf:param name="parents" value="${copyOfParents}" />
                                                                <syswf:param name="localNameAlias" value="" />
                                                                <syswf:param name="elType" value="container" />
                                                                <syswf:param name="element" value="${child}" />
                                                                <syswf:param name="parentHolder" value="${elementHolder}" />
                                                                <syswf:param name="base" value="${child}" />
                                                                <syswf:param name="typeNestingLevel" value="${typeNestingLevel}" />
                                                                <syswf:param name="maximumNestingLevel" value="${maximumNestingLevel}" />
                                                                <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
                                                            </syswf:component>
                                                        </c:forEach>
                                                    </c:otherwise> 
                                                </c:choose>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="NoMarginNoPadding"><td class="ExtensionBoxCounter">&nbsp;</td></tr>
                    </table>
                </td>
            </c:when>
            
            <c:when test="${elType == 'container'}"> 
                <c:forEach var="child" items="${element.children}" varStatus="status">
                    <c:set var="content" >
                        <syswf:component name="/core/schema/elementStructure" prefix="Str${status.index}" wrap="${false}">
                            <syswf:param name="goToFunction" value="${goToFunction}" />
                            <syswf:param name="parents" value="${copyOfParents}" />
                            <syswf:param name="elType" value="${child.type}" />
                            <syswf:param name="localNameAlias" value="" />
                            <syswf:param name="element" value="${child}" />
                            <syswf:param name="parentHolder" value="${elementHolder}" />
                            <syswf:param name="base" value="${child}" />
                            <syswf:param name="typeNestingLevel" value="${typeNestingLevel}" />
                            <syswf:param name="maximumNestingLevel" value="${maximumNestingLevel}" />
                            <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
                        </syswf:component>
                    </c:set>
                    
                    <syswf:component name="/core/schema/view/schemaViewConnection" prefix="Box${status.index}" wrap="${false}">
                        <syswf:param name="content" value="${content}" />
                        <syswf:param name="position" value="${status.index}" />
                        <syswf:param name="last" value="${status.last}" />
                        <syswf:param name="imgLocation" value="${imgLocation}" />
                    </syswf:component>
                </c:forEach>    
            </c:when>
            

            <c:when test="${element.type == 'complexType'}">
                <!-- Complex type - TYPE - before -->                
                <c:if test="${typeNestingLevel > 2}">
                    <c:set var="visibilityStyle" value="display:none" /> 
                </c:if>
                
                <c:choose>
                    <c:when test="${typeNestingLevel > 2}">
                        <c:set var="visibilityStyle" value="display:none" /> 
                    </c:when>
                    <c:when test="${empty visibilityStyle}">
                        <c:set var="visibilityStyleInverted" value="display:none" />
                    </c:when>
                </c:choose>

                <c:choose>
                    <c:when test="${anonymousType == 1}">
                        <c:set var="hint" value="Element defined using anonymous type declaration" />    
                    </c:when>
                    <c:otherwise>
                        <c:set var="hint" value="Namespace: ${base.namespace}"/>
                    </c:otherwise>
                </c:choose>
                 
                <table class="NoMarginNoPadding" id="${boxid}a">
                    <colgroup>
                        <col/>
                        <col/>
                    </colgroup>
                    <colgroup>
                        <col/>
                        <col/>
                    </colgroup>
                    <tr>
                        <td class="NoMarginNoPadding"></td>
                        <td class="NoMarginNoPadding"></td>
                        <td class="NoMarginNoPadding"></td>
                        <td class="NoMarginNoPadding">
                            <span id="${boxid}8" style="${visibilityStyle}">&nbsp;</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="NoMarginNoPadding"></td>
                        <td class="NoMarginNoPadding"></td>
                        <td class="NoMarginNoPadding"></td>
                        <td class="NoMarginNoPadding ${color}">
                            <div title="${hint}" class="BoxTitle" id="${boxid}2" style="${visibilityStyle}">
                                Type:&nbsp;
                                <c:choose>
                                    <c:when test="${anonymousType == '1'}">Anonymous</c:when>
                                        <c:otherwise>${base.localName}</c:otherwise>
                                    </c:choose>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="NoMarginNoPadding">
                                    <c:set var="content">
                                    	<c:choose>
                                    		<c:when test="${inTable}">
                                    			<td class="NoMarginNoPadding" rowspan="2">
		                                    		<table class="ElementTable">
			                                            <tr class="NoMarginNoPadding">
			                                                <td class="NoMarginNoPadding" style="vertical-align:top;">
			                                                    <img class="ElementIcon" src="${imgLocation}/complex.png" align="top">
			                                                </td>
			                                                <td class="NoMarginNoPadding">${localNameAlias}</td>
			                                            </tr>
			                                         </table>
			                                     </td>
                                    		</c:when>
                                    		<c:otherwise>
		                                    	<table class="ElementTable">
		                                            <tr class="NoMarginNoPadding">
		                                                <td class="NoMarginNoPadding" style="vertical-align:top;">
		                                                    <img class="ElementIcon" src="${imgLocation}/complex.png" align="top">
		                                                </td>
		                                                <td class="NoMarginNoPadding">${localNameAlias}</td>
		                                            </tr>
		                                        </table>	
                                    		</c:otherwise>
                                    	</c:choose>
                                    </c:set>
                                
                            <syswf:component name="/core/schema/view/schemaViewBox" prefix="Box" wrap="${false}">
                                <syswf:param name="boxid" value="${boxid}" />
                                <syswf:param name="element" value="${element}" />
                                <syswf:param name="elementHolder" value="${elementHolder}" />
                                <syswf:param name="typeNestingLevel" value="${typeNestingLevel}" />
                                <syswf:param name="content" value="${content}" />
                                <syswf:param name="minOccurs" value="${minOccurs}" />
                                <syswf:param name="maxOccurs" value="${maxOccurs}" />
                            </syswf:component>
                        </td>
                        <td class="NoMarginNoPadding">
                            <script>
                            //<![CDATA[
                            visibility['${boxid}']=<c:choose><c:when test="${empty visibilityStyle}">true</c:when><c:otherwise>false</c:otherwise></c:choose>;
                            
//]]>
</script>
                            <a href="javascript:void(0)">
                                <img id="${boxid}4" style="${visibilityStyle}" class="XSDGraphImg" src="${imgLocation}/open.png" align="absmiddle" onclick="switchElementVisibility(this,'${boxid}');"/>
                                <img id="${boxid}5" style="${visibilityStyleInverted}" class="XSDGraphImg" src="${imgLocation}/closed.png" align="absmiddle" onclick="switchElementVisibility(this,'${boxid}');"/>
                            </a>
                        </td>
                        <td class="NoMarginNoPadding">
                            <img class="XSDGraphImg"  align="absmiddle" src="${imgLocation}/horizontal20.png" id="${boxid}3" style="${visibilityStyle}"/>
                            <!-- This is here because of IE7 -->
                            <img src="${imgLocation}/transparent-dot.png" height="1px" width="1px"  id="${boxid}9" style="${visibilityStyleInverted}"/> 
                        </td>
                        <td class="NoMarginNoPadding">
                            <div class="TypeContent ${color}" id="${boxid}1" style="${visibilityStyle}">
                                <c:choose>
                                    <c:when test="${alreadyProcessed}">
                                        <table>
                                            <tr><td><img src="${imgLocation}/transparent-dot.png" height="50px" width="0px"/></td>
                                            <td><div align="absmiddle" height="50px" style="font-style:italic">This element contains itself..</div></td> </tr>
                                        </table>
                                    </c:when>
                                    <c:when test="${maximumNestingLevel > (typeNestingLevel)}">
                                        <table class="NoMarginNoPadding">
                                            <tr>
                                                <td class="NoMarginNoPadding">
                                                    <c:choose>
                                                        <c:when test="${empty element.children}">
                                                            <!-- Without this the type content box (has dotted border) shrinks to 0px when the type is empty -->
                                                            <img src="${imgLocation}/transparent-dot.png" height="50px" width="0px"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img class="XSDGraphImg" align="absmiddle" src="${imgLocation}/horizontal20.png"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="NoMarginNoPadding">
                                                    <table class="NoMarginNoPadding">
                                                        <c:forEach var="child" items="${element.children}" varStatus="status">
                                                            
                                                            <c:set var="content">
                                                                <syswf:component name="/core/schema/elementStructure" prefix="Str${status.index}" wrap="${false}">
                                                                    <syswf:param name="goToFunction" value="${goToFunction}" />
                                                                    <syswf:param name="parents" value="${copyOfParents}" />
                                                                    <syswf:param name="localNameAlias" value="" />
                                                                    <syswf:param name="element" value="${child}" />
                                                                    <syswf:param name="parentHolder" value="${elementHolder}" />
                                                                    <syswf:param name="base" value="${child}" />
                                                                    <syswf:param name="showParams" value="${true}" />
                                                                    <syswf:param name="inTable" value="${true}" />
                                                                    <syswf:param name="typeNestingLevel" value="${typeNestingLevel+1}" />
                                                                    <syswf:param name="maximumNestingLevel" value="${maximumNestingLevel}" />
                                                                    <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
                                                                </syswf:component>
                                                            </c:set>
                                                            
                                                            <syswf:component name="/core/schema/view/schemaViewConnection" prefix="Box${status.index}" wrap="${false}">
                                                                <syswf:param name="content" value="${content}" />
                                                                <syswf:param name="position" value="${status.index}" />
                                                                <syswf:param name="last" value="${status.last}" />
                                                                <syswf:param name="imgLocation" value="${imgLocation}" />
                                                            </syswf:component>
                                                        
                                                        
                                                            
                                                        </c:forEach>    
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </c:when>
                                    <c:otherwise>
                                        <table>
                                            <tr><td><img src="${imgLocation}/transparent-dot.png" height="50px" width="0px"/></td>
                                            <td><div align="absmiddle" height="50px" style="font-style:italic"><c:out value="${depthLimitedLabel}" /></div></td> </tr>
                                        </table>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                    <c:if test="${typeNestingLevel > 0}">
                        <tr>
                            <td class="NoMarginNoPadding"></td>
                            <td class="NoMarginNoPadding"></td>
                            <td class="NoMarginNoPadding"></td>
                            <td class="NoMarginNoPadding">
                                <div class="BoxTitleCounter" id="${boxid}6" style="${visibilityStyle}">&nbsp;</div>
                            </td>
                        </tr>
                        <tr>
                            <td class="NoMarginNoPadding"></td>
                            <td class="NoMarginNoPadding"></td>
                            <td class="NoMarginNoPadding"></td>
                            <td class="NoMarginNoPadding">
                                <span id="${boxid}7" style="${visibilityStyle}">&nbsp;</span>
                            </td>
                        </tr>
                     </c:if>
                </table>
                <c:if test="${typeNestingLevel > 0}">
                    <syswf:component name="/core/schema/view/schemaViewHint" prefix="Hint" wrap="${false}">
                        <syswf:param name="goToFunction" value="${goToFunction}" />
                        <syswf:param name="element" value="${element}" />
                        <syswf:param name="base" value="${base}" />
                        <syswf:param name="elementHolder" value="${elementHolder}" />
                        <syswf:param name="boxid" value="${boxid}" />
                    </syswf:component>
                </c:if>
            </c:when>
        
            
            <c:when test="${element.hasChildren}">
                <td class="NoMarginNoPadding" rowspan="2">
                    <table class="NoMarginNoPadding">
                        <tr>
                            <td class="NoMarginNoPadding">
                                <c:choose>
                                    <c:when test="${minOccurs or $maxOccurs}">
                                        <table class="NoMarginNoPadding">
                                            <tr class="NoMarginNoPadding">
                                                <td class="NoMarginNoPadding" style="font-size:10px">&nbsp;</td>
                                            </tr>
                                            <tr class="NoMarginNoPadding">
                                                <td class="NoMarginNoPadding" valign="middle">
                                                    <c:if test="${!(element.type == 'simpleContent' || element.type == 'complexContent')}" >
                                                        <img align="middle" class="XSDGraphImg" src="${imgLocation}/${element.type}.png"/>
                                                    </c:if>
                                                </td>
                                            </tr>
                                            <tr class="NoMarginNoPadding">
                                                <td class="NoMarginNoPadding" style="text-align:right;font-size:10px"><div style="margin-right:15px">${minOccurs}..${maxOccurs}"/></div></td>
                                            </tr>
                                        </table>
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${!(element.type == 'simpleContent' || element.type == 'complexContent' || element.type == 'group' || element.type == 'attributeGroup')}" >
                                            <img align="absmiddle" class="XSDGraphImg" src="${imgLocation}/${element.type}.png"/>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="NoMarginNoPadding">
                                <table class="NoMarginNoPadding">
                                    <c:forEach var="child" items="${element.children}" varStatus="status">
                                        <c:set var="content" >
                                            <syswf:component name="/core/schema/elementStructure" prefix="Str${status.index}" wrap="${false}">
                                                <syswf:param name="goToFunction" value="${goToFunction}" />
                                                <syswf:param name="parents" value="${copyOfParents}" />
                                                <syswf:param name="localNameAlias" value="" />
                                                <syswf:param name="element" value="${child}" />
                                                <syswf:param name="parentHolder" value="${elementHolder}" />
                                                <syswf:param name="base" value="${child}" />
                                                <syswf:param name="inTable" value="${true}" />
                                                <syswf:param name="typeNestingLevel" value="${typeNestingLevel}" />
                                                <syswf:param name="maximumNestingLevel" value="${maximumNestingLevel}" />
                                                <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
                                            </syswf:component>
                                        </c:set>
                                        
                                        <syswf:component name="/core/schema/view/schemaViewConnection" prefix="Box${status.index}" wrap="${false}">
                                            <syswf:param name="content" value="${content}" />
                                            <syswf:param name="position" value="${status.index}" />
                                            <syswf:param name="last" value="${status.last}" />
                                            <syswf:param name="imgLocation" value="${imgLocation}" />
                                        </syswf:component>
                                    </c:forEach>    
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </c:when>
            
            <c:otherwise>
                <c:if test="${not empty element.type}">
                    Could not resolve ${element.type} ${element.namespace}:${element.localName}<br/>
                </c:if>
            </c:otherwise>
        </c:choose>
</c:catch>

<c:if test="${not empty exception}">
    Internal error for element ${element.namespace}:${localNameAlias}. ${exception}
    <br/>
    <c:forEach var="stackTraceElem" items="${exception.stackTrace}">
        <c:out value="${stackTraceElem}"/><br/>
    </c:forEach>
</c:if>

