<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.util.utilmessages" var="bundle"/>

<table class="UI Table Properties">
           
    <c:forEach var="columnDescription" items="${columnsDescriptions}">
        <col class="${columnDescription.columnClass}" />
    </c:forEach>
           
    <%-- delete --%>
    <col class="SpacerCol" />
    
    <%-- drag and drop --%>
    <col class="SpacerCol" />
    <c:set var="tabHint" value="Tab hint"/>
	<c:set var="tabLabel" value="${column.label}"/>
    <tr>
        <c:forEach var="columnDescription" items="${columnsDescriptions}" varStatus="status">
            <td>
            	<c:choose>
            		<c:when	test="${status.count == 2}">
            			<c:set var="varListener" value="${hintListener}" />
						<c:set var="varColumn" value="${column.cloneItem}"/>
						<c:set target="${varColumn}" property="label" value="${column.hint}" />
            		</c:when>
            		<c:otherwise>
            			<c:set var="varListener" value="${listener}" />
						<c:set var="varColumn" value="${column}"/>
            		</c:otherwise>
            	</c:choose>
                <syswf:component name="${columnDescription.component}" prefix="${columnDescription.prefix}${status.count}">
                    <syswf:param name="value" value="${varColumn}" />
                    <syswf:param name="listener" value="${varListener}" />
                    <syswf:param name="parentPrefix" value="${prefix}" />
                    <syswf:param name="containerId" value="${containerId}" />
					<syswf:param name="count" value="${status.count}" />
                </syswf:component>
            </td>
        </c:forEach>
        
        <td>
            <c:if test="${column.deletable}">
                <fmt:message var="deleteTitleRow" key="listEditorHiearchicalRow.delete" bundle="${bundle}">
                    <fmt:param value="${tabLabel}"/>
                </fmt:message>
                <a href="javascript:void(0);" class="UI Icon Delete" title="<c:out value="${deleteTitleRow}"/>" id="${prefix}_delete_link"></a>
                <script type="text/javascript">
//<![CDATA[

                $('#${prefix}_delete_link').bind('click',function(){
                    ${funcDelete}();
                    return false;
                });
                
//]]>
</script>
            </c:if>
        </td>
        
        <fmt:message var="dragAndDropTitleRow" key="listEditorHiearchicalRow.dragAndDrop" bundle="${bundle}">
            <fmt:param value="${column.label}"/>
        </fmt:message>
        <td><span class="UI Icon DragnDrop" title="<c:out value="${dragAndDropTitleRow}"/>"></span></td>
    </tr>
</table>