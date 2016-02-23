<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<c:if test="${permissions.write}">

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages"/>

<syswf:control mode="script" caption="${prefix}cloneEndpoint" action="cloneEndpoint" />
<syswf:component name="/core/window" prefix="w">
    
    <syswf:param name="winComponent" value="/core/impl/endpoint/endpointCloneWindow" />
    <syswf:param name="winTitle"><fmt:message bundle="${messages}" key="endpoint.clone.title" /></syswf:param>
    <syswf:param name="winOpenFunctionName" value="${prefix}open" />
    <syswf:param name="winResizable" value="true" />
    <syswf:param name="winOkAction" value="${prefix}cloneEndpoint" />
    <syswf:param name="winWidth" value="430" />

    <syswf:param name="widgetModels" value="${widgetModels}" />
    <syswf:param name="uuid" value="${uuid}" />
    <syswf:param name="clonedArtifact" value="${clonedArtifact}" />    
</syswf:component>

<a href="javascript:void(0);" id="${prefix}anchor"><fmt:message bundle="${messages}" key="endpoint.clone.label" /></a>
<script type="text/javascript">
//<![CDATA[

Ext.onReady(function() { 
    attachOn('${prefix}anchor','click',${prefix}open); 
});

//]]>
</script>

</c:if>