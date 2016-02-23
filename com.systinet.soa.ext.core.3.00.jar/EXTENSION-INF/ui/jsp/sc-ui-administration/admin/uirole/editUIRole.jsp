<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage" var="roleMsg" />
<fmt:message key="edit.save" var="save" bundle="${roleMsg}" />
<fmt:message key="edit.cancel" var="cancel" bundle="${roleMsg}" />				
<fmt:message key="edit.save.hint" var="savehint" bundle="${roleMsg}" />
<fmt:message key="edit.cancel.hint" var="cancelhint" bundle="${roleMsg}" />

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${uiroleLabel}" />
</syswf:component>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message key="widget.Required" bundle="${widgetMessages}" var="requiredCaption" />

<table class="UI Layout">
	<tbody>
		<tr>
			<td class="UI Middle">
				<syswf:block className="UI Block Common">
                    <table class="UI Table Properties">
                    	<col class="LabelCol" />
                        <col/>
                        <c:choose>
                            <c:when test="${uiroleHolder.systemRole}">
                                <tr>
                                    <th><label class="UI Label Inline"><fmt:message key="role.lable.name" bundle="${roleMsg}" />:</label></th>
                                    <td>
                                        <span class="IconAlign"><c:out value="${uiroleHolder.name}"/></span>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <th><label class="UI Label Required Full"><fmt:message key="role.lable.name" bundle="${roleMsg}" />:</label><sup class="required">${requiredCaption}</sup></th>
                                    <td >
                                        <syswf:input id="${prefix}_nameId"  name="name" value="${uiroleHolder}" property="name" mode="text" >
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
                            </c:otherwise>
                        </c:choose>
                    </table>
					<syswf:component name="/admin/uirole/selectTabs" prefix="${prefix}_selectTabs">
                 		<syswf:param name="uiroleHolder" value="${uiroleHolder}"/>
                 	</syswf:component>                  	
				</syswf:block>	
				<syswf:block className="UI Block Common">
					<div class="UI Form Controls">
						<syswf:control mode="button" caption="${save}" hint="${savehint}" action="update" targetDepth="${sessionStack.currentDepth-1}">
						    <syswf:param name="mode" value="edit"/>
							<syswf:attribute name="class" value="btn btn-primary" />
						</syswf:control> 
						<syswf:control mode="button" caption="${cancel}" hint="${cancelhint}"  action="rollback" targetDepth="${sessionStack.currentDepth-1}">
							<syswf:attribute name="class" value="btn btn-gray" />
						</syswf:control>
					</div>
				</syswf:block>
			</td>
		</tr>
	</tbody>
</table>
