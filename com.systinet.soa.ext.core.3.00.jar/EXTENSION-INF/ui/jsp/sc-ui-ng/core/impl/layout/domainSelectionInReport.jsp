<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.ea.ui.domainselectionmessages" var="domainMsg"/>
	<fmt:message key="domain.selection.show.data" var="showDataIn" bundle="${domainMsg}"/>	
	
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="menuBundle"/>
	<fmt:message var="menu_arrow_down" key="menu.arrow.down" bundle="${menuBundle}"/>

<c:if test="${visible eq true}">

	<div class="domainSelection">
		<span>${showDataIn}<c:if test="${context ne 'csa'}">:</c:if></span>
		<br>
		<div id="${prefix}toggleWndId" style="display:flex;">
			<div class="domain-text-header"><strong>${domainText}</strong></div>
			<div class="<c:if test="${context eq 'csa'}">domain-arrow-down</c:if>">${menu_arrow_down}</div>
		</div>
	</div>
	
	<syswf:component name="/domain/domainSelectionWindow" prefix="domainSelectionWindow">
		<syswf:param name="setting" value="${setting}"/>
		<syswf:param name="toggleId" value="${prefix}toggleWndId"/>
	</syswf:component>

</c:if>