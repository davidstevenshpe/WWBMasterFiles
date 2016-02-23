<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<syswf:component name="/core/table" prefix="${prefix}_assginedUIRoles" wrap="true">
	<syswf:param name="customizationId" value="admin.uirole.selectUIRoleTable" />
	<syswf:param name="selectionBag" value="${tableSelectionBag}" />
</syswf:component>
	
	