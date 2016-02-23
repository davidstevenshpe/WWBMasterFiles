<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.user.UserMessages" var="viewProfile_Messages" />
<fmt:message var="roleByDomainCaption" key="viewProfile.role_by_domain.caption" bundle="${viewProfile_Messages}" />
<fmt:message var ="winTitle" key="viewProfile.selectRole.caption" bundle="${viewProfile_Messages}" />
<fmt:message var="noLoginName" key="viewProfile.role_by_domain.noLoginName" bundle="${viewProfile_Messages}" />
<syswf:block className="UI Block Common">

<syswf:component name="/admin/common/domainRolesSelector" prefix="domainRolesSelector">
    <syswf:param name="openDialogFunction" value="${prefix}openDomainRolesSelector"/>
    <syswf:param name="principal" value="${principal}"/>
    <syswf:param name="affectOnComponent" value="${affectOnComponent}"/>
</syswf:component>

<div class="Title">
    <h3><syswf:out value="${roleByDomainCaption}" context="HtmlBody"/></h3>
</div>
<div class="Content">
	<table>
        <c:if test="${empty principal.principalName}">
            <c:out value="${noLoginName}"/>
        </c:if>
	    <c:forEach items="${domainRoles}" var="domainRole" varStatus="status">
          <tr>
              <th class="media-middle"><label class="UI Label Inline"><syswf:out value="${domainRole.domain.name}" context="HtmlBody"/>:</label></th>
              <td>
                     <c:choose>
                         <c:when test="${empty domainRole.roles}">
                             <span class="Comment"><c:out value="empty"/></span>
                         </c:when>
                         <c:otherwise>
                             <span class="IconAlign">
                          <c:forEach items="${domainRole.roles}" var="role" varStatus="roleStatus">
                          	<c:choose>
                          		<c:when test="${roleStatus.last}">
                          			<syswf:control id="myLink${status.index}${roleStatus.index}" mode="anchor" caption="${role.name}" targetTask="/common/role/view">
										<syswf:param name="RoleId" value="${role.roleId}" />
								        <syswf:param name="RoleName" value="${role.name}" />
									</syswf:control>
                          		</c:when>
                          		<c:otherwise>
                          			<syswf:control id="myLink${status.index}${roleStatus.index}" mode="anchor" caption="${role.name}" targetTask="/common/role/view">
										<syswf:param name="RoleId" value="${role.roleId}" />
								        <syswf:param name="RoleName" value="${role.name}" />
									</syswf:control>,
                          		</c:otherwise>
                          	</c:choose>
                          </c:forEach>
                          </span>
                         </c:otherwise>
                     </c:choose>
                     <c:if test="${domainRole.userRoleManager and not readOnly}">
                         <a href ="javascript:void(0);" class="UI Icon Edit" id="selectRoles_${domainRole.domain.domainId}"><fmt:message key="viewProfile.selectRole.change_link" bundle="${viewProfile_Messages}" /></a>
		                 <script type="text/javascript">
		                 //<![CDATA[

					        Ext.onReady(function(){
					        	 attachOn('selectRoles_${domainRole.domain.domainId}','click',function() {
					        		 ${prefix}openDomainRolesSelector('${domainRole.domain.domainId}');
					        	 });
					        })
					     
		                 //]]>
		                 </script>
                     </c:if>
                 </td>
          </tr>
   		</c:forEach>
	</table>
</div>
</syswf:block>