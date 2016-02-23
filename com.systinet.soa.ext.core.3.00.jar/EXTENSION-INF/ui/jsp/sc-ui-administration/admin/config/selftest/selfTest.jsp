<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.selftest.SelfTestMessages"
	var="selfTest_Messages" />
<fmt:message key="enableSelfTest_Label" var="enableLabel" bundle="${selfTest_Messages}" />
<fmt:message key="disableSelfTest_Label" var="disableLabel" bundle="${selfTest_Messages}" />
	
	
<c:if test="${not empty globalSession['userName']}">
	<fmt:setLocale value="${globalSession['userDefaultLanguage']}"
		scope="page" />
</c:if>
<c:choose>
	<c:when test="${not this.hasEnabledSelfTest}">
		<syswf:block className="UI SystemMessage Info">
			<div class="MessageContainer">
				<fmt:message key="disabledSelfTestNote_Label" bundle="${selfTest_Messages}" />
				<div class="ControlButtons">
				<syswf:control caption="${enableLabel}" hint="${enableLabel}" action="change" mode="button">
					<syswf:attribute name="class" value="btn btn-primary" />
				</syswf:control>
				</div>
			</div>
		</syswf:block>								
	</c:when>
	<c:otherwise>
		<syswf:block className="UI SystemMessage Info">
			<div class="MessageContainer">
				${enabledSelfTestNote_Label}
				<div class="ControlButtons">
				<syswf:control caption="${disableLabel}" hint="${disableLabel}" action="change" mode="button">
					<syswf:attribute name="class" value="btn btn-primary" />
				</syswf:control>
				</div> 
			</div>
		</syswf:block> 
		<syswf:component name="/admin/configuration/preferences/selfTestReport" prefix="selfTestReport" />						
	</c:otherwise>
</c:choose>		