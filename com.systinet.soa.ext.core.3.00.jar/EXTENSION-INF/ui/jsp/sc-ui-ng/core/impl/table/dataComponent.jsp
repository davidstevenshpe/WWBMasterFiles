<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.uimessages" var="uiMessages"/>
<fmt:message key="TABLE_COMPONENT_COUNTING_STATUS" bundle="${uiMessages}" var="countingStatusLabel"/>

<c:if test="${hasSelection && enableSelectAll}">
    <syswf:control caption="${tableId}_selectAll" action="selectAll" mode="ajax" />
    <syswf:control caption="${tableId}_unselectAll" action="unselectAll" mode="ajax"/>        
 
</c:if>

<c:if test="${table.selectionModel == 'multiple'}">
    <c:choose>
        <c:when test="${enableSelectAll && contentInfo.multipage}">
            <c:set var="selectAllCheckboxId" value="${tableId}_selectAll_checkbox" />
        </c:when>
        <c:otherwise>
            <c:set var="selectAllCheckboxId" value="${tableId}_selectAll" />
        </c:otherwise>
    </c:choose>
</c:if>

<c:forEach var="row" items="${resultContent}" varStatus="rowStatus">

    <c:set target="${jsonBuilder}" property="rowNumber" value="${rowStatus.index}"/>

    <c:set var="enabledSelection" value="${true}"/>

    <c:forEach var="column" items="${row}" varStatus="columnStatus">
        <c:set target="${jsonBuilder}" property="columnName" value="${column.id}"/>

        <c:if test="${column.id == '_id'}">
            <c:set var="rowId" value="${column.content[0].parameters['value']}"/>
        </c:if>
        <c:if test="${column.id == '_enabledSelection'}">
            <c:set var="enabledSelection" value="${column.content[0].parameters['value']}"/>
        </c:if>
        <c:if test="${column.id == '_selectionValue'}">
            <c:set var="selectionValue" value="${column.content[0].parameters['value']}"/>
        </c:if>

        <c:set target="${jsonBuilder}" property="columnValue">
            <c:forEach var="content" items="${column.content}" varStatus="contentStatus">
                <c:choose>
                    <c:when test="${not empty content.componentName}">
                        <c:choose>
                            <c:when test="${not empty rowId}">
                                <c:set var="rowPrefix" value="${rowId}"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="rowPrefix" value="row${rowStatus.index}"/>
                            </c:otherwise>
                        </c:choose>
                        <syswf:component prefix="${rowPrefix}_${columnStatus.index}_${contentStatus.index}"
                                         name="${content.componentName}" wrap="false">
                            <syswf:paramSet value="${content.parameters}"/>
                            <syswf:param name="dataPrefix" value="${prefix}"/>
                            <syswf:param name="rowIndex" value="${rowStatus.index}"/>
                         </syswf:component>
                    </c:when>
                    <c:otherwise>
                        <c:out value="${content.parameters['value']}"/>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </c:set>
    </c:forEach>
    <c:if test="${hasSelection && not empty rowId}">
        <c:set target="${jsonBuilder}" property="columnName" value="_selection"/>

        <c:set var="selectionMode"><c:choose>
            <c:when test="${table.selectionModel == 'multiple'}">checkbox</c:when>
            <c:otherwise>radio</c:otherwise>
        </c:choose></c:set>

        <c:set target="${jsonBuilder}" property="columnValue">
            <syswf:selectOne name="selectionVisual" id="${prefix}_selectionRow${rowStatus.index}"
                  mode="${selectionMode}" optionValues="${selectionValue}"
                  optionCaptions="" value="${selectionBag.selectionMap[selectionValue]}" optionValuesEnabled="${enabledSelection}" >
                <syswf:attribute name="class" value="UI Form Checkbox"/>
            </syswf:selectOne>
            <script type="text/javascript">
