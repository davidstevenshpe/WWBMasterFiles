<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%--
Display description in each row of publishing report table.
 --%>
<div class="UI Text Description">
  	<c:if test="${resourceStatus eq 'C1_ERROR_CREDENTIALS_REQUIRED'}">
		${description}		
	</c:if>
	<c:if test="${not (resourceStatus eq 'C1_ERROR_CREDENTIALS_REQUIRED')}">
		<syswf:out context="HtmlBody" value="${description}"/>
	</c:if>
</div> 