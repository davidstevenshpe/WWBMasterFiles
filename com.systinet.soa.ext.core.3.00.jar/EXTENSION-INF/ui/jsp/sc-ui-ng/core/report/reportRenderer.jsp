<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${not empty rendererComponentName}">
<syswf:component name="${rendererComponentName}" prefix="renderer">
    <syswf:param name="report" value="${report}" />
</syswf:component>
</c:if>
