<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<c:if test="${mode eq 'table'}">
   <label title="${this.valueHint}"><c:out value="${this.value}"/></label>
</c:if>  