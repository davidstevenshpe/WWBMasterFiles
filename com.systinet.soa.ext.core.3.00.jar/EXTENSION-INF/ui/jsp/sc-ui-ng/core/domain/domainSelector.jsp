<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<!--
Parameters:  
jsOpenFunction = name of a function that opens the window, has to be bound to an element onClick method
 -->

<fmt:setBundle basename="com.hp.systinet.sc.ui.domain.domainmessages" var="domainMessages"/>

<fmt:message var="switchDomainBtnCaption" key="switchDomainBtnCaption" bundle="${domainMessages}"/>
<fmt:message var="setDefaultDomainBtnCaption" key="setDefaultDomainBtnCaption" bundle="${domainMessages}"/>
<fmt:message var="cancelBtnCaption" key="cancelBtnCaption" bundle="${domainMessages}"/>
<fmt:message var="selectDomainTitle" key="selectDomainTitle" bundle="${domainMessages}"/>


<%-- action control - fires action to check organization unit --%>
<syswf:control mode="script" action="showDomainDialog" caption="${prefix}showDomainDialog" affects="."/>
<syswf:input id="${prefix}domainId" name="domainId" mode="hidden" value="" />

	<c:if test="${empty actionMode}">
	    <c:set var="actionMode" value="ajax"/>
	</c:if>
	
	<c:set var="customButtons">
	    [{
		    xtype:'flatbutton',
	        text     : '<c:out value="${switchDomainBtnCaption}"></c:out>',
	        disabled : false,
			iconCls:'btn btn-primary',
	        handler  : function() {
	            SPopup.Window.Instance['${prefix}changeWorkingDomain_win'].hide();	           	
	           	Ext4.get('${prefix}domainId').dom.value = $('#listDomainContainer a.active').attr('data-value');
	            ${prefix}switchDomain();
	        },
	        id: '${prefix}_switchButton'
	    },{
			xtype:'flatbutton',
	        text     : '<c:out value="${setDefaultDomainBtnCaption}"></c:out>',
	        disabled : false,
			iconCls:'btn btn-primary',
	        handler  : function() {
	            ${prefix}changeDomain({
	            	domainId: $('#listDomainContainer a.active').attr('data-value')
            	});
	            this.disable();
	        },
	        id: '${prefix}_setdefaultButton'
	    },{
			xtype:'flatbutton',
	        text     : '<c:out value="${cancelBtnCaption}"></c:out>',
			iconCls:'btn btn-default',
	        handler  : function(){
	            SPopup.Window.Instance['${prefix}changeWorkingDomain_win'].hide();
	            return false;
	        },
	        id: '${prefix}_cancelButton'
	    }]
	</c:set>
	
	<syswf:control mode="${actionMode}" action="switchDomain" caption="${prefix}switchDomain" />
	
	<syswf:component name="/core/window" prefix="domainWindowContents">
		<syswf:param name="winId" value="${prefix}changeWorkingDomain_win" />
	    <syswf:param name="winTitle" value="${selectDomainTitle}" />
	    <syswf:param name="winCustomButtons" value="${customButtons}" />
	    <syswf:param name="winComponent" value="/core/domain/domainSelectorWindow" />
	    <syswf:param name="winOpenFunctionName" value="${jsOpenFunction}" />
	    <syswf:param name="winButtonAlign" value="right" />
	    <syswf:param name="winRenderContents" value="true" />
	    <syswf:param name="roleVisibility" value="true" />
	    <syswf:param name="defaultBtnId" value="${prefix}_setdefaultButton" />
	    <syswf:param name="winOpenAction" value="changeDomainWndOpen" />
	    <syswf:param name="winWidth" value="610" />
	    <syswf:param name="parentPrefix" value="${prefix}" />
	</syswf:component>
	
	<script type="text/javascript">
//<![CDATA[
	    Ext4.onReady(function(){
	        moveWindow('${prefix}changeWorkingDomain_win','popupWindows');
	    });
//]]>
	</script>