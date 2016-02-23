<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${mode eq 'table'}">
    <c:forEach items="${this.values}" var="email" varStatus="i">        
        <a href="mailto:${email}">${email}</a>
        <c:if test="${not i.last}"><br/></c:if>
    </c:forEach>
</c:if>