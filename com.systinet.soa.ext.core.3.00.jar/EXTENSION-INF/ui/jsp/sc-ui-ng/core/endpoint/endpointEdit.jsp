<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${permissions.write}">

	<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages"/>
	
	
	<syswf:control mode="script" id="${prefix}C" caption="${prefix}C" hint="" targetTask="/${viewId}/editArtifact">
		<syswf:param name="uuid" value="${uuid}" />
		<syswf:param name="editationListener" value="${endpointEditListener}" />
    </syswf:control>
	
	<a href="javascript:void(0);" id="${prefix}anchor"><fmt:message bundle="${messages}" key="endpoint.edit.label" /></a>
	<script type="text/javascript">
//<![CDATA[

		Ext.onReady(function() { 
		    attachOn('${prefix}anchor','click',${prefix}C); 
		});
	
//]]>
</script>


</c:if>