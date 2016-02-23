<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${isAccessGranted}">

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="user_Messages" />
<fmt:message key="editUsers.setOwnership_title" bundle="${user_Messages}" var="title"/>
<fmt:message key="editUsers.set" bundle="${user_Messages}" var="okLabel"/>

<%-- action control - fires action after user presses OK --%>
<syswf:control mode="script" action="changeOwnerBy" caption="${prefix}changeOwnerBy" >
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>

	<syswf:component name="/core/window" prefix="bulkExport1">
	    <syswf:param name="winTitle" value="${title}" />
	    <syswf:param name="winComponent" value="/admin/common/newArtifactsOwnerByWindow"/>
	    <syswf:param name="winOpenFunctionName" value="${prefix}openDialog" />
	    <syswf:param name="winOkAction" value="${prefix}changeOwnerBy" />
	    <syswf:param name="winOkLabel" value="${okLabel}" />
	    <syswf:param name="holder" value="${settings}" />	
	    <syswf:param name="winOnRenderCallback" value="${prefix}openSelector" />
		<syswf:param name="winButtonAlign" value="left" />
		<syswf:param name="winRenderAlways" value="true" />
	</syswf:component>

<script type="text/javascript">
//<![CDATA[

var ${controlName} = function() {
	${prefix}openDialog();
}

//]]>
</script>

</c:if>