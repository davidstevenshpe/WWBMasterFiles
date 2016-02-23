<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.group.GroupMessages"
	var="groups_Messages" />
<fmt:message key="viewGroup.artifactType" var="artifactType" bundle="${groups_Messages}" />

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${group.name}" />
    <syswf:param name="subtitle" value="${artifactType}" />
	<c:choose>
		<c:when test="${groupStatus eq 'retiredGroup'}">
			 <syswf:param name="subtitleClass" value="UI Icon OrganizationUnit Retired" />
		</c:when>
		<c:otherwise>
			 <syswf:param name="subtitleClass" value="UI Icon OrganizationUnit" />
		</c:otherwise>
	</c:choose>
    <syswf:param name="iconFormat" value="small" />
</syswf:component>
				
<table class="UI Layout">
	<tbody>
		<tr>
			<td class="UI Middle">
				<syswf:component name="/core/layout/contextActions" prefix="groupContextActions">
                    <syswf:param name="customizationId" value="admin.group.groupActions" />
                    <syswf:param name="title" value="Groups"/>
                    <syswf:param name="group" value="${group}"/>
                </syswf:component>
                
				<div class="UI Text Description"><c:out value="${group.description}" escapeXml="false"/></div>
												
				<syswf:block className="UI Block Common">
					<div class="Content">
					<table class="UI Table Properties">
					    <col class="LabelCol"/>
					    <col/>
						<tr>
							<th ><label class="UI Label Inline"><fmt:message key="editGroup.external_group" bundle="${groups_Messages}" />:</label></th>
							<c:choose>
								<c:when test="${group.external}" >
									<td><span class="IconAlign">Yes</span></td>	
								</c:when>
								<c:otherwise >
									<td><span class="IconAlign">No</span></td>
								</c:otherwise>
							</c:choose>
						</tr>
					</table>
					</div>
						
				</syswf:block>
				                                
                <syswf:component name="/admin/common/domainRoles" prefix="domainRoles">
				        <syswf:param name="principal" value="${principalGroup}"/>
				        <syswf:param name="affectOnComponent" value="${prefix}_domainRoles"/>
                </syswf:component>
					
				<syswf:component name="/core/table" prefix="groupMembersView" wrap="false">
				    <syswf:param name="customizationId" value="admin.group.groupDetailViewTable" />
				    <syswf:param name="title" value="Members"/>
				    <syswf:param name="wrapCaption" value="Members"/>
				    <syswf:param name="group" value="${group}"/>
				    <syswf:param name="kind" value="browse" />
				</syswf:component>					 
				                                     
								
			</td>
		</tr>
	</tbody>
</table>
