<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.security.securitymessages" var="securitymessages"/>
<fmt:message var="removeAccess_dialogTitle" key="removeAccess.dialogTitle" bundle="${securitymessages}"/>


<c:if test="${isActionPermitted}">

    <syswf:component name="/core/window" prefix="removeAccess">
        <syswf:param name="winTitle">${removeAccess_dialogTitle}</syswf:param>
        <syswf:param name="winComponent" value="/core/impl/security/removeAccessWindow"/>
        <syswf:param name="winOpenFunctionName" value="${controlName}"/>
        <syswf:param name="winOkLabel"><fmt:message bundle="${labels}" key="Remove" /></syswf:param>
        <syswf:param name="winOkAction" value="${prefix}removeAccess"/>
        <syswf:param name="winWidth" value="300"/>
        <syswf:param name="winButtonAlign" value="center"/>
        <syswf:param name="winOnRenderCallback" value="${null}" passNull="true"/>
        <%-- inner component parameters --%>  
        <syswf:param name="settings" value="${settings}"/>
        <syswf:param name="selectionBag" value="${selectionBag}" />
        <syswf:param name="accessType" value="${accessType}" />
        <syswf:param name="optionsHolder" value="${optionsHolder}" />
    </syswf:component>
    
    <%-- action control - fires action after user presses Remove --%>
    <syswf:control mode="script" action="removeAccess" caption="${prefix}removeAccess" />

</c:if>