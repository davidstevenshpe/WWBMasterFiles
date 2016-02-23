<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="users_Messages" />
<c:choose>
	<c:when test="${ contextMenu == true}">
		<div class="EA-left-panel">
			<a href="javascript:${prefix}_openConfirmPopUp();" class="${styleClass}" id="${prefix}_actionLink" title="${title}">
				<span>${title}</span>
			</a>
		</div>
	</c:when>
	<c:otherwise>
		<a href="javascript:${prefix}_openConfirmPopUp();" class="${styleClass}" id="${prefix}_actionLink" title="${title}">		
		</a>
	</c:otherwise>
</c:choose>
	
	<syswf:component name="/core/impl/util/dialog" prefix="dialog">
    	<syswf:param name="handler" value="${prefix}confirm" />
    	<syswf:param name="heading">${dialog_title}</syswf:param>
    	<syswf:param name="content">${message}</syswf:param>
    	<syswf:param name="controlName">${prefix}_openConfirmPopUp</syswf:param>
    	<c:if test="${mode == 'delete'}">
    	<syswf:param name="noUndo" value="true"/>
    	</c:if>
	</syswf:component>

<syswf:control mode="script" action="${mode}" caption="${prefix}confirm" >
    <syswf:param name="uuid" value="${uuid}" />
</syswf:control>
