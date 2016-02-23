<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="user_Messages" />

<div>
	<label class="UI Label Inline"><fmt:message key="editUsers.ownership" bundle="${user_Messages}"/></label>
    
    <c:choose>
        <c:when test="${empty holder.selectedPrincipal}">
            <span class="Comment"><fmt:message key="viewProfile.default_security.primary_group.empty_new_artifact_ownership" bundle="${user_Messages}"/></span> 
        </c:when>
        <c:otherwise>
            <c:choose>
				<c:when test="${principalType eq 'ROLE'}"> 
        			<span class="UI Icon Role"><syswf:out value="${holder.selectedPrincipal.name}" context="HtmlBody"/></span>
        		</c:when>
        		<c:otherwise>
        			<span class="UI Icon OrganizationUnit"><syswf:out value="${holder.selectedPrincipal.name}" context="HtmlBody"/></span>
        		</c:otherwise>
        	</c:choose>
        </c:otherwise>
    </c:choose>
    <a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}select_ownership"><span><fmt:message key="editUsers.change" bundle="${user_Messages}"/></span></a>
</div>

<syswf:control mode="script" caption="${prefix}saveState" action="saveState" />

<fmt:message key="editUsers.selectOwnership_title" bundle="${user_Messages}" var="select_title"/>
<syswf:component name="/core/principal/selector" prefix="ownerByPricipalSelector">
    <syswf:param name="jsOpenFunction" value="${prefix}open" />
    <syswf:param name="windowTitle" value="${select_title}"/>
    <syswf:param name="holder" value="${holder}" />
    <syswf:param name="disableUsersTab" value="true" />
    <syswf:param name="rolesDataSource" value="${rolesDS}" />
    <syswf:param name="groupsDataSource" value="${groupsDS}" />
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
