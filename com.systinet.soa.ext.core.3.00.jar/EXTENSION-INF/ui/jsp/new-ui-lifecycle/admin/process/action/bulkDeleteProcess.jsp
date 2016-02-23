<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="canDelete" type="java.lang.Boolean"--%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<c:if test="${canDelete}">
    <syswf:control mode="script" action="deleteProcess" caption="${prefix}delete" >
        <syswf:param name="selectionBag" value="${selectionBag}" />
    </syswf:control>
    <syswf:component name="/core/impl/util/dialog" prefix="deleteDialog">
        <syswf:param name="handler" value="${prefix}delete" />
        <syswf:param name="heading"><fmt:message key="processTable.action.delete.warning.header" bundle="${messages}"/></syswf:param>
        <syswf:param name="content"><fmt:message key="processTable.action.delete.warning.body" bundle="${messages}"/></syswf:param>
        <syswf:param name="noUndo" value="true" />
    </syswf:component>
</c:if>
