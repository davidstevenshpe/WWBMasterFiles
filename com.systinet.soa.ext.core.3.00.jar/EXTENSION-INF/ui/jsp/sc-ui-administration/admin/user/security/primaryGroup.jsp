<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages"var="viewProfile_Messages" />
<fmt:message var="primaryGroupDialogTitle" key="viewProfile.default_security.primary_group.pop_up.title" bundle="${viewProfile_Messages}" />
<fmt:message var="primaryGroupChangeLink" key="viewProfile.default_security.primary_group.change_link" bundle="${viewProfile_Messages}" />
<fmt:message var="primaryGroupRemoveLink" key="viewProfile.default_security.primary_group.remove_link" bundle="${viewProfile_Messages}" />
<fmt:message var="primaryGroupRemoveHeading" key="viewProfile.default_security.primary_group.remove_heading" bundle="${viewProfile_Messages}" />
<fmt:message var="primaryGroupRemoveConfirmMsg" key="viewProfile.default_security.primary_group.remove_confirm_msg" bundle="${viewProfile_Messages}" />

<fmt:message var="buttonSet" key="setNewArtifactsOwnership.button_set" bundle="${viewProfile_Messages}" />
<fmt:message var="buttonCancel" key="setNewArtifactsOwnership.button_cancel" bundle="${viewProfile_Messages}" />

<c:if test="${not empty primaryOwner}">    
	<span class="IconAlign">
    <syswf:component name="/core/impl/util/principalLinkRenderer" prefix="principalLink" wrap="false">
        <syswf:param name="principal" value="${primaryOwner}" />
    </syswf:component>
    </span>
</c:if>
<c:if test="${not isReadOnly}">
    <c:if test="${not empty primaryOwner}">
        <a href="javascript:void(0);" class="UI Icon Delete" id="${prefix}_removeOwnership">${primaryGroupRemoveLink}</a>
		<a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}_changePrimaryGroup">${primaryGroupChangeLink}</a>
		<syswf:control mode="script" caption="${prefix}removeOwnership" action="removeOwnership">
		    <syswf:param name="artifact">${artifact}</syswf:param>
		</syswf:control>
		
		<syswf:component name="/core/impl/util/dialog" prefix="dialog">
		    <syswf:param name="handler" value="${prefix}removeOwnership" />
		    <syswf:param name="heading">${primaryGroupRemoveHeading}</syswf:param>
		    <syswf:param name="content">${primaryGroupRemoveConfirmMsg}</syswf:param>
		</syswf:component>
		<script type="text/javascript">
//<![CDATA[

		    Ext.onReady(function(){
		        attachOn('${prefix}_removeOwnership','click',function() {
		            ${prefix}_dialog_control();
		        });
		    });
		
//]]>
</script>
    </c:if>
    <c:if test="${empty primaryOwner}">
    <a href="javascript:void(0);" class="UI Icon Edit" id="${prefix}_changePrimaryGroup">${primaryGroupChangeLink}</a>
    </c:if>
	<syswf:control mode="script" caption="${prefix}changeOwnership" action="changeOwnership"/>
	<syswf:component name="/core/window" prefix="ownershipWindow">
	    <syswf:param name="winTitle" value="${primaryGroupDialogTitle}" />
	    <syswf:param name="winComponent" value="/admin/common/newArtifactsOwnerByWindow" />
	    <syswf:param name="winOpenFunctionName" value="${prefix}openPrincipalSelector" />
	    <syswf:param name="winOkLabel" value="${buttonSet}" />
	    <syswf:param name="winOkAction" value="${prefix}changeOwnership" />
	    <syswf:param name="winButtonAlign" value="center" />
	    <syswf:param name="winRenderAlways" value="true" />
	    <syswf:param name="holder" value="${holder}"/>   
	    <syswf:param name="groupsDS" value="${groupsDS}"/>
	    <syswf:param name="rolesDS" value="${rolesDS}"/>
	    <syswf:param name="winOnRenderCallback" value="${prefix}openSelector" />
	</syswf:component>
    <script type="text/javascript">
//<![CDATA[

    Ext.onReady(function(){
        attachOn('${prefix}_changePrimaryGroup','click',function() {
            ${prefix}openPrincipalSelector();
        });
    });

    
//]]>
</script>
</c:if>