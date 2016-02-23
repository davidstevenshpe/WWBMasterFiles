<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:set var="output">
    <syswf:component name="/core/impl/widget/richTextAreaWidget" prefix="richText" wrap="false">
        <syswf:param name="model" value="${model}"/>
        <syswf:param name="mode" value="${mode}"/>
        <syswf:param name="dataType" value="${dataType}"/>
        <syswf:param name="height" value="120"/>
    </syswf:component>
</c:set>
<c:choose>
    <c:when test="${mode eq 'view'}">
        <div class="UI Text Description">
            <c:out value="${output}" escapeXml="false"/>
        </div>
    </c:when>
    <c:otherwise>
        <c:out value="${output}" escapeXml="false"/>
    </c:otherwise>
</c:choose>
