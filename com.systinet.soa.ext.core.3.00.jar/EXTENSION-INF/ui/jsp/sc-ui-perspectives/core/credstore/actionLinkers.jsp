<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.credstore.credstoremessages" var="credstore_Messages"/>

<a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}edit_credential"><fmt:message key="credstore.edit_credential.label" bundle="${credstore_Messages}"/></a>
<a href="javascript:void(0);" class="UI Icon Delete" id="${prefix}delete_credential"><fmt:message key="credstore.delete_credential.label" bundle="${credstore_Messages}"/></a>

<syswf:control mode="script" action="delete" caption="${prefix}delete">
    <syswf:param name="urlPattern" value="${urlPattern}"/>
</syswf:control>

<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function() {
		 attachOn('${prefix}edit_credential','click',function() {
			 ${openDialogFunction}('${fn:replace(urlPattern,"'","\\'")}');			 
		 });
		 attachOn('${prefix}delete_credential','click',function() {
			 ${prefix}delete();
         });
	})

//]]>
</script>
