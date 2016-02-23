<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

    <c:choose>
      <c:when test="${this.value eq '-1'}">
         Not versioned
      </c:when>
      <c:otherwise>
         ${this.value}
      </c:otherwise>
    </c:choose>
