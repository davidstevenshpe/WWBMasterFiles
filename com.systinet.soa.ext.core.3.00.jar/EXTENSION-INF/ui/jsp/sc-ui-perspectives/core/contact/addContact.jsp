<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.contact.contactmessages" var="contactmessages"/>

<fmt:message var="addContactDialogTitle" key="addContactDialogTitle" bundle="${contactmessages}"/>

<c:if test="${hasWritePermission}">

    <syswf:component name="/core/selector/providerSelector" prefix="addContactWindow">
        <syswf:param name="dialogTitle" value="${addContactDialogTitle}"/>
        <syswf:param name="openFceName" value="${controlName}"/>
        <syswf:param name="providerSelectorListener" value="${listener}"/>
        <syswf:param name="overrideselectionModel" value="multiple" />
        <syswf:param name="winWidth" value="650" />
    </syswf:component>

</c:if>