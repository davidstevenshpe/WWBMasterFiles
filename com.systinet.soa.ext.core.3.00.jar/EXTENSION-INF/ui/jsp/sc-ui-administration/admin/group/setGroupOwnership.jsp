<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.util.uimessages" var="labels" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.group.GroupMessages" var="group_Messages" />


<fmt:message key="default_ownership.title" bundle="${group_Messages}" var="select_title"/>
<fmt:message key="group.set" bundle="${group_Messages}" var="button_set"/>

<fmt:message key="editGroup.setgroupownership.action.Title" var="title" bundle="${labels}" />

<c:if test="${not retired}">
	<a href="javascript:void(0);" class="context-button SetOwner" title="${title}" id="${prefix}select_ownership">
	</a>
	
	
	<%-- action control - fires action after user presses OK --%>
	<syswf:control mode="script" action="changeNewArtifactOwnership" caption="${prefix}changeNewArtifactOwnership" >
		<syswf:param name="groupName" value="${groupName}" />
	</syswf:control>
    
	<syswf:component name="/core/window" prefix="groupOwnerByWindow">
	    <syswf:param name="winTitle" value="${select_title}" />
	    <syswf:param name="winComponent" value="/admin/common/newArtifactsOwnerByWindow" />
	    <syswf:param name="winOpenFunctionName" value="${prefix}open" />
	    <syswf:param name="winOkLabel" value="${button_set}" />
	    <syswf:param name="winOkAction" value="${prefix}changeNewArtifactOwnership" />
	    <syswf:param name="winButtonAlign" value="left" />
	    <syswf:param name="winRenderAlways" value="true" />
	    <syswf:param name="holder" value="${groupOwnershipHolder}"/>
	    <syswf:param name="winOnRenderCallback" value="${prefix}openSelector" />
	</syswf:component>

	<script type="text/javascript">
//<![CDATA[

		Ext.onReady(function(){
		    attachOn('${prefix}select_ownership','click',function() {
		        ${prefix}open();
		    });
		});
	
//]]>
</script>
</c:if>

