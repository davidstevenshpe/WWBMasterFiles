<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.server.ServerMessage" var="serverMsg" />
    
<a href="javascript:void(0);" class="UI PageAction Delete" id="${prefix}_removeCredential"><span><fmt:message key="registryServer.remove.label"  bundle="${serverMsg}"/></span></a>

<syswf:control mode="script" action="remove" caption="${prefix}remove"  affects=".." loadingMask="true">
    <syswf:param name="artifact" value="${artifact}" />
</syswf:control>


<syswf:component name="/core/impl/util/dialog" prefix="removeCredential">
    <syswf:param name="handler" value="${prefix}remove" />
    <syswf:param name="heading"><fmt:message key="registryServer.remove.dialog.title"  bundle="${serverMsg}"/></syswf:param>
    <syswf:param name="content"><fmt:message key="registryServer.remove.dialog.message"  bundle="${serverMsg}"/></syswf:param>
    <syswf:param name="controlName" value="${prefix}_openRemoveCredentialConfirmPopUp"/>
</syswf:component>


<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function(){
		attachOn('${prefix}_removeCredential','click',function() {
			${prefix}_openRemoveCredentialConfirmPopUp();
		});
	});

//]]>
</script>