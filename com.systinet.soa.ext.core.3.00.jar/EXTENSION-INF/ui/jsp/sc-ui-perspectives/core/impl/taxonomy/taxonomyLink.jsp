<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:if test="${empty caption}">
    <c:set var="caption" value="${taxonomy.artifact.name}" />
</c:if>
<syswf:control mode="anchor" caption="${caption}" targetTask="/common/categorization/categoryView">
    <syswf:param name="tModelKey">${taxonomy.tModelKey}</syswf:param>
    <c:if test="${not empty class}">
        <syswf:attribute name="class" value="${class}" />
    </c:if>
</syswf:control>