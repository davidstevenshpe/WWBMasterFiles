<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domainMessages" />
<fmt:message var="dialogTitle" key="contact.removeContact.dialogTitle" bundle="${domainMessages}" />
<fmt:message var="removeMessage" key="contact.removeContact.removeMessage" bundle="${domainMessages}" />
 
<syswf:control mode="script" action="remove" caption="${prefix}remove" >
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>

<syswf:component name="/core/impl/util/dialog" prefix="dialog">
    <syswf:param name="handler" value="${prefix}remove" />
    <syswf:param name="heading">${dialogTitle}</syswf:param>
    <syswf:param name="content">${removeMessage}</syswf:param>
    <syswf:param name="noUndo" value="true"/>
</syswf:component>
 