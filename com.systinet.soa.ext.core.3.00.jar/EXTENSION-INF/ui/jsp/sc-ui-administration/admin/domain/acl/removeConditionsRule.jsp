<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />
<fmt:message var="dialog_title" key="removeConditions.header.label" bundle="${domain_Messages}"/>
<fmt:message var="message" key="removeConditions.confirm.label" bundle="${domain_Messages}"/>

<syswf:component name="/core/impl/util/dialog" prefix="dialog">
    <syswf:param name="handler" value="${prefix}remove" />
    <syswf:param name="heading">${dialog_title}</syswf:param>
    <syswf:param name="content">${message}</syswf:param>
</syswf:component>

<syswf:control mode="script" action="remove" caption="${prefix}remove" >
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>
