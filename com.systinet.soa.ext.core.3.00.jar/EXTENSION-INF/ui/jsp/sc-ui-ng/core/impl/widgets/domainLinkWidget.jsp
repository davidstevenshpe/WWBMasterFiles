<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
    <c:when test="${not empty this.domainUri && not empty this.name}">
        <syswf:control mode="anchor" caption="${this.name}" targetTask="${this.domainUri}">
        <c:if test="${not empty targetTabId}">
          <syswf:param name="tabId" value="${targetTabId}"/>
        </c:if>
        </syswf:control>
    </c:when>
    <c:when test="${not empty this.name}">
        <syswf:out value="${this.name}" context="HtmlBody"/>
    </c:when>
</c:choose>
