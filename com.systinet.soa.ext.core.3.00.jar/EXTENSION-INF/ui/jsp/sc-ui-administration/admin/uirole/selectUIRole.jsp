<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

    <fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage" var="role_Messages"/>
	
    <%-- action control - fires action after user presses OK --%>
    <syswf:control mode="script" action="addUIRoles" caption="${prefix}addUIRoles"/>
    <c:if test="${empty windowTitle}">
	    <fmt:message bundle="${role_Messages}" var="windowTitle" key="role.selectUIRoleTitle"/>
	</c:if>
	
	<c:if test="${empty selectorWidth}">
	    <c:set var="selectorWidth" value="700" />
	</c:if>
	
	<syswf:component name="/core/window" prefix="selector">
	    <syswf:param name="winId" value="${prefix}window" />
	    <syswf:param name="winTitle" value="${windowTitle}" />
 		<syswf:param name="selectUIRolesDataSource" value="${selectUIRolesDataSource}" />
	    <syswf:param name="winComponent" value="/admin/uirole/selectUIRoleWindow" />
	    <syswf:param name="winOpenFunctionName" value="${prefix}open" />
	    <syswf:param name="winOkLabel"><fmt:message bundle="${role_Messages}" key="role.selectUIRole" /></syswf:param>
	    <syswf:param name="winOkAction" value="${prefix}addUIRoles" />	    
	    <syswf:param name="winWidth" value="${selectorWidth}" />
	    <syswf:param name="selectorWidth" value="${selectorWidth}" />	    
	    <syswf:param name="winCancelAction" value="${winCancelAction}" />	    
	    <syswf:param name="winRenderAlways" value="true" />
	    <syswf:param name="listener" value="${holder}"/>
	    <syswf:param name="myWindowId" value="${prefix}window" />
	    <syswf:param name="holder" value="${holder}" />
	    <syswf:param name="tableSelectionBag" value="${tableSelectionBag}" />	    
	    <syswf:param name="domainId" value="${domainId}" />
	</syswf:component>

    <script type="text/javascript">
//<![CDATA[

    var ${controlName} = function() {
        ${prefix}open();
    }
    
//]]>
</script>