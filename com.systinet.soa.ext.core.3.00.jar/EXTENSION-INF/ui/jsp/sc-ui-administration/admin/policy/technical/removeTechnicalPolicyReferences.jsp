<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.policy.technical.TechnicalPolicyMessages" var="tpMessages" />

<fmt:message var="okButtonLabel" key="removeTechnicapPolicyReferences.okButtonLabel" bundle="${tpMessages}" />
<fmt:message var="cancelButtonLabel" key="removeTechnicapPolicyReferences.cancelButtonLabel" bundle="${tpMessages}" />

<c:if test="${isAccessGranted and (not isDeleted)}">
<div class="webfw-Window" id="${prefix}-webfw-Window">    
    <div id="${prefix}removeMember_window" class="x-hidden">
        <div class="x-window-header"><syswf:out value="${dialogTitle}" context="HtmlBody"/></div>
        <div class="x-window-body">
            <div class="UI Offset">
                <p class="Warning">${dialogMessage}</p>
            </div>
        </div>
    </div>
</div>

<syswf:control mode="script" action="remove" caption="${prefix}remove" >
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:control>
    
<c:set var="customButtons">
    [{
        text     : '${okButtonLabel}',
        disabled : false,
        handler  : function() {
            SPopup.Window.Instance['${prefix}removeMember_window'].hide();
            ${prefix}remove();
        },
        id: '${prefix}_okButton'
    },{
        text     : '${cancelButtonLabel}',
        handler  : function(){
            SPopup.Window.Instance['${prefix}removeMember_window'].hide();
            return false;
        },
        id: '${prefix}_cancelButton'
    }]
</c:set>

<script type="text/javascript">
//<![CDATA[

var ${controlName} = function() {
    SPopup.Window.forceOpen('${prefix}removeMember_window','${prefix}removeMember_window',{
        autoHeight: true, buttons: <c:out value="${customButtons}" escapeXml="false"/>,
        buttonAlign: 'center', width: 350, resizable: false, centerOnScreen: true
    });
}

//]]>
</script>
</c:if>