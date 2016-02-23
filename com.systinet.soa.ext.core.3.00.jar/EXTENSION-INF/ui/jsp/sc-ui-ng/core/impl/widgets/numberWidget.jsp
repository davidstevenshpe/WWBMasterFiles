<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<c:if test="${mode eq 'view'}">
    <c:if test="${not empty this.value}"><c:out value="${textBefore}" /></c:if>
    <c:out value="${this.value}" />
    <c:if test="${not empty this.value}"><c:out value="${textAfter}" /></c:if>
</c:if>

<c:if test="${mode eq 'edit'}">
    <c:out value="${textBefore}" />
    <syswf:input name="numberWidget" value="${this}" property="value">
        <syswf:attribute name="class">UI Form Text LongInt</syswf:attribute>
    </syswf:input>
    <c:out value="${textAfter}" />    
</c:if>