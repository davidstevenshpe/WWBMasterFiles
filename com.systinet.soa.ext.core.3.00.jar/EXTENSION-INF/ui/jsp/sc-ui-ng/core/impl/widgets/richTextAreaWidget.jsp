<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:choose>
    <c:when test="${mode eq 'view'}">
        <c:out value="${this.value}" escapeXml="false"/>
    </c:when>
    <c:when test="${mode eq 'table'}">
        <c:out value="${this.value}" escapeXml="false"/>
    </c:when>
    <c:when test="${mode eq 'edit'}">
        <syswf:textArea id="${prefix}_richTextAreaWidget" name="richTextAreaWidget"
                value="${this}" property="value">
        </syswf:textArea>
        <syswf:component name="/core/impl/edit/richTextEditor" prefix="${prefix}_richText" wrap="false">
            <syswf:param name="textAreaId" value="${prefix}_richTextAreaWidget"/>
            <syswf:param name="specificationPage" value="${specificationPage}"/>
        </syswf:component>
    </c:when>
</c:choose>