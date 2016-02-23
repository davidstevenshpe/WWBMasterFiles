<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle	basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />
<fmt:message key="membersAssignment.button.editRoles" var="editRolesButton" bundle="${domain_Messages}" />

<a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}edit_roles"><span>${editRolesButton}</span></a>
<script type="text/javascript">
//<![CDATA[

Ext.onReady(function() {
     attachOn('${prefix}edit_roles','click',function() {
    	 storePrincipalName('${principalName}','${principalCategory}');
         ${openDialogFunction}();           
     });
})

//]]>
</script>
	
