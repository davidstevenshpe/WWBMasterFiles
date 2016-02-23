<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:control id="myLink" mode="anchor" caption="${RoleName}" targetTask="/admin/role/view">
	<syswf:param name="RoleName" value="${RoleName}"/>
	<syswf:param name="RoleId" value="${RoleId}"/>
</syswf:control> 