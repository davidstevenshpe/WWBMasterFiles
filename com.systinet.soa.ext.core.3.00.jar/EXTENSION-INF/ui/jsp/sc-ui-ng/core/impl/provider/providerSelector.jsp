<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 
dialogTitle -
openFceName -  
listener - 
affectsOnSelection -
allowCreation - flag, which says if in selector should be allowed creation of contact. Default value is true. 
submitBeforeCreation - path to parent, who has to be submited before creation of new artifact is started (if will be prefixed with ../)
availableArtifactTypes - list of artifact types to search in (for suggested search)
 -->
 

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.provider.providerMessages" var="providerMessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />

<fmt:message var="selectLabel" key="Select" bundle="${messages}"/>

<c:if test="${empty dialogTitle}" >
    <fmt:message var="dialogTitle" key="providerSelector.defaultTitle" bundle="${providerMessages}"/>
</c:if>

<c:if test="${empty allowCreation}" >
    <c:set var="allowCreation" value="${true}" />
</c:if>

<syswf:component name="/core/window" prefix="providerSelectorWindow">
    <syswf:param name="winId">${prefix}Win</syswf:param>
    <syswf:param name="winTitle">${dialogTitle}</syswf:param>
    <syswf:param name="winComponent" value="/core/selector/providerSelectorInternal"/>
    <syswf:param name="winOpenFunctionName" value="${openFceName}" />
    <syswf:param name="winOkAction" value="${prefix}Select" />
    <syswf:param name="winOkLabel" value="${selectLabel}" />
    <syswf:param name="winButtonAlign" value="right" />
    <syswf:param name="providerSelectorHolder" value="${providerSelectorHolder}" />
    <syswf:param name="providerSelectorCreationListener" value="${providerSelectorCreationListener}" />
    <syswf:param name="providerSelectAction" value="${prefix}Select" />
    <syswf:param name="allowCreation" value="${allowCreation}" />
    <syswf:param name="availableArtifactTypes" value="${availableArtifactTypes}" />
    <c:if test="${not empty submitBeforeCreation}">
        <syswf:param name="beforeCreationFce" value="${prefix}submitBeforeCreation" />
    </c:if>
    <c:if test="${not empty winWidth}">
        <syswf:param name="winWidth" value="${winWidth}" />
    </c:if>
</syswf:component>

<c:choose>
    <c:when test="${empty affectsOnSelection}">
        <syswf:control id="${prefix}Select" mode="script" caption="${prefix}Select" action="select"/>
    </c:when>
    
    <c:otherwise>
        <syswf:control id="${prefix}Select" mode="script" caption="${prefix}Select" action="select" affects="."/>    
    </c:otherwise>
</c:choose
>
<c:if test="${not empty submitBeforeCreation}">
    <syswf:control mode="script" action="dontRefresh" id="${prefix}submitBeforeCreation" caption="${prefix}submitBeforeCreation" affects="../${submitBeforeCreation}" />
</c:if>
