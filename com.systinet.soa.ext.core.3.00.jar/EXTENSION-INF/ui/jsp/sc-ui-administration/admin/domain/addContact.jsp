<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domainMessages" />
<fmt:message var="dialogTitle" key="contact.addContact.dialogTitle" bundle="${domainMessages}" />

<c:if test="${hasWritePermission}">
    <syswf:component name="/core/selector/providerSelector" prefix="addContactWindow">
        <syswf:param name="dialogTitle" value="${dialogTitle}"/>
        <syswf:param name="openFceName" value="${controlName}"/>
        <syswf:param name="providerSelectorListener" value="${listener}"/>
        <syswf:param name="viewId" value="provider"/>
    </syswf:component>
</c:if>