<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${this.accessGranted}">
	<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="reportMessage"/>
	<fmt:message bundle="${reportMessage}" key="dashboard.create.label" var="menuLabel" />
	<fmt:message bundle="${reportMessage}" key="dashboard.create.window.title" var="winTitle" />
	
	<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
	<fmt:message bundle="${labels}" key="OK" var="OK" />
	<fmt:message bundle="${labels}" key="Cancel" var="Cancel" />
	
	<syswf:control mode="script" caption="createDashboardFn" action="create"/>
	<syswf:input id="dashboardSelectedLayout" name="selectedLayout" value="" mode="hidden"/>
	
	<c:set var="winCustomButtons">
        [{
        	xtype:'flatbutton',
            text     : '${OK}',
            iconCls:'EA-button green',
            disabled : false,
            handler  : function() {
            	if(Ext.getCmp('dashboardInputName').getValue().trim().length > 0){
                	createDashboardFn();
                	SPopup.Window.Instance['${prefix}createDashboardWin'].hide();
                }
            },
            id: '${prefix}_okButton'
        },{
         	xtype:'flatbutton',
            text     : '${Cancel}',
            iconCls:'EA-button gray',
            handler  : function(){
                SPopup.Window.Instance['${prefix}createDashboardWin'].hide();
                return false;
            },
            id: '${prefix}_cancelButton'
        }]
    </c:set>
	
	<syswf:component name="/core/window" prefix="createDashboardWin">
	    <syswf:param name="winTitle" value="${winTitle}" />
	    <syswf:param name="winComponent" value="/reports/createDashboardWindow" />
	    <syswf:param name="holder" value="${holder}"/>
	    <syswf:param name="dashboardFolders" value="${dashboardFolders}"/>
	    <syswf:param name="dashboardLayouts" value="${dashboardLayouts}"/>
	    <syswf:param name="winOpenFunctionName" value="${prefix}createDashboard" />
	    <syswf:param name="winWidth" value="625"/>
	    <syswf:param name="winButtonAlign" value="right"/>    
	    <syswf:param name="winOkLabel" value="${exportCaption}" />
	    <syswf:param name="winOkAction" value="createDashboardFn" />
	    <syswf:param name="winRenderContents" value="true" />
	    <syswf:param name="winOpenAction" value="focusOnTextFunc" />
	    <syswf:param name="winId" value="${prefix}createDashboardWin"/>
	    <syswf:param name="moveId" value="${prefix}createDashboardWin"/>
	    <syswf:param name="winOkButtonId" value="${prefix}_okButton"/>
	    <syswf:param name="winCustomButtons" value="${winCustomButtons}"/>
	    <syswf:param name="customWinOkButtonId" value="${prefix}_okButton"/>
	</syswf:component>
	
	<li>
		<a href="javascript:void(0)" onclick="${prefix}createDashboard()">${menuLabel}</a>
	</li>
	
	<script type="text/javascript">
	//<![CDATA[
	
	    function focusOnTextFunc(){
	    	Ext.get('createDashboardWinInvalidNameMsg').setStyle('display', 'none');
	    	Ext.getCmp('dashboardInputName').clearInvalid();
	    	Ext.getCmp('dashboardInputName').setValue('');
	    	Ext.getCmp('dashboardInputName').focus(false, 500);
	    }
	    
	//]]>
	</script>
</c:if>