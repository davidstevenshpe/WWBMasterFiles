<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:control id="myLink" mode="anchor" caption="${UIRoleName}" targetTask="/admin/uirole/view">
	<syswf:param name="UIRoleName" value="${UIRoleName}"/>
	<syswf:param name="UIRoleId" value="${UIRoleId}"/>
</syswf:control>