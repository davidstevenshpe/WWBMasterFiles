<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.systinet.webfw.ui.WebFrameworkUIMessages" var="webFrameworkUI_Messages"/>

<fmt:message key="createInDomain" var="createInDomain" bundle="${webFrameworkUI_Messages}"/>
<fmt:message key="locatedInDomain" var="locatedInDomain" bundle="${webFrameworkUI_Messages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="menuBundle"/>

<fmt:message var="menu_arrow_down" key="menu.arrow.down" bundle="${menuBundle}"/>

<c:set var="domainLocation">
    <c:choose>
        <c:when test="${browseArtifact}">${locatedInDomain}</c:when>
        <c:otherwise>${createInDomain}</c:otherwise>
    </c:choose>
</c:set>

<syswf:component name="/core/domain/domainSelector" prefix="workingDomain">
	<syswf:param name="jsOpenFunction" value="${prefix}openDomainWindow" />
	<syswf:param name="actionMode" value="script" />
</syswf:component>

<div class="domainSelection">
	<span>${domainLocation}</span>
	<br>
	<div id="${prefix}_changeWorkingDomain" style="display:flex;">
		<div class="domain-text-header">
			<strong>${domainLabel}</strong>
		</div>
		<div class="<c:if test="${context eq 'csa'}">domain-arrow-down</c:if>">${menu_arrow_down}</div>
	</div>
</div>

<script type="text/javascript">
//<![CDATA[

        Ext.onReady(function(){
            attachOn('${prefix}_changeWorkingDomain','click',function() {
                ${prefix}openDomainWindow();
            });
        });
    
//]]>
</script>