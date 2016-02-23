<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<syswf:control mode="anchor" wrapper="span" caption="${categoryCount.category.name} (${categoryCount.count})" targetTask="/common/categorization/categoryView">
    <syswf:param name="tModelKey">${categoryCount.category.tModelKey}</syswf:param>
    <syswf:param name="categoryId">${categoryCount.category.id}</syswf:param>
    <c:if test="${not empty class}">
        <syswf:attribute name="class" value="${class}" />
    </c:if>
	<c:if test="${not empty views}">
		<syswf:param name="views" value="${views}" />
	</c:if>
</syswf:control>