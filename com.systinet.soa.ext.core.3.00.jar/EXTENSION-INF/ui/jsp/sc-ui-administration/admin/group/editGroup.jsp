<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.group.GroupMessages"
	var="groups_Messages" />
	
<fmt:message var="subtitle" key="editGroup.subtitle" bundle="${groups_Messages}" />
<fmt:message var="memberCaption" key="editGroup.memberCaption" bundle="${groups_Messages}" />
<fmt:message var="saveCaption" key="editGroup.saveCaption" bundle="${groups_Messages}" />
<fmt:message var="saveHint" key="editGroup.saveHint" bundle="${groups_Messages}" />
<fmt:message var="cancelCaption" key="editGroup.cancelCaption" bundle="${groups_Messages}" />
<fmt:message var="cancelHint" key="editGroup.cancelHint" bundle="${groups_Messages}" />

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${groupInfo.name}" />
    <syswf:param name="subtitle" value="${subtitle}" />
    <syswf:param name="iconFormat" value="small" />
</syswf:component>
				
<table class="UI Layout">
	<tbody>
		<tr>
			<td class="UI Middle">
				<syswf:block className="UI Block Common">
					<div class="Content">
						<table class="UI Table Properties">
						    <col class="LabelCol" />
                            <col/>
							<tr>
								<th ><label class="UI Label Inline"><fmt:message key="editGroup.name" bundle="${groups_Messages}" />:</label></th>
								<td>
								    <span class="IconAlign"><c:out value="${groupInfo.name}" /></span>								
								</td>
							</tr>
							<tr >
								<th ><label class="UI Label Inline"><fmt:message key="editGroup.description" bundle="${groups_Messages}" />:</label></th>
								<td>
									<syswf:textArea id="${prefix}_richTextAreaWidget" name="description" value="${groupInfo}" property="description">
									</syswf:textArea>
									<syswf:component name="/core/impl/edit/richTextEditor" prefix="${prefix}_richText" wrap="false">
                                        <syswf:param name="textAreaId" value="${prefix}_richTextAreaWidget"/>
                                    </syswf:component>  
								</td>
							</tr>
							<tr>
	                            <th><label class="UI Label Inline"><fmt:message key="editGroup.external_group" bundle="${groups_Messages}" />:</label></th>
	                            <c:choose>
	                                <c:when test="${groupInfo.external}" >
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
				
				<div class="Content">    
					<syswf:component name="/admin/group/addMember" prefix="addMemberGroup">
						<syswf:param name="mode" value="edit"></syswf:param>
						<syswf:param name="groupInfo" value="${groupInfo}"></syswf:param>
					</syswf:component>            	    
				</div>	
				<syswf:block className="UI Block Green">
					<div class="UI Form Controls">
						<syswf:control mode="button" caption="${saveCaption}" hint="${saveHint}" action="commit" targetDepth="${sessionStack.currentDepth-1}">
							<syswf:attribute name="class" value="btn btn-primary" />
						</syswf:control> 
						<syswf:control mode="button" caption="${cancelCaption}" hint="${cancelHint}" action="rollback" targetDepth="${sessionStack.currentDepth-1}">
							<syswf:attribute name="class" value="btn btn-gray" />
						</syswf:control>
					</div>
				</syswf:block>			
			</td>
		</tr>
	</tbody>
</table>