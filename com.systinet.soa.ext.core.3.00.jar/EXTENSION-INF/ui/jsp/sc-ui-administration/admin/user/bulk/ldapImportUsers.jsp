<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${isAccessGranted}">

	<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="user_Messages" />
	<fmt:message key="editUsers.selectImportUser_title" bundle="${user_Messages}" var="select_title"/>  
	 
	<syswf:component name="/admin/common/selectPrincipal" prefix="pricipalSelector">
	    <syswf:param name="select_title" value="${select_title}" />
	    <syswf:param name="selectionMode" value="multiple" />   
	    <syswf:param name="holder" value="${importUsersHolder}" />
	    <syswf:param name="disableRolesTab" value="true" />
	    <syswf:param name="groupsDataSource" value="${externalGroupsDataSource}" />
	</syswf:component>

</c:if> 