<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.userevent.componentsusereventmessages" var="messages"/>
<fmt:message bundle="${messages}" key="events.configAction" var="title"/>
<%--@elvariable id="configType" type="com.hp.systinet.sc.userevent.config.ConfigurationType"--%>
<%--@elvariable id="unsupportedSources" type="java.lang.String"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<%--@elvariable id="myUserProfile" type="java.lang.Boolean"--%>

<c:if test="${myUserProfile}">
    <c:set var="anchorId" value="${prefix}_a"/>
    <c:set var="winOpenFn" value="${prefix}_open"/>
    <a id="${anchorId}" href="javascript:void(0);" class="context-button Configure" title="${title}"></a>

    <syswf:component name="/core/impl/userevent/eventConfigDialog" prefix="dialog">
        <syswf:param name="configType" value="${configType}"/>
        <syswf:param name="openFunctionName" value="${winOpenFn}"/>
        <syswf:param name="unsupportedSources" value="${unsupportedSources}"/>
    </syswf:component>

    <script type="text/javascript">
//<![CDATA[

        attachOn('${anchorId}', 'click', ${winOpenFn});
    
//]]>
</script>
</c:if>

