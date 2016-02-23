<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="bundle"/>

<fmt:message var="startCustomizationMode" key="START_CUSTOMIZATION_MODE" bundle="${bundle}"/>
<fmt:message var="startCustomizationModeHint" key="START_CUSTOMIZATION_MODE_HINT" bundle="${bundle}"/>

<c:if test="${canCustomize  and  !customizationModeSwitch.customizationMode}">
<c:choose>
	<c:when test="${mode eq 'anchor'}">
		<syswf:control id="startCustomizationMode"  action="startCustomizationMode" mode="anchor"  caption="${startCustomizationMode}" hint="${startCustomizationModeHint}"/>
	</c:when>
	<c:otherwise>
		<li>
  		<syswf:control id="startCustomizationMode"  action="startCustomizationMode" mode="anchor"  caption="${startCustomizationMode}" hint="${startCustomizationModeHint}"/>
  		</li>
	</c:otherwise>
</c:choose>
</c:if>