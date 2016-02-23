<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${isAccessGranted}">

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage"
	var="roleMsg" />
<fmt:message var="dialog_title" key="role.delete.confirmation.caption" bundle="${roleMsg}" />
<fmt:message var="message" key="role.delete.confirm" bundle="${roleMsg}" />
	
<syswf:component name="/core/impl/util/dialog" prefix="dialog">
   <syswf:param name="handler" value="${prefix}delete" />
   <syswf:param name="heading">${dialog_title}</syswf:param>
   <syswf:param name="content">${message}</syswf:param>
   <syswf:param name="noUndo" value="true"/>
</syswf:component>

<syswf:control mode="script" action="deletes" caption="${prefix}delete" >
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>

</c:if>