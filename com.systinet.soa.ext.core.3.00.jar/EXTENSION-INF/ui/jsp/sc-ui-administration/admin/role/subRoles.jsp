<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage" var="roleMsg" />

<table class="UI Table Properties" width="100%">
	<col class="LabelCol" />
    <col/>
	<tr>
		<th>
			<label class="UI Label Inline"><c:choose>
       			<c:when test="${roleHolder.roleType == 'SYSTEM'}">
					<fmt:message key="role.subRoles.system" bundle="${roleMsg}" />:
				</c:when>
				<c:when test="${roleHolder.roleType == 'NONSYSTEM'}">
					<fmt:message key="role.subRoles.nonsystem" bundle="${roleMsg}" />:
				</c:when>
				<c:when test="${empty roleHolder.roleType}">
					<fmt:message key="role.subRoles.nonsystem" bundle="${roleMsg}" />:
				</c:when>
			</c:choose></label>
		</th>
		<td>
			<c:if test="${not empty subRolesDataSource}">
				<syswf:component name="/core/table" prefix="${prefix}_subRoles" wrap="true">
					<syswf:param name="customizationId" value="admin.role.subRolesTable" />
					<syswf:param name="datasource" value="${subRolesDataSource}" />
					<syswf:param name="subRolesHolder" value="${subRolesHolder}" />
			    	<syswf:param name="roleHolder" value="${roleHolder}"/>
				</syswf:component>
			</c:if>
		</td>
	</tr>
	<tr>
		<th>
			<label class="UI Label Inline">
				<fmt:message key="uirole.browse.Title" bundle="${roleMsg}" />:
			</label>
		</th>
		<td>
			<syswf:component name="/core/table" prefix="${prefix}_assignedUIRoles" wrap="true">
				<syswf:param name="customizationId" value="admin.uirole.assignUIRolesTable" />
				<syswf:param name="datasource" value="${selectUIRolesDataSource}" />
				<syswf:param name="selectUIRolesHolder" value="${selectUIRolesHolder}" />
		    	<syswf:param name="roleHolder" value="${roleHolder}"/>
			</syswf:component>
		</td>
	</tr>
	<tr>
	    <th><label class="UI Label Inline"><fmt:message key="role.uiAccessGranted" bundle="${roleMsg}" />:</label></th>
	    <td>
	    	<span class="IconAlign">
	        <c:choose>
	            <c:when test="${not empty accessTabList}">
                    <c:out value="${accessTabList}"/><br/>
	            </c:when>
	            <c:otherwise>
	                <fmt:message key="role.noAccess" bundle="${roleMsg}" />
	            </c:otherwise>
	        </c:choose>
	        </span>
	    </td>
	</tr>

	<c:if test="${roleHolder.roleType == 'NONSYSTEM'}">
		<tr>
			<td><label class="UI Label Inline"><fmt:message key="role.label.allowsLogin" bundle="${roleMsg}" />:</label></td>
			<td>
           		<syswf:selectOne name="allowsLogin" value="${roleHolder}" property="allowLogin" optionValues="true" optionCaptions=" " mode="checkbox" dataType="boolean">
					<c:if test="${inheritedAllowLogin}">
					<syswf:attribute name="disabled">disabled</syswf:attribute>
					<syswf:attribute name="checked">checked</syswf:attribute>
					</c:if>
					<syswf:attribute name="class" value="UI Form Checkbox" />
				</syswf:selectOne>
       		</td>
       	</tr>
   	</c:if>

</table>
