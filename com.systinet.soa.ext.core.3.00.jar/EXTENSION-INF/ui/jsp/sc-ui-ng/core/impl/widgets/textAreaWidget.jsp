<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${mode eq 'view'}">
    <c:out value="${this.value}" />
</c:if>

<c:if test="${mode eq 'edit'}">
    <syswf:textArea id="textArea" name="textArea" 
            value="${this}" property="value">
    </syswf:textArea>
</c:if>