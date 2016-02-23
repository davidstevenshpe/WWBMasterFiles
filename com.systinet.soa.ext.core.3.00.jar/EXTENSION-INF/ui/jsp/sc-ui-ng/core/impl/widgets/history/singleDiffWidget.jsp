<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<table class="RevisionDetails">
<c:if test="${not empty this.value.groupLabel}">
    <tr><td>
        <h3>${this.value.groupLabel}</h3>
    </td></tr>
</c:if>
<c:forEach items="${this.value.values}" var="val" varStatus="status">
    <tr>
    <c:choose>
        <c:when test="${empty val}">
            <c:choose>
                <c:when test="${this.value.types[status.index] eq 'REMOVED'}">
                    <td class="icon removed">removed</td>
                </c:when>
                <c:otherwise>
                    <td class="nochange">&nbsp;</td>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <c:set var="class">
                <c:choose>
                    <c:when test="${this.value.types[status.index] eq 'CHANGED'}">changed</c:when>
                    <c:when test="${this.value.types[status.index] eq 'ADDED'}">added</c:when>
                    <c:when test="${this.value.types[status.index] eq 'REMOVED'}">removed</c:when>
                    <c:otherwise>
                        nochange
                    </c:otherwise>
                </c:choose>
            </c:set>
            <td<c:if test="${not empty class}"> class="${class}"</c:if>>
                <c:if test="${not empty this.value.labels[status.index]}">${this.value.labels[status.index]} </c:if>
                <c:if test="${this.escapedHtml eq false}">${val}</c:if>
                <c:if test="${this.escapedHtml eq true}"><syswf:out context="HtmlBody" value="${val}"/></c:if>
            </td>
        </c:otherwise>
    </c:choose>
    </tr>
</c:forEach> 
</table>