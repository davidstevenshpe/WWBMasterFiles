<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.customization.customizationmessages" var="cmess" />

<a href="javascript:void(0)" id="${prefix}handler">Manage Categories</a>

<div style="display: none">
	<syswf:control mode="script" action="updateCategories" caption="${prefix}updateCategories" />
	<syswf:control mode="script" action="cancelUpdate" caption="${prefix}cancelUpdate"/>
	
	<syswf:component name="/core/window" prefix="catMgm">
	    <syswf:param name="winTitle">
	        <fmt:message bundle="${cmess}" key="catMgm.popupTitle">
	            <fmt:param value="${label}" />
	            <fmt:param value="${description}" />
	        </fmt:message>
	    </syswf:param>
	    <syswf:param name="winComponent" value="/core/customization/categories/manageCategories"/>
	    <syswf:param name="winOpenFunctionName" value="${prefix}open" />
	    <syswf:param name="winOkLabel"><fmt:message bundle="${labels}" key="Save" /></syswf:param>
	    <syswf:param name="winOkAction" value="${prefix}updateCategories" />
	    <syswf:param name="winCancelAction" value="${prefix}cancelUpdate" />
	    <syswf:param name="holder" value="${holder}" />
	    <syswf:param name="text">
	        <fmt:message bundle="${cmess}" key="catMgm.tableText">
	            <fmt:param value="${label}" />
	            <fmt:param value="${description}" />
	        </fmt:message>
	    </syswf:param>
	</syswf:component>
	
	<script type="text/javascript">
//<![CDATA[
		Ext.onReady(function(){
			attachOn('${prefix}handler','click',function() {
			    ${prefix}open();
			});
			moveWindow('${prefix}_catMgmwin','popupWindows');
		});
//]]>
	</script>
</div>