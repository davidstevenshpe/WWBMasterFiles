<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${isAccessGranted}">
	<syswf:control mode="script" caption="${controlName}" targetTask="/admin/domain/create" />
</c:if>	