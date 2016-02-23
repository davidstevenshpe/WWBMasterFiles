<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${not empty breadcrumbs}">
    <div class="UI Breadcrumbs">    
<%--c:if test="${not empty trimmed}">
    ... &gt;
</c:if--%>
<c:forEach items="${breadcrumbs}" var="crumb">
    <syswf:control mode="anchor" caption="${crumb.taskCaption}" targetDepth="${crumb.targetDepth}" />
    &gt;
</c:forEach>
    </div>
</c:if>