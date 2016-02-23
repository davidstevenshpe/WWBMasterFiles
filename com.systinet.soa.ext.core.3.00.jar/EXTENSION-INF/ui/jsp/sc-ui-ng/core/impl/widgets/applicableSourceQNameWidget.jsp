<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${mode eq 'view' or mode eq 'table'}">
   <syswf:out value="${applicableTo}" context="HtmlBody"/>
</c:if>
