<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<%--@elvariable id="canDeprecate" type="java.lang.Boolean"--%>

<c:if test="${canDeprecate}">
    <syswf:control mode="script" action="deprecateProcess" caption="${prefix}deprecate" >
        <syswf:param name="selectionBag" value="${selectionBag}" />
    </syswf:control>
    <syswf:component name="/core/impl/util/dialog" prefix="deprecateDialog">
        <syswf:param name="handler" value="${prefix}deprecate" />
        <syswf:param name="heading"><fmt:message key="processTable.action.deprecate.warning.header" bundle="${messages}"/></syswf:param>
        <syswf:param name="content"><fmt:message key="processTable.action.deprecate.warning.body" bundle="${messages}"/></syswf:param>
        <syswf:param name="noUndo" value="false" />
    </syswf:component>
</c:if>
