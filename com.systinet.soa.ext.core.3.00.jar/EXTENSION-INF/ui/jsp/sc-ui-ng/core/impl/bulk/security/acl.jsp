<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.bulk.BulkComponentsMessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<div class="webfw-Window" id="${prefix}-webfw-Window">    
<div id="${prefix}aclWindow" class="x-hidden">
<div class="x-window-header"><fmt:message bundle="${messages}" key="changeAcl.title" /></div>
<div class="x-window-body">
<div class="UI Offset">
<syswf:component name="/core/impl/window" prefix="aclWindowContents">
    <syswf:param name="component" value="/core/impl/bulk/security/aclWindow"/>
    <syswf:param name="windowControlName" value="${prefix}_render" />
    <syswf:param name="holder" value="${holder}"/>
    <syswf:param name="aclSettings" value="${aclSettings}"/>
    <syswf:param name="winOnRenderCallback" value="${prefix}openSelector" />
</syswf:component>

</div>
</div>
</div>
</div>

<%-- action control - fires action after user presses OK --%>
<syswf:control mode="script" action="confirmAcl" caption="${prefix}acl" />

<c:set var="customButtons">
    [{
        text     : '<fmt:message bundle="${labels}" key="OK" />',
        disabled : false,
        handler  : function() {
            SPopup.Window.Instance['${prefix}aclWindow'].hide();
            ${prefix}acl();
        },
        id: '${prefix}_okButton'
    },{
        text     : '<fmt:message bundle="${labels}" key="Cancel" />',
        handler  : function(){
            SPopup.Window.Instance['${prefix}aclWindow'].hide();
            return false;
        },
        id: '${prefix}_cancelButton'
    }]
</c:set>

<script type="text/javascript">
//<![CDATA[

var ${controlName} = function() {
    ${prefix}_render();
    SPopup.Window.forceOpen('${prefix}aclWindow','${prefix}aclWindow',{
        plain:false,
        autoHeight:true,
        buttons:<c:out value="${customButtons}" escapeXml="false"/>,
        width:650,
        centerOnScreen:true
    });
};
<%-- Popup window needs to be reinitialized on AJAX update --%>
Ext.onReady(function() {
    SPopup.Window.Instance['${prefix}aclWindow'] = undefined;
})

//]]>
</script>