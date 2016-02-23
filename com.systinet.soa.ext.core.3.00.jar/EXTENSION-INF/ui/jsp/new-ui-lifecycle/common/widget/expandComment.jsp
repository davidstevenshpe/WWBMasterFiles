<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<%--@elvariable id="anchorId" type="java.lang.String"--%>
<%--@elvariable id="bodyId" type="java.lang.String"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>
<c:if test="${empty anchorId}">
    <c:set var="anchorId" value="${prefix}"/>
</c:if>
<fmt:message key="expandLink.label" bundle="${messages}" var="expandLabel"/>
<a href="javascript:void(0)" class="UI Icon Expand" id="${anchorId}"><span>${expandLabel}</span></a>
<script type="text/javascript">
//<![CDATA[

    Ext.get('${anchorId}').on('click', function() {
        AdvancedOptions.Comment.Switch('${anchorId}', '${bodyId}');
    });

//]]>
</script>
