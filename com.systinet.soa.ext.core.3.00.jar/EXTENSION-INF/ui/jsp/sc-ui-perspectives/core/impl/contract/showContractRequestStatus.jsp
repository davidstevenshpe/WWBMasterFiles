<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--Set Locale form globalSession. --%>
<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.contract.contractmessages" var="messages"/>

<c:choose>
    <c:when test="${not empty status}">
          ${status}
    </c:when>
    <c:otherwise>
          <fmt:message key="status.pendingRequest" bundle="${messages}"/>
    </c:otherwise>
</c:choose>