<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.group.GroupMessages"
	var="groups_Messages" />
<fmt:message var="dialog_title" key="editGroup.confirm.caption" bundle="${groups_Messages}" />
<fmt:message var="message" key="editGroup.confirm.message" bundle="${groups_Messages}" />

<syswf:component name="/core/impl/util/dialog" prefix="dialog">
   <syswf:param name="handler" value="${prefix}remove" />
   <syswf:param name="heading">${dialog_title}</syswf:param>
   <syswf:param name="content">${message}</syswf:param>
</syswf:component>

<syswf:control mode="script" action="remove" caption="${prefix}remove" >
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>