<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />

<c:if test="${permissions.write && notComplete && hasRelationToTask}">
    
    <syswf:control mode="script" caption="stop" action="stop" />
    
    <a href="javascript:void(0)" class="IconButton" id="StopButton"><span><span><span class="Cancel"><fmt:message bundle="${messages}" key="report.stop" /></span></span></span></a>   
    
    <script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        Ext.get('StopButton').on('click', function(e) {
            Ext.MessageBox.show({
                title: "<fmt:message bundle="${messages}" key="report.stop" />",
                msg: '<syswf:addSlashes><fmt:message bundle="${messages}" key="report.stopConfirm"><fmt:param value="${reportArtifact.name}" /></fmt:message></syswf:addSlashes>',
                buttons: Ext.MessageBox.YESNO,
                fn: function(answer) {
                    if(answer == LANG.Yes.toLowerCase()) {
                        stop();
                    }
                },
                icon: Ext.MessageBox.WARNING
            });
        });
    });
    
//]]>
</script>
</c:if>