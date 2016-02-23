<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
//<![CDATA[
    <c:if test="${not empty customizedParams}">
	<c:forEach items="${customizedParams}" var="custParam" varStatus="status">
	var ${custParam.key} = '${custParam.value}';
	</c:forEach>
	</c:if>
    <c:out value="${this.stubs}" escapeXml="false"/>
    <c:if test="${not empty clientJs}">
    <c:out value="${clientJs}" escapeXml="false"/>
    </c:if>
//]]>
</script>
<c:if test="${not empty clientHtml}">
<c:out value="${clientHtml}" escapeXml="false"/>
</c:if>