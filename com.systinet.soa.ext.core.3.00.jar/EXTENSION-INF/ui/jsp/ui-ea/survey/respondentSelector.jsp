<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!--
	@author: nabinh 
	extend from providerSelector.jsp
	    currentSurveyedArtifactUuid: store selected surveyed artifact in table
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
    <syswf:param name="winOkAction" value="${prefix}SelectRespondent" />
    <syswf:param name="winOkLabel" value="${selectLabel}" />
    <syswf:param name="winButtonAlign" value="right" />
    <syswf:param name="providerSelectorHolder" value="${providerSelectorHolder}" />
    <syswf:param name="providerSelectorCreationListener" value="${respondentSelectorCreationListener}" />
    <syswf:param name="providerSelectAction" value="${prefix}SelectRespondent" />
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
    	<syswf:input id="currentSurveyedArtifactUuid" name="currentSurveyedArtifactUuid" mode="hidden" value="" />
        <syswf:control id="${prefix}SelectRespondent" mode="script" caption="${prefix}SelectRespondent" action="selectRespondent"/>
    </c:when>
    <c:otherwise>
        <syswf:control id="${prefix}SelectRespondent" mode="script" caption="${prefix}SelectRespondent" action="selectRespondent" affects="."/>    
    </c:otherwise>
</c:choose>

<c:if test="${not empty submitBeforeCreation}">
	<syswf:input id="currentSurveyedArtifactUuid1" name="currentSurveyedArtifactUuid1" mode="hidden" value="" />
    <syswf:control mode="script" action="dontRefresh" id="${prefix}submitBeforeCreation" caption="${prefix}submitBeforeCreation" affects="${submitBeforeCreation}" />
</c:if>

