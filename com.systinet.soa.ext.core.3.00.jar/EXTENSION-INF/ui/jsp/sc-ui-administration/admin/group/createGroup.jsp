<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.group.GroupMessages"
	var="groups_Messages" />
<fmt:message var="subtitle" key="createGroup.subtitle" bundle="${groups_Messages}" />
<fmt:message var="title" key="createGroup.title" bundle="${groups_Messages}" />
<fmt:message var="memberCaption" key="createGroup.memberCaption" bundle="${groups_Messages}" />
<fmt:message var="saveCaption" key="createGroup.saveCaption" bundle="${groups_Messages}" />
<fmt:message var="saveHint" key="createGroup.saveHint" bundle="${groups_Messages}" />
<fmt:message var="cancelCaption" key="createGroup.cancelCaption" bundle="${groups_Messages}" />
<fmt:message var="cancelHint" key="createGroup.cancelHint" bundle="${groups_Messages}" />
<fmt:message var="requiredCaption" key="required" bundle="${groups_Messages}" />
<fmt:message var="requiredTitle" key="required.title" bundle="${groups_Messages}" />

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${title}" />
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
							<th>
							    <label class="UI Label Required Full">
							         <fmt:message key="createGroup.name" bundle="${groups_Messages}"/>:
							    </label>
							    <sup class="Required" title="${requiredTitle}">${requiredCaption}</sup>
							</th>
							<td >
								<syswf:input id ="${prefix}_nameId" name="name" value="${groupInfo}" property="name">
								    <c:choose>
                                        <c:when test="${not nameError}">
                                            <syswf:attribute name="class">x-form-text UI Input x-form-field x-form-focus</syswf:attribute>
                                        </c:when>
                                        <c:otherwise>
                                            <syswf:attribute name="class">x-form-text UI Input x-form-invalid</syswf:attribute>
                                        </c:otherwise>
                                    </c:choose>
								</syswf:input>
								<c:if test="${nameError}">
                                    <em class="x-form-invalid-msg UI Invalid">
                                        <span><syswf:out value="${nameErrorMessage}" context="HtmlBody"/></span>
                                    </em>
                                </c:if>
                                <script type="text/javascript">
                                //<![CDATA[

                                    Ext.onReady(function() {
                                        new Ext.HP.Input({
                                            applyTo : '<c:out value="${prefix}_nameId" />'
                                        });
                                    });
                                
                                //]]>
                                </script>
							</td>
						</tr>
						<tr>
							<th ><label class="UI Label Inline"><fmt:message key="createGroup.description" bundle="${groups_Messages}" />:</label></th>
							<td>
								<syswf:textArea id="${prefix}_richTextAreaWidget" name="description" value="${groupInfo}" property="description">
								</syswf:textArea>
								<syswf:component name="/core/impl/edit/richTextEditor" prefix="${prefix}_richText" wrap="false">
                                        <syswf:param name="textAreaId" value="${prefix}_richTextAreaWidget"/>
                                </syswf:component> 
							</td>
						</tr>
					</table>
					</div>
						
				</syswf:block>
				<div class="Content">    
					<syswf:component name="/admin/group/addMember" prefix="addMemberGroup">
						<syswf:param name="mode" value="create"></syswf:param>
						<syswf:param name="groupInfo" value="${groupInfo}"></syswf:param>
					</syswf:component>            	    
				</div>	
				<syswf:block className="UI Block Green">
					<div class="UI Form Controls">
						<syswf:control mode="button" caption="${saveCaption}" hint="${saveHint}" action="create" >
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
