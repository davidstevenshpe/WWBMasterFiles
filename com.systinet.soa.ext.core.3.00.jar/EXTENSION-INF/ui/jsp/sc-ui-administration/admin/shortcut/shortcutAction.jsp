<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${hasWritePermission}">
    <syswf:control mode="script" action="${controlAction}" caption="${prefix}${controlAction}ShortcutAction">
        <syswf:param name="selectionBag" value="${selectionBag}"/>
    </syswf:control>
    <syswf:component name="/core/impl/util/dialog" prefix="${controlAction}ShortcutConfirmDialog">
        <syswf:param name="handler" value="${prefix}${controlAction}ShortcutAction"/>
        <syswf:param name="heading">${confirmDialogHeading}</syswf:param>
        <syswf:param name="content">${confirmDialogText}</syswf:param>
        <syswf:param name="noUndo" value="false"/>
    </syswf:component>
</c:if>