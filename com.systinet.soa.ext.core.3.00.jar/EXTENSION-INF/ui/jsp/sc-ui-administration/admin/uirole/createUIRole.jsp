<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage" var="roleMsg" />

<fmt:message key="uirole.create.title" var="title" bundle="${roleMsg}" />
<fmt:message key="uirole.create.subtitle" var="subtitle" bundle="${roleMsg}" />
<fmt:message key="create.save" var="save" bundle="${roleMsg}" />
<fmt:message key="create.cancel" var="cancel" bundle="${roleMsg}" />				
<fmt:message key="uirole.create.save.hint" var="savehint" bundle="${roleMsg}" />
<fmt:message key="uirole.create.cancel.hint" var="cancelhint" bundle="${roleMsg}" />
<fmt:message var="requiredCaption" key="required" bundle="${roleMsg}" />
<fmt:message var="requiredTitle" key="required.title" bundle="${roleMsg}" />

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
					<table class="UI Table Properties">		
						<col class="LabelCol" />
                        <col/>
						<tr>
							<th><label class="UI Label Required Full"><fmt:message key="role.lable.name" bundle="${roleMsg}" />:</label><sup class="Required" title="${requiredTitle}">${requiredCaption}</sup></th>
							<td>
								<syswf:input id="${prefix}_nameId" name="name" value="${uiroleHolder}" property="name" mode="text" >
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
					</table>
                    <syswf:component name="/admin/uirole/selectTabs" prefix="${prefix}_selectTabs">
                 		<syswf:param name="uiroleHolder" value="${uiroleHolder}"/>
                 	</syswf:component>                 	
				</syswf:block>
				<syswf:block className="UI Block Green">
					<div class="UI Form Controls">
						<syswf:control mode="button" caption="${save}" hint="${savehint}" action="create" >
						    <syswf:param name="mode" value="create"/>
							<syswf:attribute name="class" value="btn btn-primary" />
						</syswf:control> 
						<syswf:control mode="button" caption="${cancel}" hint="${cancelhint}" action="rollback" targetDepth="${sessionStack.currentDepth-1}">
							<syswf:attribute name="class" value="btn btn-gray" />
						</syswf:control>
					</div>
				</syswf:block>
			</td>
		</tr>
	</tbody>
</table>