<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="prefix" type="java.lang.String"--%>

<fmt:setBundle basename="com.systinet.webfw.ui.WebFrameworkUIMessages" var="webFrameworkUI_Messages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.userevent.componentsusereventmessages" var="eventMessages"/>

<syswf:control mode="script" caption="${prefix}_refresh" affects="." action="refresh"/>

<script type="text/javascript">
//<![CDATA[


    if (${prefix}_timeout) {
        clearTimeout(${prefix}_timeout);
    }
    if (${prefix}_disableTimeout) {
        clearTimeout(${prefix}_disableTimeout);
    }

    var ${prefix}_timeout;
    var ${prefix}_disableTimeout;
//    Ext.onReady(function(){
        var el = Ext.get('newEventCountSpan');
        if (el) {
            el.update('${newEventCount}');
        }

        <c:if test="${newEventCount > 0}">
            el = Ext.get('platform_events');
            if (el) {
                el.addClass("Active");
            }
        </c:if>
//    });

    var ${prefix}_checksEnabled = true;
    function ${prefix}_disableChecks() {
        ${prefix}_checksEnabled = false;
    }
    
    function ${prefix}_checkNewEvent() {
        if (${prefix}_checksEnabled) {
            Ext.Ajax.request({
                url : '${deploymentUrl}/eventNotification',
                method : 'GET',
                params : {
                    time1 : ${lastNewEventCheck},
                    token: '${eventNotificationToken}'
                },
                timeout : 30*1000,
                failure : function(response) {
                    ${prefix}_timeout = setTimeout('${prefix}_checkNewEvent()', ${notificationRefreshInterval});
                },
                success : function(response) {
                    var xml = response.responseXML;
                    if (xml != null && xml.getElementsByTagName('true').length == 1) {
                        ${prefix}_refresh();
                    } else {
                        ${prefix}_timeout = setTimeout('${prefix}_checkNewEvent()', ${notificationRefreshInterval});
                    }
                }
            });
        }
    }

    Ext.onReady(function(){
        ${prefix}_timeout = setTimeout('${prefix}_checkNewEvent()', ${notificationRefreshInterval});
        ${prefix}_disableTimeout = setTimeout('${prefix}_disableChecks()', ${pageContext.session .maxInactiveInterval * 1000 / 2});
    });

//]]>
</script>

<c:if test="${not empty newEvents}">
    <div id="platform_events_tip" class="x-hidden">
        <ul>
            <c:forEach items="${newEvents}" var="row" varStatus="status">
                <li class="${row.styleClass}">
                    <syswf:component prefix="nonProgressEventLink_${status.index}"
                                     name="/core/impl/userevent/eventLinkRenderer" wrap="false">
                        <syswf:param name="eventBean" value="${row.userEvent}"/>
                        <syswf:param name="styleClass" value="ItemName"/>
                    </syswf:component>
                    <c:if test="${not status.last}"><hr/></c:if>
                </li>
            </c:forEach>
        </ul>

        <%--@elvariable id="eventCfgOpenFn" type="java.lang.String"--%>
        <c:set var="eventCfgAnchorId" value="${prefix}cfgLink"/>
        <div class="UI Align"><a id="${eventCfgAnchorId}" href="javascript:void(0);" class="Right"><fmt:message
                bundle="${eventMessages}" key="events.configAction.bubble"/></a></div>
        <div class="x-clear"></div>
        <script type="text/javascript">
//<![CDATA[

            Ext.onReady(function() {
                attachOn('${eventCfgAnchorId}', 'click', ${eventCfgOpenFn});
            });
        
//]]>
</script>
    </div>

    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {

            var tip = Ext.getCmp('platform-events');
            if (tip) {
                tip.destroy();
                tip = null;
            }

            tip = new Ext.HP.EventsTip({
                id: 'platform-events',
                target: 'platform_events',
                title: '<fmt:message key="newEvents" bundle="${webFrameworkUI_Messages}"/>',
                dismissDelay: 10000, // 10s
                closable: true,
                width: 315,
                contentEl: 'platform_events_tip'
            });
            
            tip.show();
        });
    
//]]>
</script>
</c:if>

