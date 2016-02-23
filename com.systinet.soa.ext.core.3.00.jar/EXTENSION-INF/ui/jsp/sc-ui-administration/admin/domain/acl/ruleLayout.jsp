<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />
<fmt:message key="ruleLayout.button.save.label" var="saveLabel" bundle="${domain_Messages}" />
<fmt:message key="ruleLayout.button.cancel.label" var="cancelLabel" bundle="${domain_Messages}" />
<fmt:message key="ruleLayout.header.${modea}.${ruleType}.label" var="headerLabel" bundle="${domain_Messages}" />

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${headerLabel}" />
</syswf:component>
<c:if test="${not empty this.bean.artifactTypeAccessBean}">
<table class="UI Layout">
	<tbody>
		<tr>
			<td class="UI Middle">
				<syswf:block className="UI Block Common">
					<div class="Content">
					<table class="UI Table Properties">
						<col class="MidLabelCol">
						<col>
						<c:if test ="${modea eq 'create'}">
							<c:if test ="${ruleType eq 'Create'}">
								<syswf:component name="/admin/domain/acl/createCreateRule" prefix="createCreateRule">
									<syswf:param name="bean" value="${this.bean}" />
								</syswf:component>
							</c:if>
							<c:if test ="${ruleType eq 'Access'}">
								<syswf:component name="/admin/domain/acl/createAccessRule" prefix="createAccessRule">
									<syswf:param name="bean" value="${this.bean}" />
								</syswf:component>
								
							</c:if>	
						</c:if>
						
						<c:if test ="${modea eq 'edit'}">
							<c:if test ="${ruleType eq 'Create'}">
								<syswf:component name="/admin/domain/acl/editCreateRule" prefix="editCreateRule">
									<syswf:param name="bean" value="${this.bean}" />
								</syswf:component>
							</c:if>
							<c:if test ="${ruleType eq 'Access'}">
								<syswf:component name="/admin/domain/acl/editAccessRule" prefix="editAccessRule">
									<syswf:param name="bean" value="${this.bean}" />
								</syswf:component>
							</c:if>	
						</c:if>
						<tr>
							<td>
								<label>
									<fmt:message key="ruleLayout.grantedto.label" bundle="${domain_Messages}" />
								</label>
							</td>
							<td>
								<syswf:component name="/admin/domain/acl/addMembersRule" prefix="addMembersRule">
									<syswf:param name="bean" value="${this.bean}" />
									<syswf:param name="domainId" value="${domainId}" />									
									<syswf:param name="ruleType" value="${ruleType}" />
								</syswf:component>
							</td>
						</tr>
						<c:if test ="${ruleType eq 'Access'}">
						<tr>
							<td>
								<label>
									<fmt:message key="ruleLayout.condition.label" bundle="${domain_Messages}" />
								</label>
							</td>
							<td>
								<syswf:component name="/admin/domain/acl/addConditionsRule" prefix="addConditionsRule">
									<syswf:param name="bean" value="${this.bean}" />
								</syswf:component>
							</td>
						</tr>		
						<tr>
							<td>
								<label>
									<fmt:message key="ruleLayout.apply.label" bundle="${domain_Messages}" />
								</label>
							</td>
							<td>
								<syswf:selectOne id="${prefix}_applyToExistingArtifacts" name="applyToExistingArtifacts" 
									value="${this.bean}" property="applytoExistingArtifacts" mode="checkbox" optionValues="true"
									optionCaptions=" " dataType="boolean"> 
									<syswf:attribute name="class" value="UI Form Checkbox" />
								</syswf:selectOne>
							</td>
						</tr>			
						</c:if>			
					</table>
					</div>
				</syswf:block>				
				<syswf:block className="UI Block Green">
				    <div class="Content">
				        <div class="UI Form Controls">
		     				<c:if test ="${ruleType eq 'Access'}">
		     					<c:set var="safeLimit" value="200" />
		     					<fmt:message key="defaultAcl.applyExistingArtifactWarning" var="warningMsg" bundle="${domain_Messages}" >
									<fmt:param value="${safeLimit}" />
								</fmt:message>
		     				
								<syswf:component name="/core/impl/util/dialog" prefix="dialog">
								   <syswf:param name="handler" value="${prefix}save" />
								   <syswf:param name="heading">Warning</syswf:param>
								   <syswf:param name="content">${warningMsg}</syswf:param>
								   <syswf:param name="noUndo" value="false"/>
								   <syswf:param name="actionCaption" value="Yes"/>
								   <syswf:param name="cancelCaption" value="No"/>
								   <syswf:param name="controlName" value="warningDialog" />
								</syswf:component>
								
								<syswf:control mode="script" action="save" caption="${prefix}save" >
								</syswf:control>		
													<a href="javascript:void(0);" class="btn btn-primary" id="${prefix}_saveButton">
								<span><span><span><syswf:out value="${saveLabel}" context="HtmlBody"/></span></span></span>		
								</a>	
								<script type="text/javascript">
								//<![CDATA[

									    Ext.onReady(function() {
									    	var artifactCount=${this.bean.artifactCount};
									    	var applyCheck = Ext.get('${prefix}_applyToExistingArtifacts_0');
									    	var saveButton = Ext.get('${prefix}_saveButton');
									    	if (applyCheck.dom.checked && artifactCount > ${safeLimit}){
									    		saveButton.on('click',warningDialog);
											}else{
												saveButton.on('click',${prefix}save);							
											}
									    	applyCheck.on('click',function(){
									    			if (this.dom.checked && artifactCount > ${safeLimit}){
									    				saveButton.un('click',${prefix}save);
									    				saveButton.on('click',warningDialog);
									    			}else{
									    				saveButton.un('click',warningDialog);
									    				saveButton.on('click',${prefix}save);			
									    			}
									    			
									           });		
									        
									    });
									
								//]]>
								</script>	
					   		 </c:if>
				   		 	<c:if test ="${ruleType eq 'Create'}">
					            <syswf:control mode="postAnchor" action="save" caption="${saveLabel}">
					                <syswf:attribute name="class" value="btn btn-primary" />
					            </syswf:control>
					            </c:if>
				            <c:if test ="${modea eq 'edit'}">
					            <syswf:control mode="postAnchor" action="cancel" caption="${cancelLabel}" targetDepth="${sessionStack.currentDepth-1}">
					                <syswf:attribute name="class" value="btn btn-gray" />
					            </syswf:control>
				            </c:if>
				            <c:if test ="${modea eq 'create'}">
					            <syswf:control mode="postAnchor" action="cancel" caption="${cancelLabel}" targetDepth="${sessionStack.currentDepth-1}">
					                <syswf:attribute name="class" value="btn btn-gray" />
					            </syswf:control>
				            </c:if>
				        </div>
				    </div>
				</syswf:block>
			</td>
		</tr>
	</tbody>
</table>
</c:if>
<c:if test="${empty this.bean.artifactTypeAccessBean}">
<table class="UI Layout">
	<tbody>
		<tr>
			<td class="UI Middle">
				<syswf:block className="UI Block Common">
					<div class="Content">
						<fmt:message key="ruleLayout.emptyPage" bundle="${domain_Messages}" />
					</div>
				</syswf:block>
			</td>
		</tr>
	</tbody>
</table>
</c:if>