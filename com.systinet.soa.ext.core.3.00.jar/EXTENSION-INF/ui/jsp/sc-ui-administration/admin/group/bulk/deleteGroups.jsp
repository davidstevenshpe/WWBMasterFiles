<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${isAccessGranted}">

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.group.GroupMessages"
	var="groups_Messages" />
<fmt:message var="dialog_title" key="delete.confirm.Caption" bundle="${groups_Messages}" />
<fmt:message var="message" key="delete.confirm.message" bundle="${groups_Messages}" />

<syswf:control mode="script" action="deletes" caption="${prefix}deletes" >
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>

<syswf:component name="/core/impl/util/dialog" prefix="dialog">
   <syswf:param name="handler" value="${prefix}deletes" />
   <syswf:param name="heading">${dialog_title}</syswf:param>
   <syswf:param name="content">${message}</syswf:param>
   <syswf:param name="noUndo" value="true"/>
</syswf:component>

</c:if>