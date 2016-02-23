<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:component name="/core/table" prefix="users">
   <syswf:param name="customizationId" value="shared.userSelector.users"/>
   <syswf:param name="datasource" value="${usersDataSource}"/>
   <syswf:param name="selectionBag" value="${userSelectorHolder.globalUsersSelectionBag}" />
</syswf:component>