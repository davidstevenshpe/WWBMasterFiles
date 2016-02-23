<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.system.SystemSettingsMessages" var="system_Messages" />
<c:if test ="${propertyType eq 'file'}">
	<syswf:component name="/admin/configuration/system/action/uploadDownloadLinker" prefix="uploadDownloadPropertyPrefix" wrap="false">
		<syswf:param name="propertyId" value="${propertyId}"/>
 	</syswf:component>
</c:if>
<c:if test ="${propertyType eq 'string'}">
    <a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}edit_property"><span><fmt:message key="systemsettings.detailProperty.action.edit.label" bundle="${system_Messages}"/></span></a>
    <script type="text/javascript">
//<![CDATA[

        Ext.onReady(function() {
             attachOn('${prefix}edit_property','click',function() {
                 ${openDialogFunction}('<c:out value="${propertyId}"/>');           
             });
        })
    
//]]>
</script>
</c:if>

	
		
	



