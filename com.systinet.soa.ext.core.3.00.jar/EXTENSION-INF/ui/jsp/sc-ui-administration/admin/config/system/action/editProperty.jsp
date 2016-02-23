<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.util.uimessages" var="common_Messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.system.SystemSettingsMessages" var="system_Messages" />
	

<syswf:input id="editingPropertyId" name="editingPropertyId" value="" mode="hidden"/>

<div class="webfw-Window" id="${prefix}-webfw-Window">    
    <div id="${prefix}editPropertyWindow" class="x-hidden">
        <div class="x-window-header"><fmt:message key="systemsettings.detailProperty.action.edit.dialog.header" bundle="${system_Messages}"/></div>
        <div class="x-window-body">
          	<syswf:component  name="/core/impl/window" prefix="win">
			    <syswf:param name="component" value="/admin/configuration/system/action/editPropertyWindow"/>
                <syswf:param name="windowControlName" value="${prefix}_render" />
			    <syswf:param name="propertyBean" value="${propertyBean}"/>
                <syswf:param name="getParamsFunctionName" value="editDialog_getParams" />
                <syswf:param name="alwaysRender" value="true" />
			</syswf:component>
        </div>
    </div>
</div>

<c:set var="customButtons">
    [{
        text     : '<fmt:message key="systemsettings.detailProperty.action.edit.dialog.bt_save.label" bundle="${system_Messages}"/>',
        disabled : false,
        handler  : function() {
            SPopup.Window.Instance['${prefix}editPropertyWindow'].hide();
            
            ${prefix}save();
        },
        id: '${prefix}_saveButton'
    },{
        text     : '<fmt:message key="systemsettings.detailProperty.action.edit.dialog.bt_load.label" bundle="${system_Messages}"/>',
        disabled : false,
        handler  : function() {
        	 ${prefix}load();
        },
        id: '${prefix}_loadButton'
    },
    {
        text     : '<fmt:message key="systemsettings.detailProperty.action.edit.dialog.bt_cancel.label" bundle="${system_Messages}"/>',
        handler  : function(){
            SPopup.Window.Instance['${prefix}editPropertyWindow'].hide();
            return false;
        },
        id: '${prefix}_cancelButton'
    }]
</c:set>

<%-- action control - fires action after user presses OK --%>
<syswf:control mode="script" action="save" caption="${prefix}save" />
<syswf:control mode="script" action="load" caption="${prefix}load" affects="${prefix}_win_window"/>

<script type="text/javascript">
//<![CDATA[

	function storeEditingProperties(propertyId) {
	    Ext.get('editingPropertyId').dom.value = propertyId;
	}
	function editDialog_getParams() {
        return {
            'editingPropertyId' : Ext.get('editingPropertyId').dom.value
        };
	}
	function ${openDialogFunction}(propertyId) {
	    storeEditingProperties(propertyId);
	    ${prefix}_render();
	    SPopup.Window.forceOpen('${prefix}editPropertyWindow','${prefix}editPropertyWindow',{
	        autoHeight: true, 
	        width: 430,
	        resizable: false,
	        buttons: <c:out value="${customButtons}" escapeXml="false"/>,
	        buttonAlign:'center',
	        centerOnScreen:true
	    });
	}
	
	Ext.onReady(function() {
	    SPopup.Window.Instance['${prefix}editPropertyWindow'] = undefined;
	})

//]]>
</script>
