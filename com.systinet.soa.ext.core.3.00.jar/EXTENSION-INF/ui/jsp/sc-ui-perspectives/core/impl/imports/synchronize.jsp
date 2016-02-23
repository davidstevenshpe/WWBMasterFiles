<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<div class="webfw-Window" id="${prefix}-webfw-Window">    
    <div id="${prefix}synchronize_window" class="x-hidden">
        <div class="x-window-header"><fmt:message bundle="${messages}" key="synchronize.title"/></div>
        <div class="x-window-body">
            <div class="UI Offset">

                <syswf:component name="/core/impl/window" prefix="synchronizeWindowContents">
                    <syswf:param name="component" value="/core/impl/bulk/synchronizeWindow"/>
                    <syswf:param name="windowControlName" value="${prefix}_render" />
                    <syswf:param name="settings" value="${settings}"/>
                    <syswf:param name="selectionBag" value="${selectionBag}" />
                </syswf:component>

            </div>
        </div>
    </div>
</div>

<%-- action control - fires action after user presses OK --%>
<syswf:control mode="script" action="synchronize" caption="${prefix}synchronize" />

<c:set var="customButtons">
    [{
        text     : '<fmt:message bundle="${messages}" key="synchronize.title" />',
        disabled : false,
        handler  : function() {
            SPopup.Window.Instance['${prefix}synchronize_window'].hide();
            ${prefix}synchronize();
        },
        id: '${prefix}_okButton'
    },{
        text     : '<fmt:message bundle="${labels}" key="Cancel" />',
        handler  : function(){
            SPopup.Window.Instance['${prefix}synchronize_window'].hide();
            return false;
        },
        id: '${prefix}_cancelButton'
    }]
</c:set>

<script type="text/javascript">
//<![CDATA[

var ${controlName} = function() {
    ${prefix}_render();
    SPopup.Window.forceOpen('${prefix}synchronize_window','${prefix}synchronize_window',{
        autoHeight: true, buttons: <c:out value="${customButtons}" escapeXml="false"/>,
        buttonAlign: 'center', width: 300, resizable: false, centerOnScreen: true
    });
}

//]]>
</script>