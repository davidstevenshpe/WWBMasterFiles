<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.license.LicenseMessages" var="license_Messages" />
<fmt:message var="dialog_title" key="removeLicensedUsers.header.label" bundle="${license_Messages}"/>
<fmt:message var="message" key="removeLicensedUsers.confirm.label" bundle="${license_Messages}"/>

<syswf:component name="/core/impl/util/dialog" prefix="${prefix}_removeLicensedUsersConfirmDialog">
    <syswf:param name="handler" value="${prefix}_removeUsers" />
    <syswf:param name="heading">${dialog_title}</syswf:param>
    <syswf:param name="content">${message}</syswf:param>
</syswf:component>

<syswf:control mode="script" action="remove" caption="${prefix}_removeUsers" >
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>