<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<%--@elvariable id="canPublish" type="java.lang.Boolean"--%>

<c:if test="${canPublish}">
    <syswf:control mode="script" action="publishProcess" caption="${prefix}publish" >
        <syswf:param name="selectionBag" value="${selectionBag}" />
    </syswf:control>
    <syswf:component name="/core/impl/util/dialog" prefix="publishDialog">
        <syswf:param name="handler" value="${prefix}publish" />
        <syswf:param name="heading"><fmt:message key="processTable.action.publish.warning.header" bundle="${messages}"/></syswf:param>
        <syswf:param name="content"><fmt:message key="processTable.action.publish.warning.body" bundle="${messages}"/></syswf:param>
        <syswf:param name="noUndo" value="false" />
    </syswf:component>
</c:if>
