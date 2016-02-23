<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages"/>

<%--
heading
content
handler
controlName (_control)
windowId (_window)
actionCaption (Ok)
cancelCaption (Cancel)

optional:
    noUndo
    customButtons
 --%>

<c:if test="${empty windowId}">
    <c:set var="windowId" value="${prefix}_window"/>
</c:if>
<c:if test="${empty controlName}">
    <c:set var="controlName" value="${prefix}_control"/>
</c:if>
<c:if test="${empty actionCaption}">
    <fmt:message var="actionCaption" bundle="${messages}" key="OK" />
</c:if>
<c:if test="${empty cancelCaption}">
    <fmt:message var="cancelCaption" bundle="${messages}" key="Cancel"/>
</c:if>
<c:set var="calledHandler">
    <c:choose>
        <c:when test="${empty handler}">return false;</c:when>
        <c:otherwise>${handler}();</c:otherwise>
    </c:choose>
</c:set> 

<div class="webfw-Window" id="${prefix}-webfw-Window">
	<div id="${windowId}" class="x-hidden">
	
		<div id="${windowId}_header" class="x-window-header">
			<c:out value="${heading}" />
		</div>
		
		<div class="x-window-body">
			<div class="UI Offset">

				<p class="Warning" id="${windowId}_content">
					<c:out value="${content}" escapeXml="false" />
				</p>
				<c:set var="undoVisibility">
					<c:choose>
						<c:when test="${noUndo}">show</c:when>
						<c:otherwise>hide</c:otherwise>
					</c:choose>
				</c:set>

				<br />
				<div id="${windowId}_noUndo">
					<fmt:message bundle="${messages}" key="dialog.noUndo" />
				</div>

			</div>
		</div>
	</div>
</div>

<%-- Default buttons --%>
<c:if test="${empty customButtons}">
    <c:set var="customButtons">
        [{
            text     : '${actionCaption}',
            disabled : false,
            handler  : function() {
                SPopup.Window.Instance['${windowId}'].hide();
                ${calledHandler}
            },
            id: '${prefix}_okButton'
        },{
            text     : '${cancelCaption}',
            handler  : function(){
                SPopup.Window.Instance['${windowId}'].hide();
                return false;
            },
            id: '${prefix}_cancelButton'
        }]
    </c:set>
</c:if>

<script type="text/javascript">
//<![CDATA[

var ${controlName} = function() {

    SPopup.Window.forceOpen('${windowId}','${windowId}',{
        plain:false,
        autoHeight:true,
        buttons:<c:out value="${customButtons}" escapeXml="false"/>,
        width:400,
        centerOnScreen:true
    });

};

function ${prefix}_showDialog(element, heading, content, actionCaption, handler, noUndo) {    
}

Ext.onReady(function() {
    Ext.get('${windowId}_noUndo').setVisibilityMode(Ext.Element.DISPLAY);
    Ext.get('${windowId}_noUndo').${undoVisibility}();
    SPopup.Window.Instance['${windowId}'] = null;
    
    ${prefix}_showDialog = function(element, heading, content, actionCaption, handler, noUndo) {
        if (!element) {
            alert('element parameter has to be defined!');  //NON-NLS
            return;
        }
        if (typeof heading == 'string') {
            Ext.get('${windowId}_header').update(heading);
        }
        if (typeof content == 'string') {
            Ext.get('${windowId}_content').update(content);
        }
        if (typeof noUndo == 'boolean') {
            Ext.get('${windowId}_noUndo').setVisible(noUndo);
        }

        var window = SPopup.Window.Instance['${windowId}'];

        if (!window) {
        	${controlName}();
        	window = SPopup.Window.Instance['${windowId}'];
            // window.hide();
        }
        
        var button = window.buttons[0];
        if (typeof handler == 'function') {
            var wrappedHandler = function() {
            	SPopup.Window.Instance['${windowId}'].hide();
                handler();
            };
            button.setHandler(wrappedHandler);
        }
        if (typeof actionCaption == 'string') {
            button.setText(actionCaption);
        }
        
        //window.centerOnScreen();
        var center = window.getEl().getCenterXY();
        window.setPosition([center[0], center[1]]);
        window.show(element);
    };
});



//]]>
</script>
