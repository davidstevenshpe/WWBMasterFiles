<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="report_Message"/>
<c:if test="${isEnabled}">
   <a href="javascript:void(0);" class="UI PageAction Retry" id="${prefix}_recalculateReport"><span><fmt:message key="birt_report.action.recalculate.label" bundle="${report_Message}"/></span></a>
   <div class="webfw-Window" id="${prefix}-webfw-Window">    
        <div id="${prefix}confirm_window" class="x-hidden">
	        <div class="x-window-header"><fmt:message key="birt_report.action.recalculate.header" bundle="${report_Message}"/></div>
	        <div class="x-window-body">
	            <div class="UI Offset">
	                <p class="Warning"><fmt:message key="birt_report.action.recalculate.dialog.message" bundle="${report_Message}"/></p>
	            </div>
	        </div>
        </div>
   </div>
   <syswf:control mode="script" action="recalculate" caption="${prefix}recalculate" >
        <syswf:param name="birtReportBean" value="${birtReportBean}" />
   </syswf:control>
   <c:set var="customButtons">
    [{
        text     : 'OK',
        disabled : false,
        handler  : function() {
            SPopup.Window.Instance['${prefix}confirm_window'].hide();
            ${prefix}recalculate();
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


	    Ext.onReady(function() {
			attachOn('${prefix}_recalculateReport','click',function() {
			     SPopup.Window.forceOpen('${prefix}confirm_window','${prefix}confirm_window',{
			            autoHeight: true, buttons: <c:out value="${customButtons}" escapeXml="false"/>,
			            buttonAlign: 'center', width: 300, resizable: false, centerOnScreen: true
			        });
			});
	        moveWindow('${prefix}confirm_window','popupWindows');
	    });
	
//]]>
</script>
</c:if>
    