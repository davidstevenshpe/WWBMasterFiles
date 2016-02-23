<%-- (C) Copyright 2003-2011 Hewlett-Packard Development Company, L.P. --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.lifecycle.ui.LifecycleUiL10n" var="messages"/>
<fmt:message key="editActorsTable.editApprovers" var="editApproversTitle" bundle="${messages}"/>
<fmt:message key="editActorsTable.editReadAccess" var="editReadAccessTitle" bundle="${messages}"/>
<fmt:message key="editActorsTable.editWriteAccess" var="editWriteAccessTitle" bundle="${messages}"/>
<fmt:message key="editActorsTable.action.ok" var="winOkLabel" bundle="${messages}"/>

<syswf:component name="/newUi/lc/common/widget/infoMessage" prefix="info">
    <syswf:param name="message"><fmt:message key="responsibilitiesTable.message" bundle="${messages}"/></syswf:param>
</syswf:component>

<syswf:block className="UI Block Common">
    <syswf:component name="/core/table" prefix="responsibilitiesTable">
        <syswf:param name="customizationId" value="admin.lifecycle.process.responsibilitiesTable"/>
        <syswf:param name="datasource" value="${dataSource}" />
        <syswf:param name="process" value="${process}" />
        <syswf:param name="tableId" value="responsibilitiesTable"/>
    </syswf:component>
</syswf:block>

<c:set var="okButtonApprovers">
    [{
        text     : '${winOkLabel}',
        disabled : false,
        handler  : function() {
        	${prefix}refresh();
            SPopup.Window.Instance['${prefix}editApproversWin'].hide();
        },
        id: '${prefix}_okButtonApprovers'
    }]
</c:set>

<c:set var="okButtonReadAccess">
    [{
        text     : '${winOkLabel}',
        disabled : false,
        handler  : function() {
            ${prefix}refresh();
            SPopup.Window.Instance['${prefix}editReadAccessWin'].hide();
        },
        id: '${prefix}_okButtonReadAccess'
    }]
</c:set>

<c:set var="okButtonWriteAccess">
    [{
        text     : '${winOkLabel}',
        disabled : false,
        handler  : function() {
            ${prefix}refresh();
            SPopup.Window.Instance['${prefix}editWriteAccessWin'].hide();
        },
        id: '${prefix}_okButtonWriteAccess'
    }]
</c:set>

<syswf:control mode="script" action="refresh" caption="${prefix}refresh" />

<syswf:component name="/core/window" prefix="editApprovers">
    <syswf:param name="winId">${prefix}editApproversWin</syswf:param>
    <syswf:param name="winTitle">${editApproversTitle}</syswf:param>
    <syswf:param name="winComponent" value="/newUi/lc/admin/responsibilities/editApproversTable"/>
    <syswf:param name="winGetParamsFunctionName" value="editGetParams" />
    <syswf:param name="winOpenFunctionName" value="openEditApprovers" />
    <syswf:param name="winRenderAlways" value="true" />
    <syswf:param name="winRenderAlways" value="true" />
    <syswf:param name="winCustomButtons" value="${okButtonApprovers}" />
    <syswf:param name="winCancelAction" value="${prefix}refresh" />    
    
    <syswf:param name="process" value="${process}" />
</syswf:component>

<syswf:component name="/core/window" prefix="editReadAccess">
    <syswf:param name="winId">${prefix}editReadAccessWin</syswf:param>
    <syswf:param name="winTitle">${editReadAccessTitle}</syswf:param>
    <syswf:param name="winComponent" value="/newUi/lc/admin/responsibilities/editAccessTable"/>
    <syswf:param name="winGetParamsFunctionName" value="editGetParams" />
    <syswf:param name="winOpenFunctionName" value="openEditReadAccess" />
    <syswf:param name="winOkLabel" value="${addLabel}" />
    <syswf:param name="winRenderAlways" value="true" />     
    <syswf:param name="winCustomButtons" value="${okButtonReadAccess}" />
    <syswf:param name="winCancelAction" value="${prefix}refresh" />
    
    <syswf:param name="process" value="${process}" />
    <syswf:param name="titleLabel" value="${editReadAccessTitle}" />        
</syswf:component>

<syswf:component name="/core/window" prefix="editWriteAccess">
    <syswf:param name="winId">${prefix}editWriteAccessWin</syswf:param>
    <syswf:param name="winTitle">${editWriteAccessTitle}</syswf:param>
    <syswf:param name="winComponent" value="/newUi/lc/admin/responsibilities/editAccessTable"/>
    <syswf:param name="winGetParamsFunctionName" value="editGetParams" />
    <syswf:param name="winOpenFunctionName" value="openEditWriteAccess" />
    <syswf:param name="winOkLabel" value="${addLabel}" />
    <syswf:param name="winRenderAlways" value="true" />
    <syswf:param name="winCustomButtons" value="${okButtonWriteAccess}" />
    <syswf:param name="winCancelAction" value="${prefix}refresh" />    
    
    <syswf:param name="process" value="${process}" />
    <syswf:param name="titleLabel" value="${editWriteAccessTitle}" />            
</syswf:component>

<syswf:input id="editStageId" name="editStageId" value="" mode="hidden"/>
<syswf:input id="editAction" name="editAction" value="" mode="hidden"/>


<script type="text/javascript">
//<![CDATA[

    function editGetParams() {
        return {
            'editStageId' : Ext.get('editStageId').dom.value,
            'editAction': Ext.get('editAction').dom.value
        };
    }

    function getSelectedStagesCsv(inputName){
        var selector = 'DIV.x-grid3-cell-inner.x-grid3-col-_selection INPUT.UI.Form.Checkbox';
        var source = Ext.get('${prefix}_responsibilitiesTable');
        var controls = source.query(selector);
    
        var selected = "";
        var selectedCnt = 0;
        for (var i in controls) {
            if (controls[i].checked){
                if (selectedCnt > 0){
                    selected += ",";
                }
                selected += controls[i].value;                
                selectedCnt ++;
            }
        }
        Ext.get(inputName).dom.value = selected;
    }
   
	function prepareOpenEditApprovers(stageId) {
        Ext.get('editStageId').dom.value = stageId;
        Ext.get('editAction').dom.value = 'APPROVERS';        
        openEditApprovers();
	}

	function prepareOpenEditReadAccess(stageId){
        Ext.get('editStageId').dom.value = stageId;
        Ext.get('editAction').dom.value = 'READ_ACCESS';          
        openEditReadAccess();
	}	

	function prepareOpenEditWriteAccess(stageId){
        Ext.get('editStageId').dom.value = stageId;
        Ext.get('editAction').dom.value = 'WRITE_ACCESS';                
        openEditWriteAccess();
	}

    function prepareChangeOwner(stageId){
        Ext.get('editStageId').dom.value = stageId;
        changeOwner();
    }
	

//]]>
</script>
