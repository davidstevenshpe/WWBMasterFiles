<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${mode eq 'table' || mode eq 'view'}">
  <c:choose> 
    <c:when test="${this.value eq 'Green'}"><span class="UI Icon HealthGreen ProjectStatus"></span></c:when>
    <c:when test="${this.value eq 'Yellow'}"><span class="UI Icon HealthYellow ProjectStatus"></span></c:when>
    <c:when test="${this.value eq 'Red'}"><span class="UI Icon HealthRed ProjectStatus"></span></c:when>

    <c:otherwise><span><c:out value="${this.value}" /></span></c:otherwise>
  </c:choose>
</c:if>
