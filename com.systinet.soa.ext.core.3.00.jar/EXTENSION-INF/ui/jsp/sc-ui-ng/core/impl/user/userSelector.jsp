<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 
dialogTitle -
openFceName -  
listener - 
 -->

<c:if test="${hasWritePermission}">

    <fmt:setBundle basename="com.hp.systinet.sc.ui.impl.user.userMessages" var="userMessages"/>
    <fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />
    
    <fmt:message var="selectLabel" key="Select" bundle="${messages}"/>

    <c:if test="${empty dialogTitle}" >
        <fmt:message var="dialogTitle" key="userSelector.defaultTitle" bundle="${userMessages}"/>
    </c:if>

    <syswf:component name="/core/window" prefix="userSelectorWindow">
        <syswf:param name="winId">${prefix}Win</syswf:param>
        <syswf:param name="winTitle">${dialogTitle}</syswf:param>
        <syswf:param name="winComponent" value="/core/selector/userSelectorInternal"/>
        <syswf:param name="winOpenFunctionName" value="${openFceName}" />
        <syswf:param name="winOkAction" value="${prefix}Select" />
        <syswf:param name="winOkLabel" value="${selectLabel}" />
        <syswf:param name="winButtonAlign" value="right" />
        <syswf:param name="userSelectorHolder" value="${userSelectorHolder}" />
    </syswf:component>
    
    <syswf:control id="${prefix}Select" mode="script" caption="${prefix}Select" action="select"/>

</c:if>
