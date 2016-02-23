<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.uddi.l10n.messages" var="l10n" />

<div class="UI Offset">
	<p class="Warning"><fmt:message key="uddi.import.warning.changeTabExplaination" bundle="${l10n}"/> 
		<br/>
		<fmt:message key="uddi.import.warning.changeTabConfirm" bundle="${l10n}"/>
	</p>
</div>