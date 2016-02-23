<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="filename" value="${filePrefix}${this.resolver.version}${fileSuffix}"/>
<c:choose>
    <c:when test="${this.resolver.downloadedFiles[filename]}">
        <a href="${webResourcePath}/../../tools/${this.resolver.version}/${filename}">${title}</a>
    </c:when>
    <c:otherwise>
        <a href="${this.resolver.baseUrl}/${this.resolver.version}/${filename}">${title}</a>
    </c:otherwise>
</c:choose>
