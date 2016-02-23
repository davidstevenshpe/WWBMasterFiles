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
    
    <tr>
        <c:forEach var="columnDescription" items="${columnsDescriptions}">
            <td>
                <syswf:component name="${columnDescription.component}" prefix="${columnDescription.prefix}">
                    <syswf:param name="value" value="${column}" />
                    <syswf:param name="listener" value="${listener}" />
                    <syswf:param name="parentPrefix" value="${prefix}" />
                    <syswf:param name="containerId" value="${containerId}" />
                </syswf:component>
            </td>
        </c:forEach>
        
        <td>
            <c:if test="${column.deletable}">
                <fmt:message var="deleteTitleRow" key="listEditorHiearchicalRow.delete" bundle="${bundle}">
                    <fmt:param value="${column.label}"/>
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