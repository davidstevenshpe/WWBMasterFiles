<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.security.securitymessages" var="securitymessages"/>

<fmt:message var="addAccess_dialogTitleReadOnly" key="addAccess.dialogTitleReadOnly" bundle="${securitymessages}"/>
<fmt:message var="addAccess_dialogTitleReadWrite" key="addAccess.dialogTitleReadWrite" bundle="${securitymessages}"/>


<c:if test="${isActionPermitted}">

    <syswf:component name="/core/window" prefix="addAccess">
        <c:choose>
            <c:when test="${accessType eq 'read'}">
                <syswf:param name="winTitle">${addAccess_dialogTitleReadOnly}</syswf:param>
            </c:when>
            <c:when test="${accessType eq 'readWrite'}">
                <syswf:param name="winTitle">${addAccess_dialogTitleReadWrite}</syswf:param>
            </c:when>
        </c:choose>
        <syswf:param name="winComponent" value="/core/impl/security/addAccessWindow"/>
        <syswf:param name="winOpenFunctionName" value="${controlName}"/>
        <syswf:param name="winOkLabel"><fmt:message bundle="${labels}" key="Add" /></syswf:param>
        <syswf:param name="winOkAction" value="${prefix}addAccess"/>
        <syswf:param name="winWidth" value="400"/>
        <syswf:param name="winButtonAlign" value="center"/>
        <syswf:param name="winOnRenderCallback" value="${prefix}openSelector" />
        <%-- inner component parameters --%>  
        <syswf:param name="selectionBag" value="${selectionBag}" />
        <syswf:param name="accessType" value="${accessType}" />
        <syswf:param name="holder" value="${selectedPrincipalsHolder}" />
    </syswf:component>
    
    <%-- action controls - fires action after user presses Add --%>
    <syswf:control mode="script" action="addAccess" caption="${prefix}addAccess" />

</c:if>