//<![CDATA[

             Ext.onReady(function() {
               Ext.get("${prefix}_selectionRow${rowStatus.index}_0").on("click",function(){ SCenabledisableToolbar('${tableId}',this, ${unselectionPossible});<c:choose>
                   <c:when test="${table.selectionModel == 'multiple'}">
                        SCsynchronizeSelection('${prefix}_selectionRow${rowStatus.index}_0','${prefix}_selectionRow${rowStatus.index}_0_hidden');
                        SCsychronizeSelectAllCheckbox('${selectAllCheckboxId}','${tableId}Container','${tableId}', ${unselectionPossible});
                   </c:when>
                   <c:otherwise>SCsynchronizeSelectionRadio('${prefix}_selectionRow${rowStatus.index}_0','${prefix}_selectionRow${rowStatus.index}_0_hidden', '${prefix}', '${prefix}_selectionRow', '_hidden');</c:otherwise>
               </c:choose>
                <c:if test="${highlightSelected}">
                    Datagrid.Handler.RowHighlightSwitch("${prefix}_selectionRow${rowStatus.index}_0");
                </c:if>
               });
             });
            
//]]>
</script>
        </c:set>

        <syswf:input name="selection" value="${selectionBag.selectionMap[selectionValue]}"
                     id="${prefix}_selectionRow${rowStatus.index}_0_hidden" mode="hidden"/>
    </c:if>
</c:forEach>

<c:forEach var="column" items="${table.dataColumns}">
    <c:if test="${not empty tableStateHolder.filterValues[column.id]}">
        <syswf:input name="filter_${column.id}" value="${tableStateHolder.filterValues[column.id]}" property="value"
                     id="${prefix}_filter_${column.id}" mode="hidden"/>
    </c:if>
</c:forEach>

<syswf:input name="start" value="${tableStateHolder}" property="start" mode="hidden" dataType="int"/>
<syswf:input name="limit" value="${tableStateHolder}" property="limit" mode="hidden" dataType="int"/>
<syswf:input name="sort" value="${tableStateHolder}" property="sort" mode="hidden"/>
<syswf:input name="dir" value="${tableStateHolder}" property="dir" mode="hidden"/>

<c:if test="${contentInfo.hasContent}">
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function(){
            <c:if test="${empty dontSort || not dontSort}">
            ${tableId}Store.setDefaultSort('${tableStateHolder.sort}','${tableStateHolder.dir}');
            </c:if>
            ${tableId}Store.loadData(scTableUnescapeJSON(${jsonBuilder.output}));

            <c:choose>
            <c:when test="${contentInfo.multipage}">
                if (${tableId}PagingToolbar.container) { ${tableId}PagingToolbar.container.setStyle({display: 'block'}); }
            </c:when>
            <c:otherwise>
                if (${tableId}PagingToolbar.container) { ${tableId}PagingToolbar.container.setStyle({display: 'none'}); }
            </c:otherwise>
            </c:choose>

            //update complex table filter status icons
            var fb;
            <c:forEach var="columnEntry" items="${filterWidgetModels}">
                fb = Ext.getCmp('${tableId}-${columnEntry.key}');
                if (fb) {
                <c:choose>
                    <c:when test="${columnEntry.value.applied}">
                        fb.setIconClass('x-btn-filter-applied');
                    </c:when>
                    <c:otherwise>
                        fb.setIconClass('x-btn-filter-default');
                    </c:otherwise>
                </c:choose>
                }
            </c:forEach>

            if (${tableId}grid.filters) {
                if (${tableId}Store.totalLength < 0 && ${tableId}Store.reader.jsonData != null && ${tableId}Store.reader.jsonData.countRetrievalMethod == 'parallel') {
                    ${tableId}PagingToolbar.displayMsg = '${countingStatusLabel}';
                    ${tableId}PagingToolbar.updateInfo();
                    ${tableId}PagingToolbar.setDisabled(true);
                    ${tableId}reload();
                } else {
                    ${tableId}grid.filters.enableFilters();
                }
            }

            <c:if test="${table.selectionModel == 'multiple'}">
                SCsychronizeSelectAllCheckbox('${selectAllCheckboxId}','${tableId}Container','${tableId}', ${unselectionPossible});
            </c:if>
        });
    
//]]>
</script>
</c:if>