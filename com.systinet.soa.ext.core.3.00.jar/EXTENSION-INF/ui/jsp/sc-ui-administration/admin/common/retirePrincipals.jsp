<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${isAccessGranted}">

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="user_Messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage" var="role_Messages" />
<c:choose>
	<c:when test="${oldPrincipalType eq 'ROLE'}">
		<fmt:message key="listRoles.bulk.delete.window.title" var="title" bundle="${role_Messages}"/>
		<fmt:message key="listRoles.bulk.delete.ok.caption" var="okLabel" bundle="${role_Messages}"/>
	</c:when>
	<c:otherwise>
		<fmt:message key="listUsers.bulk.retire.window.title" var="title" bundle="${user_Messages}"/>
		<fmt:message key="listUsers.bulk.retire.ok.caption" var="okLabel" bundle="${user_Messages}"/>
	</c:otherwise>
</c:choose>

<c:if test="${empty singlePrincipal}">
<%-- action control - fires action to check organization unit --%>
<syswf:control mode="script" action="initialize" caption="${prefix}initialize" >
	<syswf:param name="artifactSelection" value="${selectionBag}" />	
</syswf:control>

<script type="text/javascript">
//<![CDATA[

var ${controlName} = function(){
    ${prefix}initialize();
};

//]]>
</script>
</c:if>

<c:if test="${not empty openDialog or not empty uuid}">
	<%-- action control - fires action after user presses OK --%>
<syswf:control mode="script" action="${mainAction}" caption="${prefix}retireUsers" >
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>

	<syswf:component name="/core/window" prefix="bulkExport">
	    <syswf:param name="winTitle" value="${title}" />
	    <syswf:param name="winComponent" value="/admin/common/retirePrincipalsWindow"/>
	    <syswf:param name="winOpenFunctionName" value="${prefix}openDialog" />
	    <syswf:param name="winOkAction" value="${prefix}retireUsers" />
	    <syswf:param name="winOkLabel" value="${okLabel}" />
	    <syswf:param name="holder" value="${settings}" />	
	    <syswf:param name="selectedPrincipals" value="${selectedPrincipals}" />
	    <syswf:param name="winOnRenderCallback" value="${prefix}openSelector" />
		<syswf:param name="winButtonAlign" value="right" />
		<syswf:param name="winRenderAlways" value="true" />
		<syswf:param name="oldPrincipalType" value="${oldPrincipalType}" />
		
	</syswf:component>
</c:if>

<c:if test="${not empty openDialog}">
<c:choose>
	<c:when test="${not empty singlePrincipal}">
		<script type="text/javascript">
//<![CDATA[

			var ${controlName} = function(){
				${prefix}openDialog();
			};
		
//]]>
</script>
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
//<![CDATA[

		    Ext.onReady(function(){
		    	${prefix}openDialog();
		    });
    	
//]]>
</script>
	</c:otherwise>
</c:choose>
</c:if>

</c:if>


