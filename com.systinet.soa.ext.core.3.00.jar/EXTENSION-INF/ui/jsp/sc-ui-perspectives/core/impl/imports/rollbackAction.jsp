<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>    

<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- Set Bundle. --%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.imports.importsMessages" var="importsMessages"/>
<fmt:message var="rollbackButton" key="rollbackButton" bundle="${importsMessages}"/>
<fmt:message var="confirmRollbackWindowTitle" key="confirmRollbackWindowTitle" bundle="${importsMessages}"/>
<fmt:message var="confirmRollbackQuestion" key="confirmRollbackQuestion" bundle="${importsMessages}"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels"/>
<fmt:message var="cancelButton" key="Cancel" bundle="${labels}"/>

<c:if test="${permissions.write && stopped && somethingToRollback}">

    <syswf:control mode="script" caption="${prefix}rollback" action="rollback" />        
    
    <a href="javascript:void(0)" class="IconButton" id="${prefix}rollbackButton"><span><span><span class="Undo">${rollbackButton}</span></span></span></a>
    
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
                Ext.get('${prefix}rollbackButton').on('click', ${prefix}openWindow);
        });
    
//]]>
</script>
    
    <div class="webfw-Window" id="${prefix}-webfw-Window">    
        <div id="${prefix}rollback_window" class="x-hidden">
            <div class="x-window-header">${confirmRollbackWindowTitle}</div>
            <div class="x-window-body">
                <div class="UI Offset">
                    <p class="Warning">${confirmRollbackQuestion}</p>
                </div>
            </div>
        </div>
    </div>
    
    <script type="text/javascript">
//<![CDATA[

        var ${prefix}buttons = [{
                text: '${rollbackButton}', disabled: false, handler: function(){ SPopup.Window.Instance['${prefix}rollback_window'].hide(); ${prefix}rollback();}, id: '${prefix}_rollback'
            },
            {
                text: '${cancelButton}', handler: function(){ SPopup.Window.Instance['${prefix}rollback_window'].hide(); return false;}, id: '${prefix}_close'
            
            }];
        var ${prefix}openWindow = function() {
            SPopup.Window.forceOpen('${prefix}rollback_window','${prefix}rollback_window',{
                autoHeight: true, buttons: ${prefix}buttons, width: 300, moveout:true, resizable: false, centerOnScreen:true, buttonAlign: 'center'
            });
        };
    
//]]>
</script>
    
</c:if>