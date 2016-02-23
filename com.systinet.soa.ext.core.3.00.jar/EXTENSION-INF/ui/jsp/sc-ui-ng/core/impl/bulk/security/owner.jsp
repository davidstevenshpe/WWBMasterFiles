<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<syswf:control mode="script" action="changeOwner" caption="${prefix}changeOwner" />

<syswf:component name="/core/window" prefix="ow">
    <syswf:param name="winComponent" value="/core/impl/bulk/security/ownerWindow" />
    <syswf:param name="winTitle"><fmt:message bundle="${messages}" key="changeOwner.title" /></syswf:param>
    <syswf:param name="winOpenFunctionName" value="${controlName}" />
    <syswf:param name="winOkAction" value="${prefix}changeOwner" />
    <syswf:param name="winWidth" value="400" />
    <syswf:param name="winOnRenderCallback" value="${prefix}openSelector" />
    
    <syswf:param name="holder" value="${settings}"/>
</syswf:component>

