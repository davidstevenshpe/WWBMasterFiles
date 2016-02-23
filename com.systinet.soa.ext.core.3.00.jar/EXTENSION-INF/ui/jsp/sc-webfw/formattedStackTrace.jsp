<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- This is formatted stack trace component, designed to allow use of formatted stack trace view
     in other UIcomponents. Data for this jsp file are prepared either
     by com.systinet.webfw.component.ErrorComponent class or you have to prepare it by yourselves --%>
<fmt:setBundle basename="com.systinet.webfw.ui.WebFrameworkUIMessages" var="webFrameworkUI_Messages"/>
<span class="shrException"><c:out value="${exceptionHolder.className}"/>: <c:out value="${exceptionHolder.message}"/><br/></span>
<c:forEach items="${exceptionHolder.stackTrace}" var="varTraceLine">
    <span class="shrModule"><fmt:message key="at" bundle="${webFrameworkUI_Messages}"/> <c:out value="${varTraceLine}"/><br/></span>
</c:forEach>

<c:if test="${not empty causes}">
    <br/>
    <c:forEach items="${causes}" var="exception2">
        <span class="shrException"><c:out value="${exception2.className}"/>: <c:out value="${exception2.message}"/><br/></span>
        <c:forEach items="${exception2.stackTrace}" var="varTraceLine">
            <span class="shrModule"><fmt:message key="at" bundle="${webFrameworkUI_Messages}"/> <c:out value="${varTraceLine}"/><br/></span>
        </c:forEach>
    </c:forEach>
</c:if>
