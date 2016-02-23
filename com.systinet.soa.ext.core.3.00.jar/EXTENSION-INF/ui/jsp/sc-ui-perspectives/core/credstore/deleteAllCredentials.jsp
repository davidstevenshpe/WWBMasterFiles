<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- REVIEW (Danh 2010-06-22): reuse confirmation dialog /core/impl/util/dialog, instead writing a new one --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.credstore.credstoremessages" var="credstore_Messages"/>

<div class="webfw-Window" id="${prefix}-webfw-Window">    
    <div id="${prefix}deleteAll_window" class="x-hidden">
        <div class="x-window-header"><fmt:message key="credstore.deleteAll.label" bundle="${credstore_Messages}"/></div>
        <div class="x-window-body">
            <div class="UI Offset">
                <p class="Warning"><fmt:message key="credstore.deleteAll.dialog.message" bundle="${credstore_Messages}"/></p>
            </div>
        </div>
    </div>
</div>
<c:set var="customButtons">
    [{
        text     : '<fmt:message key="credstore.deleteAll.dialog.button.OK" bundle="${credstore_Messages}"/>',
        disabled : false,
        handler  : function() {
            SPopup.Window.Instance['${prefix}deleteAll_window'].hide();
            ${prefix}deleteAll();
        },
        id: '${prefix}_okButton'
    },{
        text     : '<fmt:message key="credstore.deleteAll.dialog.button.Cancel" bundle="${credstore_Messages}"/>',
        handler  : function(){
            SPopup.Window.Instance['${prefix}deleteAll_window'].hide();
            return false;
        },
        id: '${prefix}_cancelButton'
    }]
</c:set>
<syswf:control mode="script" action="deleteAll" caption="${prefix}deleteAll"/>
<script type="text/javascript">
//<![CDATA[

var ${controlName} = function() {
    SPopup.Window.forceOpen('${prefix}deleteAll_window','${prefix}deleteAll_window',{
        autoHeight: true, buttons: <c:out value="${customButtons}" escapeXml="false"/>,
        buttonAlign: 'center', width: 300, resizable: false, centerOnScreen: true
    });
}
Ext.onReady(function() {
    SPopup.Window.Instance['${prefix}deleteAll_window'] = undefined;
})

//]]>
</script>