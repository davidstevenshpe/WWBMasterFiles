<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${isAccessGranted}">

<syswf:control mode="script" caption="${controlName}" targetTask="/admin/role/create" >
	<syswf:param name="mode" value="create"/>
</syswf:control>

</c:if>