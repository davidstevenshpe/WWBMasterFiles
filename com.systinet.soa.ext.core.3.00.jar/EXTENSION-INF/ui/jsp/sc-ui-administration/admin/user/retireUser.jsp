<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="userMessages" />
<fmt:message key="retire.user.action.Title" bundle="${userMessages}" var="title"/>


<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="users_Messages" />
<c:choose>
	<c:when test="${ contextMenu == true}">
		<div class="EA-left-panel">
			<a href="javascript:void(0);" class="UI PageAction RetireGroup" id="${prefix}_retireUserLink" title="${title}">
				<span>${title}</span>
			</a>
		</div>
	</c:when>
	<c:otherwise>
		<a href="javascript:void(0);" class="context-button RetireGroup" id="${prefix}_retireUserLink" title="${title}">
		</a>
	</c:otherwise>
</c:choose>

<c:set var="controlName" value="retireUserProfile" />
<syswf:component name="/admin/user/bulk/retirePrincipals" prefix="retireSingle">
	<syswf:param name="singlePrincipal" value="${uuid}" />
	<syswf:param name="controlName" value="${controlName}" />
</syswf:component>


<script type="text/javascript">
//<![CDATA[

    Ext.onReady(function() {
        attachOn('${prefix}_retireUserLink','click',${controlName});
    });

//]]>
</script>
