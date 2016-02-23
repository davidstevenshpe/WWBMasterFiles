<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty resultContent}">
    <table>
</c:if>
<c:forEach var="row" items="${resultContent}" varStatus="rowStatus">
    <tr>
    <c:forEach var="column" items="${row}" varStatus="columnStatus">
        <td>
        <c:forEach var="content" items="${column.content}" varStatus="contentStatus">
            <c:choose>
                <c:when test="${not empty content.componentName}">
                    <syswf:component prefix="row${rowStatus.index}_${columnStatus.index}_${contentStatus.index}"
                                     name="${content.componentName}">
                        <syswf:paramSet value="${content.parameters}"/>
                     </syswf:component>
                </c:when>
                <c:otherwise>
                    <c:out value="${content.parameters['value']}"/>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        </td>
    </c:forEach>
    </tr>
</c:forEach>
<c:if test="${not empty resultContent}">
    </table>
</c:if>

