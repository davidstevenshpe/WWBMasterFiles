<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.credstore.credstoremessages" var="credstore_Messages"/>
<fmt:message key="credstore.saved_passwords.label" bundle="${credstore_Messages}" var="title"/>

<c:if test ="${isEnable}">
	<a href="javascript:void(0);" class="context-button StoredPassword" id="${prefix}_savePasswords" title="${title}"></a>
	
	<div class="webfw-Window" id="${prefix}-webfw-Window">    
		<div id="${prefix}userCredentialWindow" class="x-hidden">
			<div class="x-window-header"><fmt:message key="credstore.saved_passwords.dialog.title" bundle="${credstore_Messages}" /></div>
			<div class="x-window-body">
				<div class="UI Offset">
				    <syswf:component name="/core/impl/window" prefix="savedPasswordsWindowContent">
				        <syswf:param name="component" value="/core/credstore/credential/credentialManagementWindow"/>
				        <syswf:param name="windowControlName" value="${prefix}_render" />
				    </syswf:component>
				</div>
			</div>
		</div>
	</div>
	<c:set var="customButtons">
	    [{
	        text     : '<fmt:message key="credstore.saved_passwords.button.close.label" bundle="${credstore_Messages}" />',
	        handler  : function(){
	            SPopup.Window.Instance['${prefix}userCredentialWindow'].hide();
	            return false;
	        },
	        id: '${prefix}_cancelButton'
	    }]
	</c:set>
	
	
	<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function(){
	    attachOn('${prefix}_savePasswords','click',function() {
	        ${prefix}_render();
	        SPopup.Window.forceOpen('${prefix}userCredentialWindow','${prefix}userCredentialWindow',{
	                plain:false,
	                autoHeight:true,
	                buttons:<c:out value="${customButtons}" escapeXml="false"/>,
	                width:450,
	                buttonAlign:'right',
	                centerOnScreen:true
	        });
	    });
	});
	
//]]>
</script>
</c:if>
