<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:choose>
	<c:when test="${roleType == 'SYSTEM'}">
		<span class="UI Icon SystemRole">Yes</span>
	</c:when>
    <c:when test="${roleType == 'NONSYSTEM'}">
		<span class="Comment" style="color:GRAY">No</span>
	</c:when>
</c:choose>
