<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>

<%--@elvariable id="author" type="com.hp.systinet.security.role.Principal"--%>
<%--@elvariable id="text" type="java.lang.String"--%>
<%--@elvariable id="prefix" type="java.lang.String"--%>

<c:set var="commentBodyId" value="${prefix}"/>
<a href="javascript:void(0)" class="UI Icon NewComment" id="${commentBodyId}"><span></span></a>
<div class="x-hidden flyout-menu UI Dropdown" id="${commentBodyId}_content">
    <c:if test="${not empty author}">
        <div class="DropdownTitle">
            <syswf:component name="/core/impl/util/principalLinkRenderer" prefix="author" wrap="false">
                <syswf:param name="principal" value="${author}"/>
                <syswf:param name="showIcon" value="${true}"/>
            </syswf:component>
        </div>
    </c:if>
    <div class="DropdownContent">
        <p class="Comment">
            <c:out value="${text}"/>
        </p>
    </div>
</div>
<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        Dropdown.init('${commentBodyId}', '${commentBodyId}_content', {align: 'tl-tr?', alignOffset: [0,0]});
    });

//]]>
</script>
