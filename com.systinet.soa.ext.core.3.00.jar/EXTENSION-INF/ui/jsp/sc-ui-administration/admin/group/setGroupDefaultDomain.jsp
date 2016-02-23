<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.group.GroupMessages" var="groups_Messages" />
<fmt:message key="editGroup.setdefaultdomain.action.Title" var="title" bundle="${groups_Messages}" />

<c:if test="${not retired}">

	<a href="javascript:void(0);" class="context-button SetDefaultDomain" title="${title}" id="${prefix}_setDefaultDomain">
	</a>

	<fmt:message key="changedomain.dialog.title" bundle="${groups_Messages}" var="select_title"/>
	
	<syswf:control mode="script" action="setDefaultDomain" caption="${prefix}setDefaultDomain">
		<syswf:param name="groupName" value="${groupName}" />
	</syswf:control>
	<syswf:component name="/core/window" prefix="setUsersDefaultDomainWindow">
	    <syswf:param name="winTitle" value="${select_title}" />
	    <syswf:param name="winComponent" value="/admin/common/domainSelectorWindow"/>
	    <syswf:param name="winOpenFunctionName" value="${prefix}open" />
	    <syswf:param name="winOkAction" value="${prefix}setDefaultDomain" />
	    <syswf:param name="winOkLabel" value="Select" />
	    <syswf:param name="selectedDomainHolder" value="${selectedDomainHolder}" />	
		<syswf:param name="winButtonAlign" value="right" />
	</syswf:component>
	
	
	<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function(){
	    attachOn('${prefix}_setDefaultDomain','click',function() {
	        ${prefix}open();
	    });
	});
	
//]]>
</script>
</c:if>