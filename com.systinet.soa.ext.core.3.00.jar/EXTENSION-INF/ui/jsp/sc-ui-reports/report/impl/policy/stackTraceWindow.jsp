<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="messages"/>

<%--@elvariable id="linkId" type="java.lang.String"--%>
<%--@elvariable id="stackTrace" type="java.lang.String"--%>

<%--
Parameters:
linkId - id of a href element to which click action will be bound that will open the window
stackTrace - string with error stack trace that will be shown in window body
--%>

<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        Ext.get('${linkId}').on('click', function() {
            SPopup.Window.forceOpen('${linkId}_win', '${linkId}_content', {
                id: '${linkId}_win',
                width: 640,
                height: 320,
                autoScroll: true,
                resizable: true,
                plain: false,
                cls: 'hp-stacktrace-window',
                centerOnScreen: true,
                buttonAlign: 'center',
                buttons: [{
                    text: '<fmt:message key="OK" bundle="${messages}" />',
                    handler: function() {
                        SPopup.Window.Instance['${linkId}_win'].hide();
                    }
                }
            ]});
        });
    });

//]]>
</script>

<div id="${linkId}_content" class="x-hidden">
    <div class="x-window-header"><fmt:message key="validationStackTrace.windowTitle" bundle="${messages}"/></div>
    <div class="x-window-body">
        <div class="UI Offset">
            <pre><c:out value="${stackTrace}" escapeXml="true"/></pre>
        </div>
    </div>
</div>
