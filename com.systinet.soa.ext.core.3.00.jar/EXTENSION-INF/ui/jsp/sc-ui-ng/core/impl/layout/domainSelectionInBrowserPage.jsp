<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.systinet.webfw.ui.WebFrameworkUIMessages" var="webFrameworkUI_Messages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="menuBundle"/>
<fmt:message key="createInDomain" var="createInDomain" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="locatedInDomain" var="locatedInDomain" bundle="${webFrameworkUI_Messages}"/>
<fmt:message var="menu_arrow_down" key="menu.arrow.down" bundle="${menuBundle}"/>

<fmt:setBundle basename="com.hp.systinet.ea.ui.domainselectionmessages" var="domainMsg"/>
	<fmt:message key="domain.selection.show.data" var="showDataFor" bundle="${domainMsg}"/>	

<div class="domainSelection browsepage">
	<span>${locatedInDomain}: </span>
	<br>
	<div id="${prefix}toggleWndId" class="content" style="display:flex;">
		<div class="domain-text-header"><span>${domainText}</span></div>
		<div>${menu_arrow_down}</div>
	</div>
</div>

<syswf:component name="/domain/domainSelectionWindow" prefix="domainSelectionWindow">
	<syswf:param name="setting" value="${setting}"/>
	<syswf:param name="toggleId" value="${prefix}toggleWndId"/>
</syswf:component>