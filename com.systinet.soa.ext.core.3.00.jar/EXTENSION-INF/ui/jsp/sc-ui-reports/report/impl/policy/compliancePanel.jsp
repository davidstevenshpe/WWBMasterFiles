<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="pr_Messages" />
<fmt:message key="policyreport.ovewview.action.recalculate" var="recalculate_Label" bundle="${pr_Messages}" />
<fmt:message key="policyreport.ovewview.form.recalculate.header" var="recalculate_Header" bundle="${pr_Messages}" />
<fmt:message key="policyreport.ovewview.form.recalculate.confirm" var="recalculate_Confirm" bundle="${pr_Messages}" />

<c:if test="${(not isCalculating) and (not hideComponent)}">
<c:choose>
	<c:when test="${ contextMenu == true}">
	<div class="EA-left-panel">
		<a href="javascript:void(0);" class="UI PageAction Refresh" id="${prefix}_actionLink">${recalculate_Label}</a>
	</div>
	</c:when>
	<c:otherwise>
	<a href="javascript:void(0);" class="context-button Refresh" id="${prefix}_actionLink" title="${recalculate_Label}">&nbsp;</a>
	</c:otherwise>
</c:choose>
	
	<div class="webfw-Window" id="${prefix}-webfw-Window">    
	    <div id="${prefix}confirm_window" class="x-hidden">
	        <div class="x-window-header">${recalculate_Header}</div>
	        <div class="x-window-body">
	            <div class="UI Offset">
	                <p class="Warning">${recalculate_Confirm}</p>
	            </div>
	        </div>
	    </div>
	</div>
	
	<syswf:control mode="script" action="compliance" caption="${prefix}confirm" >
	</syswf:control>
	    
	<c:set var="customButtons">
	    [{
	        text     : 'OK',
	        disabled : false,
	        handler  : function() {
	            SPopup.Window.Instance['${prefix}confirm_window'].hide();
	            ${prefix}confirm();
	        },
	        id: '${prefix}_okButton'
	    },{
	        text     : 'Cancel',
	        handler  : function(){
	            SPopup.Window.Instance['${prefix}confirm_window'].hide();
	            return false;
	        },
	        id: '${prefix}_cancelButton'
	    }]
	</c:set>
	
	<script type="text/javascript">
//<![CDATA[
Ext.onReady(function(){
	attachOn('${prefix}_actionLink','click',function() {
	     SPopup.Window.forceOpen('${prefix}confirm_window','${prefix}confirm_window',{
	            autoHeight: true, buttons: <c:out value="${customButtons}" escapeXml="false"/>,
	            buttonAlign: 'center', width: 320, resizable: false, centerOnScreen: true
	        });
	});
	moveWindow('${prefix}confirm_window','popupWindows');
});	
//]]>
</script>
</c:if>