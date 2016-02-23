<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.group.GroupMessages" var="groups_Messages" />

<fmt:message var="dgl_title" key="deletedetail.confirm.Caption" bundle="${groups_Messages}" />

<fmt:message var="warningMessage" key="deletedetail.confirm.message" bundle="${groups_Messages}">
	<fmt:param><syswf:out value="${groupName}" context="HtmlBody"/></fmt:param>
</fmt:message>

<fmt:message key="deletedetail.link.label" var="title" bundle="${groups_Messages}" />

<c:if test="${retired}">
	<a href="javascript:${prefix}_openDeleteConfirmPopUp();" class="context-button Remove" title="${title}" id="${prefix}_deleteGroup">
	</a>
	
	<syswf:control mode="script" action="delete" caption="${prefix}delete" >
	    <syswf:param name="group" value="${group}" />
	</syswf:control>
	
	<syswf:component name="/core/impl/util/dialog" prefix="dialog">
	   <syswf:param name="handler" value="${prefix}delete" />
	   <syswf:param name="heading">${dgl_title}</syswf:param>
	   <syswf:param name="content">${warningMessage}</syswf:param>
	   <syswf:param name="controlName">${prefix}_openDeleteConfirmPopUp</syswf:param>
	   <syswf:param name="noUndo" value="true"/>
	</syswf:component>
</c:if>