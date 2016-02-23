<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${isAccessGranted}">

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.util.uimessages" var="labels" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="user_Messages" />
<fmt:message var="message" key="listUsers.bulk.${type}.confirm" bundle="${user_Messages}"/>
<fmt:message var="dialog_title" key="listUsers.bulk.${type}.description" bundle="${user_Messages}"/>
	
<syswf:component name="/core/impl/util/dialog" prefix="dialog">
    <syswf:param name="handler" value="${prefix}disableEnable" />
    <syswf:param name="heading">${dialog_title}</syswf:param>
    <syswf:param name="content">${message}</syswf:param>
</syswf:component>

<%-- action control - fires action after user presses OK --%>
<syswf:control mode="script" action="disableEnable" caption="${prefix}disableEnable" >
    <syswf:param name="accountStatus" value="${status}" />
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>

</c:if>