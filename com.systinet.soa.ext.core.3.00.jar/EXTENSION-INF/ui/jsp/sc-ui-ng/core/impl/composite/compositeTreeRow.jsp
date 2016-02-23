<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.composite.compositeMessages" var="compositeMessages"/>

<c:set var="highlightRow" value="${false}"/>
<c:forEach items="${treeDisplayState.foundRowPaths}" var="highlightedRowPath">
    <c:if test="${highlightedRowPath eq this.rowWrapper.rowPath}">
        <c:set var="highlightRow" value="${true}"/>    
    </c:if>
</c:forEach>

<c:choose>    
    <c:when test="${empty this.rowWrapper.parent and currentDepth == 0}">

        <%-- it is a root node --%>
        <c:choose>
            <c:when test="${not displayHeadings}">
                <thead>
            </c:when>
            <c:otherwise>
                <tbody>
            </c:otherwise>
        </c:choose>
            <tr>
                <c:if test="${treeDisplayState.selectionMode ne 'none'}">
                    <td><c:if test="${this.rowWrapper.acceptable}">
                        <input type="radio" name="${rootPrefix}$selectedItem" value="${this.rowWrapper.rowPathSuffix}"/>
                    </c:if></td>
                </c:if>
                <c:forEach items="${treeDisplayState.resultContent[this.rowWrapper.rowPath]}" var="column" varStatus="columnStatus">
                    <td>
                        <c:forEach var="content" items="${column.content}" varStatus="contentStatus">
                            <c:choose>
                                <c:when test="${not empty content.componentName}">
                                    <c:if test="${columnStatus.first}">
                                        <c:set var="style">background-image: url(${webContext}/artifactIcon?type=${this.rowWrapper.cells._sdmName}&format=small);</c:set>
                                        <div class="Icon" style="${style}"></div>
                                        <span class="TreeNodeLabel">
                                    </c:if>
                                    <c:if test="${highlightRow and columnStatus.first}">
                                        <b>
                                    </c:if>
                                    <syswf:component prefix="hr${rowStatus.index}c${columnStatus.index}s${contentStatus.index}" name="${content.componentName}" wrap="false">
                                        <syswf:paramSet value="${content.parameters}"/>
                                        <c:if test="${columnStatus.first}">                                            
                                            <syswf:param name="detailContextParams" value="${detailContextParams}"/>                                            
                                        </c:if>
                                    </syswf:component>
                                    <c:if test="${highlightRow and columnStatus.first}">   
                                        </b>
                                    </c:if>
                                    <c:if test="${columnStatus.first}">
                                        </span>
                                    </c:if>                                    
                                </c:when>
                                <c:otherwise>
                                    <c:out value="${content.parameters['value']}"/>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </td>
                </c:forEach>
            </tr>
        <c:if test="${not displayHeadings}">
            </thead>
            <tbody>
        </c:if>
            <c:if test="${this.rowWrapper.expanded}">
                <%-- recursively render child rows if any --%>
                <c:set var="rowPath" value="${this.rowWrapper.rowPath}"/>
                <c:set var="groupedRows" value="${treeDisplayState.rowsIndex[rowPath].groupedRows}"/>
                <c:set var="ungroupedRows" value="${treeDisplayState.rowsIndex[rowPath].ungroupedRows}"/>
                <c:set var="expandedGroups" value="${treeDisplayState.rowsIndex[rowPath].groupedRowsStatus}"/>
    
                <c:if test="${not empty groupedRows}">
                    <c:forEach items="${groupedRows}" var="entry" varStatus="status">
                        
                        <c:set var="expandGroup" value="${expandAll or expandedGroups[entry.key]}"/>
                        
                        <c:choose>
                            <c:when test="${empty gns[entry.key]}">
                                <c:choose>
                                    <c:when test="${expandGroup}">
                                        <c:set var="groupingNodeTrClass" value="exp"/>
                                    </c:when>
                                    <c:otherwise>
                                        <%-- setting the rendered grouping column tr tag class to default value which is collapsed--%>
                                        <c:set var="groupingNodeTrClass" value="coll"/>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <c:set var="groupingNodeTrClass" value="${gns[entry.key]}"/>
                            </c:otherwise>
                        </c:choose>
    
                        <tr class="level${currentDepth + 1} ${groupingNodeTrClass}" id="${prefix}g${status.index}">
                            <c:if test="${treeDisplayState.selectionMode ne 'none'}">
                                <td>&nbsp;</td>
                            </c:if>
                            <td>
                                <div class="Node"><a href="javascript:void(0);"><span class="Last" style="margin-left: ${(currentDepth) * 16}px"></span></a></div>
                                <c:set var="style">background-image: url(${webContext}/artifactIcon?type=${entry.key}&format=small);</c:set>
                                <div class="Icon" style="${style}"></div>
                                <span>${treeDisplayState.sdmTypeLabelsIndex[entry.key]} (${fn:length(entry.value)})</span>
                                <c:choose>
                                    <c:when test="${expandGroup}">
                                        <syswf:input name="gns${entry.key}" id="i${prefix}g${status.index}" value="exp" mode="hidden"/>
                                    </c:when>
                                    <c:otherwise>
                                        <syswf:input name="gns${entry.key}" id="i${prefix}g${status.index}" value="${gns[entry.key]}" mode="hidden"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <c:forEach begin="1" end="${treeDisplayState.columnCount}">
                                <td></td>
                            </c:forEach>
                        </tr>
    
                        <c:forEach items="${entry.value}" var="childRow" varStatus="innerStatus">
                            <syswf:component name="/core/impl/composite/compositeTreeRow" prefix="t${status.index}i${innerStatus.index}" wrap="false">
                                <syswf:param name="paramDecorator" value="${paramDecorator}"/>
                                <syswf:param name="treeDisplayState" value="${treeDisplayState}"/>
                                <syswf:param name="treeResultRow" value="${childRow}"/>
                                <syswf:param name="currentDepth" value="${currentDepth + 2}"/>
                                <syswf:param name="doNotRenderIcon" value="true"/>
                                <syswf:param name="rootPrefix" value="${rootPrefix}"/>
                                <syswf:param name="treeRowAcceptor" value="${treeRowAcceptor}"/>
                                <c:choose>
                                    <c:when test="${(gns[entry.key] eq 'coll' or empty gns[entry.key]) and not expandGroup}">
                                        <syswf:param name="trStyle" value="display: none;"/>
                                    </c:when>
                                    <c:otherwise>
                                        <syswf:param name="trStyle" value="display: table-row;"/>
                                    </c:otherwise>
                                </c:choose>
                            </syswf:component>
                        </c:forEach>
                    </c:forEach>
                </c:if>
                
                <c:if test="${not empty ungroupedRows}">
                    <%--<c:forEach items="${this.rowWrapper.children}" var="childRow" varStatus="status">--%>
                    <c:forEach items="${ungroupedRows}" var="childRow" varStatus="status">
                        <syswf:component name="/core/impl/composite/compositeTreeRow" prefix="u${status.index}" wrap="false">
                            <syswf:param name="paramDecorator" value="${paramDecorator}"/>
                            <syswf:param name="treeDisplayState" value="${treeDisplayState}"/>
                            <syswf:param name="treeResultRow" value="${childRow}"/>                        
                            <syswf:param name="currentDepth" value="${currentDepth + 1}"/>
                            <syswf:param name="doNotRenderIcon" value="false"/>
                            <syswf:param name="rootPrefix" value="${rootPrefix}"/>
                            <syswf:param name="treeRowAcceptor" value="${treeRowAcceptor}"/>
                        </syswf:component>
                    </c:forEach>
                </c:if>
            </c:if>
        </tbody>
    </c:when>    
    <c:otherwise>
        <c:set var="trClass" value="level${currentDepth}"/>
        <c:set var="spanClass" value=""/>
        <c:set var="trStyle" value="${trStyle}"/>
        <c:set var="spanStyle" value="margin-left: ${(currentDepth - 1) * 16}px"/>
        <c:choose>
            <c:when test="${this.rowWrapper.expandable}">
                <c:choose>
                    <c:when test="${this.rowWrapper.expanded}">
                        <c:set var="trClass" value="${trClass} exp"/>        
                    </c:when>
                    <c:otherwise>
                        <c:set var="trClass" value="${trClass} coll"/>  
                    </c:otherwise>
                </c:choose>            
            </c:when>
            <c:otherwise>
                <c:set var="trClass" value="${trClass} exp"/>
                <c:set var="spanClass" value="Leaf"/>        
            </c:otherwise>
        </c:choose>
                    
        <tr class="${trClass}" style="${trStyle}">                
            <c:if test="${treeDisplayState.selectionMode ne 'none'}">
                <td><c:if test="${this.rowWrapper.acceptable}">
                    <input type="radio" name="${rootPrefix}$selectedItem" value="${this.rowWrapper.rowPathSuffix}"/>
                </c:if></td>
            </c:if>
            <c:forEach items="${treeDisplayState.resultContent[this.rowWrapper.rowPath]}" var="column" varStatus="columnStatus">            
                <td>
                    <c:if test="${columnStatus.first}">
                        <c:choose>
                            <c:when test="${this.rowWrapper.expandable}">
                                <div class="Node Expandable" id="${this.componentId}">
                                    <a href="javascript:void(0);">
                                        <span class="${spanClass}" style="${spanStyle}">
                                        </span>
                                    </a>
                                </div>
                            </c:when>                                
                            <c:otherwise>
                                <div class="Node" id="${this.componentId}">
                                   <a href="javascript:void(0);"> 
                                        <span class="${spanClass}" style="${spanStyle}">
                                        </span>
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>                               
                    </c:if>                          
                    
                    <c:forEach var="content" items="${column.content}" varStatus="contentStatus">                       
                        <c:choose>
                            <c:when test="${not empty content.componentName}">
                                <%-- if it is the name column then add an artifact icon --%>
                                <c:if test="${columnStatus.first and not doNotRenderIcon}">
                                    <c:set var="style">background-image: url(${webContext}/artifactIcon?type=${this.rowWrapper.cells._sdmName}&format=small);</c:set>
                                    <div class="Icon" style="${style}"></div>                                    
                                </c:if>
                                <c:if test="${columnStatus.first}">
                                    <span class="TreeNodeLabel" title="${treeDisplayState.sdmTypeSingularLabelIndex[this.rowWrapper.cells._sdmName]}">
                                </c:if>
                                <c:if test="${highlightRow and columnStatus.first}">   
                                    <b>
                                </c:if> 
                                <syswf:component prefix="hr${rowStatus.index}c${columnStatus.index}s${contentStatus.index}" name="${content.componentName}" wrap="false">
                                    <syswf:paramSet value="${content.parameters}"/>
                                    <c:if test="${columnStatus.first}">
                                        <syswf:param name="detailContextParams" value="${detailContextParams}"/>                                        
                                    </c:if>
                                </syswf:component>
                                <c:if test="${highlightRow and columnStatus.first}">   
                                    </b>
                                </c:if>
                                <c:if test="${columnStatus.first}">
                                    </span>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <c:out value="${content.parameters['value']}"/>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </td>    
            </c:forEach>                                        
        </tr>

        <%-- recursively render child rows if any --%>
        <c:if test="${this.rowWrapper.expanded}">
            <c:set var="rowPath" value="${this.rowWrapper.rowPath}"/>
            <c:set var="groupedRows" value="${treeDisplayState.rowsIndex[rowPath].groupedRows}"/>
            <c:set var="ungroupedRows" value="${treeDisplayState.rowsIndex[rowPath].ungroupedRows}"/>
            <c:set var="expandedGroups" value="${treeDisplayState.rowsIndex[rowPath].groupedRowsStatus}"/> 

            <c:if test="${not empty groupedRows}">                           
                <c:forEach items="${groupedRows}" var="entry" varStatus="status">

                    <c:set var="expandGroup" value="${expandAll or expandedGroups[entry.key]}"/>
                    
                    <c:choose>
                        <c:when test="${empty gns[entry.key]}">
                            <c:choose>
                                <c:when test="${expandGroup}">
                                    <c:set var="groupingNodeTrClass" value="exp"/>
                                </c:when>
                                <c:otherwise>
                                    <%-- setting the rendered grouping column tr tag class to default value which is collapsed--%>
                                    <c:set var="groupingNodeTrClass" value="coll"/>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <c:set var="groupingNodeTrClass" value="${gns[entry.key]}"/>
                        </c:otherwise>
                    </c:choose>

                    <tr class="level${currentDepth + 1} ${groupingNodeTrClass}" id="${prefix}g${status.index}">
                        <c:if test="${treeDisplayState.selectionMode ne 'none'}">
                            <td>&nbsp;</td>
                        </c:if>
                        <td>                            
                            <div class="Node"><a href="javascript:void(0);"><span class="Last" style="margin-left: ${(currentDepth) * 16}px"></span></a></div>
                            <c:set var="style">background-image: url(${deploymentUrl}/artifactIcon?type=${entry.key}&format=small);</c:set>
                            <div class="Icon" style="${style}"></div>                            
                            <span>${treeDisplayState.sdmTypeLabelsIndex[entry.key]} (${fn:length(entry.value)})</span>
                            <c:choose>
                                <c:when test="${expandGroup}">
                                    <syswf:input name="gns${entry.key}" id="i${prefix}g${status.index}" value="exp" mode="hidden"/>
                                </c:when>
                                <c:otherwise>
                                    <syswf:input name="gns${entry.key}" id="i${prefix}g${status.index}" value="${gns[entry.key]}" mode="hidden"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <c:forEach begin="1" end="${treeDisplayState.columnCount}">
                            <td></td>
                        </c:forEach>
                    </tr>

                    <c:forEach items="${entry.value}" var="childRow" varStatus="innerStatus">
                        <syswf:component name="/core/impl/composite/compositeTreeRow" prefix="t${status.index}i${innerStatus.index}" wrap="false">
                            <syswf:param name="paramDecorator" value="${paramDecorator}"/>
                            <syswf:param name="treeDisplayState" value="${treeDisplayState}"/>
                            <syswf:param name="treeResultRow" value="${childRow}"/>                        
                            <syswf:param name="currentDepth" value="${currentDepth + 2}"/>
                            <syswf:param name="doNotRenderIcon" value="true"/>
                            <syswf:param name="rootPrefix" value="${rootPrefix}"/>
                            <syswf:param name="treeRowAcceptor" value="${treeRowAcceptor}"/>
                            <c:choose>
                                <c:when test="${(gns[entry.key] eq 'coll' or empty gns[entry.key]) and not expandGroup}">
                                    <syswf:param name="trStyle" value="display: none;"/>
                                </c:when>
                                <c:otherwise>
                                    <syswf:param name="trStyle" value="display: table-row;"/>
                                </c:otherwise>
                            </c:choose>
                        </syswf:component>
                    </c:forEach>
                </c:forEach>                
            </c:if>
            
            <c:if test="${not empty ungroupedRows}">                       
                <%--<c:forEach items="${this.rowWrapper.children}" var="childRow" varStatus="status">--%>
                <c:forEach items="${ungroupedRows}" var="childRow" varStatus="status">                                             
                    <syswf:component name="/core/impl/composite/compositeTreeRow" prefix="u${status.index}" wrap="false">
                        <syswf:param name="paramDecorator" value="${paramDecorator}"/>
                        <syswf:param name="treeDisplayState" value="${treeDisplayState}"/>
                        <syswf:param name="treeResultRow" value="${childRow}"/>                        
                        <syswf:param name="currentDepth" value="${currentDepth + 1}"/>
                        <syswf:param name="doNotRenderIcon" value="false"/>
                        <syswf:param name="rootPrefix" value="${rootPrefix}"/>
                        <syswf:param name="treeRowAcceptor" value="${treeRowAcceptor}"/>
                    </syswf:component>
                </c:forEach>
            </c:if>            
        </c:if>
    </c:otherwise>
</c:choose>