<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.system.SystemSettingsMessages"
	var="system_Messages" />

<c:if test="${propertyBean.domain != null}">
	<c:out value="${propertyBean.domain.name}"/>
</c:if>
<a href="javascript:void(0);" class="UI Icon" id="${prefix}select_domain"><span><fmt:message key="systemsettings.properties.change_domain.link_label" bundle="${system_Messages}"/></span></a>
<syswf:control mode="ajax" caption="${prefix}saveState" action="saveState" />

<fmt:message var="selector_title" key="systemsettings.properties.domainSelector.title" bundle="${system_Messages}"/>

<syswf:component name="/admin/common/domainSelector" prefix="selectDomain">
    <syswf:param name="jsOpenFunction" value="${prefix}open" />
    <syswf:param name="windowTitle" value="${selector_title}"/>
    <syswf:param name="holder" value="${holder}" />
</syswf:component>

<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function() {
	    attachOn('${prefix}select_domain','click',function() {
	        ${prefix}open();
	        ${prefix}saveState();
	    });
	});

//]]>
</script>
