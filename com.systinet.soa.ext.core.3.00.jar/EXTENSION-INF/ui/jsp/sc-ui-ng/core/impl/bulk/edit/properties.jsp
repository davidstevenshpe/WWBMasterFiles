<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<div class="webfw-Window" id="${prefix}-webfw-Window">    
<div id="${prefix}propertiesWindow" class="x-hidden">
<div class="x-window-header"><fmt:message bundle="${messages}" key="changeProperties.title" /></div>
<div class="x-window-body">
<syswf:component name="/core/impl/window" prefix="propertiesWindowContents">
    <syswf:param name="component" value="/core/impl/bulk/edit/propertiesWindow"/>
    <syswf:param name="windowControlName" value="${prefix}_render" />
    <syswf:param name="propertiesSettings" value="${changePropertiesSettings}"/>
    <syswf:param name="propertiesHolder" value="${propertiesHolder}" />
</syswf:component>
</div>
</div>
</div>

<%-- action control - fires action after user presses OK --%>
<syswf:control mode="script" action="confirmProperties" caption="${prefix}properties" />

<c:set var="customButtons">
    [{
        text     : '<fmt:message bundle="${labels}" key="Apply" />',
        disabled : false,
        handler  : function() {
            SPopup.Window.Instance['${prefix}propertiesWindow'].hide();
            ${prefix}properties();
        },
        id: '${prefix}_okButton'
    },{
        text     : '<fmt:message bundle="${labels}" key="Cancel" />',
        handler  : function(){
            SPopup.Window.Instance['${prefix}propertiesWindow'].hide();
            return false;
        },
        id: '${prefix}_cancelButton'
    }]
</c:set>

<script type="text/javascript">
//<![CDATA[

var ${controlName} = function() {
    ${prefix}_render();
    SPopup.Window.forceOpen('${prefix}propertiesWindow','${prefix}propertiesWindow',{
        plain:false,
        autoHeight:true,
        buttons:<c:out value="${customButtons}" escapeXml="false"/>,
        centerOnScreen:true,
        resizable: false,
        width:700
    });
};
<%-- Popup window needs to be reinitialized on AJAX update --%>
Ext.onReady(function() {
    SPopup.Window.Instance['${prefix}propertiesWindow'] = undefined;
})

//]]>
</script>