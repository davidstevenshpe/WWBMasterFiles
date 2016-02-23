<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
    <c:when test="${not empty this.items}">
    	<ul>
        <c:forEach items="${this.items}" var="item">
            <li>
                <syswf:component name="/core/impl/util/artifactLinkRenderer" prefix="top.domain.link.${item.uuid}">
                    <syswf:param name="uuid" value="${item.uuid}"/>
                    <syswf:param name="caption" value="${item.name}"/>
                    <syswf:param name="class" value="truncate-long-text"/>
                </syswf:component>
            </li>
        </c:forEach>
        </ul>
    </c:when>
    <c:otherwise>
        <c:out value="${noResults}" escapeXml="false"/>
    </c:otherwise>
</c:choose>
