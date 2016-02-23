<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:if test="${isAccessGranted and (not isDeleted)}">
<script type="text/javascript">
//<![CDATA[

	var ${controlName} = function() {
		${openAssertionsSelectorFunction}();
	}

//]]>
</script>
</c:if>
