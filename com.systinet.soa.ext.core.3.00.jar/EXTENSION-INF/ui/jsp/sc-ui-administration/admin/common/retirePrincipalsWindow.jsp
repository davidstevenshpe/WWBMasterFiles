<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="user_Messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.group.GroupMessages" var="group_Messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage"	var="role_Messages" />

<div>
	<p class="Warning">
		<c:choose>
			<c:when test="${oldPrincipalType eq 'USER'}">
				<fmt:message key="listUsers.bulk.retire.window.description" bundle="${user_Messages}"/></p><br/>
			</c:when>
			<c:when test="${oldPrincipalType eq 'GROUP'}">
				<fmt:message key="listGroups.bulk.retire.window.description" bundle="${group_Messages}"/></p><br/>
			</c:when>
			<c:when test="${oldPrincipalType eq 'ROLE'}">
				<fmt:message key="listRoles.bulk.delete.window.description" bundle="${role_Messages}"/></p><br/>
			</c:when>
		</c:choose>
	<table class="UI Table Properties">
		<col width="110px"/>
	    <col/>
		<tr>
			<td><label class="UI Label Inline" style="padding-right:0;">
				<c:choose>
					<c:when test="${oldPrincipalType eq 'USER'}">
						<fmt:message key="listUsers.bulk.retire.window.listUsers" bundle="${user_Messages}"/>
					</c:when>
					<c:when test="${oldPrincipalType eq 'GROUP'}">
						<fmt:message key="listGroups.bulk.retire.window.listGroups" bundle="${group_Messages}"/>
					</c:when>
					<c:when test="${oldPrincipalType eq 'ROLE'}">
						<fmt:message key="listRoles.bulk.delete.window.listRoles" bundle="${role_Messages}"/>
					
					</c:when>
				</c:choose>
			</label></td>
			<td><c:choose><c:when test="${oldPrincipalType eq 'USER'}">
						<span class="UI Icon Contact"></span>
					</c:when>
					<c:when test="${oldPrincipalType eq 'GROUP'}">
						<span class="UI Icon OrganizationUnit"></span>
					</c:when>
					<c:when test="${oldPrincipalType eq 'ROLE'}">
						<span class="UI Icon Role"></span>
					</c:when>
			</c:choose>
				<c:forEach items="${selectedPrincipals}" var="principal" varStatus="status">
	                <c:choose>
	                    <c:when test="${status.last}">
	                        <c:out value="${principal}"/>
	                    </c:when>
	                    <c:otherwise>
	                        <c:out value="${principal},"/>
	                    </c:otherwise>
	                </c:choose>
	            </c:forEach>
			</td>
		</tr>
		<tr>
			<td><label class="UI Label Inline"><fmt:message key="listUsers.bulk.retire.window.newOwner" bundle="${user_Messages}"/></label></td>
			<c:choose>
        		<c:when test="${empty holder.selectedPrincipal}">
        			<td><span class="Comment">not changed</span><a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}select_ownership"><span><fmt:message key="listUsers.bulk.retire.window.changelink.title" bundle="${user_Messages}"/></span></a></td>
        		</c:when>
        		<c:otherwise>
        			<c:choose>
        				<c:when test="${principalType eq 'ROLE'}"> 
        					<td><span class="UI Icon Role"><syswf:out context="HtmlBody" value="${holder.selectedPrincipal.name}"/></span><a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}select_ownership"><span><fmt:message key="listUsers.bulk.retire.window.changelink.title" bundle="${user_Messages}"/></span></a></td>
        				</c:when>
        				<c:when test="${principalType eq 'USER'}"> 
        					<td><span class="UI Icon Contact"><syswf:out context="HtmlBody" value="${holder.selectedPrincipal.name}"/></span><a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}select_ownership"><span><fmt:message key="listUsers.bulk.retire.window.changelink.title" bundle="${user_Messages}"/></span></a></td>
        				</c:when>
        				<c:otherwise>
        					<td><span class="UI Icon OrganizationUnit"><syswf:out context="HtmlBody" value="${holder.selectedPrincipal.name}"/></span><a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}select_ownership"><span><fmt:message key="listUsers.bulk.retire.window.changelink.title" bundle="${user_Messages}"/></span></a></td>
        				</c:otherwise>
        			</c:choose>
        		</c:otherwise>
       		</c:choose>
			
		</tr>
	</table>
</div>

<syswf:control mode="script" caption="${prefix}saveState" action="saveState" />

<fmt:message key="listUsers.bulk.retire.window.setNewOwnership.title" bundle="${user_Messages}" var="select_title"/>
<syswf:component name="/core/principal/selector" prefix="ownerByPricipalSelector">
    <syswf:param name="jsOpenFunction" value="${prefix}open" />
    <syswf:param name="windowTitle" value="${select_title}"/>
    <syswf:param name="holder" value="${holder}" />
    <syswf:param name="selectionBag" value="${selectionBag}" />
    <syswf:param name="winOnRenderCallback" value="${null}" passNull="true"/>
</syswf:component>

<script type="text/javascript">
//<![CDATA[
 
Ext.onReady(function(){
    attachOn('${prefix}select_ownership','click',function() {
        ${prefix}open();
        ${prefix}saveState();
    });
    
});
<c:if test="${not empty winOnRenderCallback}">
function ${winOnRenderCallback}() {
    ${prefix}open();
}
</c:if>

//]]>
</script>
