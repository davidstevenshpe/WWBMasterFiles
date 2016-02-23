<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:input id="${prefix}_search_expression" name="searchExpression" property="searchExpression" value="${this.bean}" mode="hidden">
</syswf:input>

<syswf:input id="${prefix}_id" name="id" property="id" value="${this.bean}" mode="hidden">
</syswf:input>

<c:if test="${not empty jsonBuilder and (not empty this.bean.searchExpression or not empty this.data)}">

    <c:forEach var="dataRow" items="${this.data}" varStatus="rowStatus">

        <c:set target="${jsonBuilder}" property="rowNumber" value="${rowStatus.index}" />

        <c:forEach var="col" items="${this.config.table.columns}">

            <c:set target="${jsonBuilder}" property="columnName" value="${col.id}" />

            <c:set target="${jsonBuilder}" property="columnValue">

                <c:forEach var="colContent" items="${col.contents}" varStatus="contStatus">
                    <c:if test="${contStatus.first}">
                        <c:choose>
                            <c:when test="${empty colContent.componentName}">
                                <c:out value="${dataRow[col.id]}" escapeXml="false" />
                            </c:when>
                            <c:otherwise>
                                <syswf:component name="${colContent.componentName}" prefix="${col.id}${rowStatus.index}_${contStatus.index}" wrap="false">
                                    <syswf:param name="dataRow" value="${dataRow}" />
                                </syswf:component>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>

            </c:set>

        </c:forEach>

    </c:forEach>

    <c:if test="${not empty fixedItem && showFixedItem}">
        <c:set target="${jsonBuilder}" property="fictiveLineColumnName" value="${fixedItem.value.columnName}" />
        <c:set target="${jsonBuilder}" property="fictiveLine">
            <a id="${prefix}FixedItem" href="javascript:void(0);" class="${fixedItem.value.style}" onclick="${fixedItemControlName}()"><span>${fixedItemLabel}</span></a>
        </c:set>
    </c:if>

    <script type="text/javascript">
//<![CDATA[

	    Ext.onReady(function(){
		   	${prefix}_ds.loadData(scTableUnescapeJSON(${jsonBuilder.output}));
	    });
	
//]]>
</script>
</c:if>