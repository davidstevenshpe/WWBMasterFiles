<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
    <c:when test="${mode eq 'table' || this.hierarchical || this.multiple}">
        <c:forEach items="${this.categories}" var="category" varStatus="stat">
            <%-- settings as variable to ensure there is no space before comma --%>
            <c:set var="itemValue">
                <c:choose>
                    <c:when test="${category.error}">
                        <fmt:message var="categoryNotFound" key="category.categoryNotFound" bundle="${widgetMessages}">
                            <fmt:param><c:out value="'${category.displayValue}'"/></fmt:param>
                        </fmt:message>
                        <span title="${categoryNotFound}" class="x-form-invalid-msg UI Invalid"><c:out value="${category.displayValue}"/></span>
                    </c:when>
                    <c:when test="${mode eq 'table'}">
                    <span title="<c:out value="${category.displayValue}"/>"><c:out value="${category.displayValue}"/></span>
                    </c:when>
                    <c:otherwise>
                        <c:out value="${category.displayValue}" />
                    </c:otherwise>
                </c:choose>
            </c:set>

            <c:set var="separator">
                <c:choose>
                    <c:when test="${category.showParents}"><br/></c:when>
                    <c:when test="${mode eq 'edit'}">&nbsp;&nbsp;</c:when>
                    <c:when test="${not stat.last}">,</c:when>
                </c:choose>
            </c:set>

            <c:out value="${itemValue}" escapeXml="false"/>${separator}

        </c:forEach>
    </c:when>
</c:choose>