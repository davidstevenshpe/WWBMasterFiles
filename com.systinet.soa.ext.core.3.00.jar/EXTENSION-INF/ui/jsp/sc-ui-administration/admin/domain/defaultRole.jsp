<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${componentVisible}">

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />
<fmt:message key="viewDomain.defaultroles.change.label" bundle="${domain_Messages}" var="changeLink"/>
<fmt:message key="viewDomain.defaultroles.selector.header" bundle="${domain_Messages}" var="selectorHeader"/>

<div id="${prefix}">
	<syswf:component name="/core/principal/selector" prefix="defaultRolesSelector">
	    <syswf:param name="jsOpenFunction" value="${prefix}openDefaultRolesSelector" />
	    <syswf:param name="windowTitle" value="${selectorHeader}"/>
	    <syswf:param name="holder" value="${changeDefaultRolesHolder}" />
	    <syswf:param name="selectionBag" value="${selectionBag}" />
		<syswf:param name="disableGroupsTab" value="true" />
		<syswf:param name="disableUsersTab" value="true" />
		<syswf:param name="domainId" value="${domainId}" />
	</syswf:component>		
	
	<syswf:block className="UI Block Common">
		<div class="Content">
			<div class="Title">
				<h3><span><fmt:message key="viewDomain.defaultroles.header" bundle="${domain_Messages}" /></span></h3>		
			</div>		
			<div class="UI SystemMessage Info">
			 	<div class="Offset">
					<fmt:message key="viewDomain.defaultroles.note" bundle="${domain_Messages}" />
				</div>
			</div>
			<div class="Offset">
				<table id="${prefix}_TableRoleLink">
					<tr>
						<td>
							<syswf:component prefix="roleLink" name="/core/impl/util/principalLinkRenderer">
								<syswf:param name="principal" value="${defaultRole}" />
							</syswf:component>
						</td>
						<td>
							<a href="javascript:void(0);" class="UI Icon" id="${prefix}changeDefaultRolesLink">(${changeLink})</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</syswf:block> 
</div>

<script type="text/javascript">
//<![CDATA[

	Ext.onReady(function(){
	    attachOn('${prefix}changeDefaultRolesLink','click',function() {
	    	${prefix}openDefaultRolesSelector();
	    });
	});

//]]>
</script>

</c:if>