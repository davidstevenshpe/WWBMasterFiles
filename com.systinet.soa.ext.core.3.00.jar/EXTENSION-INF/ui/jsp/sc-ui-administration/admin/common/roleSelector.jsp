<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<!--
Parameters:  
jsOpenFunction = name of a function that opens the window, has to be bound to an element onClick method
windowTitle = title of the opened window
holder - implementation of PrincipalSelectorListener to hole selected roles.
initSelected : collection of String, default selected roles.
 -->
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.util.uimessages" var="ui_Messages" />
<div class="webfw-Window" id="${prefix}-webfw-Window">    
    <div id="${prefix}selector_window" class="x-hidden">
        <div class="x-window-header">${windowTitle}</div>
        <div class="x-window-body">
            <div class="UI Offset">
	           	<syswf:component name="/core/table" prefix="roleSelector">
		           <syswf:param name="customizationId" value="admin.util.roleSelector"/>		           
		           <syswf:param name="selectionBag" value="${this.tableSelectionBag}" />
		        </syswf:component>
            </div>
        </div>
    </div>
</div>

<%-- action control - fires action after user presses OK --%>
<syswf:control mode="ajax" caption="${prefix}roleSelected" action="roleSelected" />
<c:set var="customButtons">
    [{
        text     : '<fmt:message key="OK" bundle="${ui_Messages}"/>',
        disabled : false,
        handler  : function() {
        	${prefix}roleSelected();
            SPopup.Window.Instance['${prefix}selector_window'].hide();
            SPopup.Window.Instance['${prefix}selector_window'] = undefined;
        },
        id: '${prefix}_okButton'
    },{
        text     : '<fmt:message key="Cancel" bundle="${ui_Messages}"/>',
        handler  : function(){
            SPopup.Window.Instance['${prefix}selector_window'].hide();
            return false;
        },
        id: '${prefix}_cancelButton'
    }]
</c:set>
 
<script type="text/javascript">
//<![CDATA[

var ${jsOpenFunction} = function() {
	SPopup.Window.forceOpen('${prefix}selector_window','${prefix}selector_window',{
        autoHeight: true, buttons: <c:out value="${customButtons}" escapeXml="false"/>,
        buttonAlign: 'center', width: 300, resizable: false, centerOnScreen: true
    });
}

//]]>
</script>



