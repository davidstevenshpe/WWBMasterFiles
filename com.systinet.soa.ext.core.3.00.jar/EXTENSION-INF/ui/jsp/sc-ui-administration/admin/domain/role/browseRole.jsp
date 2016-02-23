<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<syswf:localizedFileName fileName="${webResourcePath}/skin/jquery/ux/jquery.jcarousel.js" var="jsJcarousel"/>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" 
	var="domain_Messages" />

<fmt:message key="browseRole.users.label" var="users_Label" bundle="${domain_Messages}" />
<fmt:message key="browseRole.groups.label" var="groups_Label" bundle="${domain_Messages}" />

<script type="text/javascript" src="<c:out value="${jsJcarousel}"/>"></script>
<div class="ExpressionSelect High com_carousel">
<script type="text/javascript">
//<![CDATA[

	var selectedIndex = 0;

//]]>
</script>
<ul id="mycarousel" class="jcarousel">
<c:forEach items="${rolesSummary}" var="role" varStatus="status">
	<li style="height: 20px;">
	<c:choose>
		<c:when test="${role.roleId eq raHolder.currentRoleId}">
			<div class="ExpressionNode Active">
				<a href="javascript:void(0)" id="${prefix}_changeRoleLink_${role.roleId}"><span><syswf:out value="${role.name}" context="HtmlBody"/></span></a>
				<c:if test="${role.systemRole}"><span class="UI Icon SystemRole">&nbsp;</span></c:if>
				<span class="Comment"><syswf:out value="${role.comment}" context="HtmlBody"/></span>
			</div>
			<script type="text/javascript">
			//<![CDATA[

				selectedIndex = ${status.index};
			
			//]]>
			</script>
		</c:when>
		<c:otherwise>
			<div class="ExpressionNode">
				<a href="javascript:void(0)" id="${prefix}_changeRoleLink_${role.roleId}"><span><syswf:out value="${role.name}" context="HtmlBody"/></span></a>
				<c:if test="${role.systemRole}"><span class="UI Icon SystemRole">&nbsp;</span></c:if>				 
				<span class="Comment"><syswf:out value="${role.comment}" context="HtmlBody"/></span>							
			</div>
			<script type="text/javascript">
			//<![CDATA[

				Ext.onReady(function() {
				    attachOn('${prefix}_changeRoleLink_${role.roleId}','click', function() { 
					    ${prefix}_changeRole_${role.roleId}();		
					});
				});
			
			//]]>
			</script>
			<syswf:control mode="script" action="changeRole" caption="${prefix}_changeRole_${role.roleId}" id="${prefix}_changeRole_${role.roleId}">
				<syswf:param name="roleId" value="${role.roleId}" />
			</syswf:control>
		</c:otherwise>
	</c:choose>
	</li>
</c:forEach>
</ul>
<div class="carouselcontrols vertical">
     <a href="javascript:void(0)" class="carouselPrev" id="mycarousel-prev">
     	<span><fmt:message key="browseRole.viewrole.previous" bundle="${domain_Messages}" /></span>
     </a>
     <a href="javascript:void(0)" class="carouselNext" id="mycarousel-next">
     	<span><fmt:message key="browseRole.viewrole.next" bundle="${domain_Messages}" /></span>
     </a>
</div>
<script type="text/javascript">
//<![CDATA[

    /**
     * use the initCallback callback
     * to assign functionality to the controls
     */
    function mycarousel_initCallback(carousel) {
        jQuery('#mycarousel-next').bind('click', function() {
            carousel.next();
            return false;
        });

        jQuery('#mycarousel-prev').bind('click', function() {
            carousel.prev();
            return false;
        });
    }
    ;

    jQuery(document).ready(function() {
        jQuery('#mycarousel').jcarousel({
            //wrap:'both',
            scroll:5,
			start:selectedIndex,
            vertical: true,
            initCallback: mycarousel_initCallback,
            buttonNextHTML:null,
            buttonPrevHTML:null,
			itemFallbackDimension:20
        });
    });

//]]>
</script>
</div>