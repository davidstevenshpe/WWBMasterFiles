<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:if test="${not empty tModelKey}">
<div class="UI Breadcrumbs">
    <syswf:control mode="anchor" targetTask="/common/categorization/categoryView" caption="Categories" />
    &gt;
    <syswf:control mode="anchor" caption="${taxonomyName}" targetTask="/common/categorization/categoryView" id="t">
        <syswf:param name="tModelKey">${tModelKey}</syswf:param>
    </syswf:control>
    <c:if test="${not empty categories}">
        <c:forEach items="${categories}" var="category" varStatus="status">
            &gt;
            <syswf:control mode="anchor" caption="${category.name}" targetTask="/common/categorization/categoryView" id="${status.index}">
                <syswf:param name="tModelKey">${category.tModelKey}</syswf:param>
                <syswf:param name="categoryId">${category.id}</syswf:param>
            </syswf:control>
        </c:forEach>
    </c:if>
</div>
</c:if>
