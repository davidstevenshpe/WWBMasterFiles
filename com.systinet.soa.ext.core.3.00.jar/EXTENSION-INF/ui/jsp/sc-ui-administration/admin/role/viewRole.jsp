<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage" var="roleMsg" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${role.name}" />
    <syswf:param name="subtitle" value="Role" />
    <syswf:param name="iconFormat" value="small" />
    <syswf:param name="subtitleClass" value="UI Icon Role" />
</syswf:component>

<table class="UI Layout">
	<tbody>
		<tr>
			<td class="UI Middle">
				<syswf:component name="/core/layout/contextActions" prefix="roleContextActions">
                    <syswf:param name="customizationId" value="admin.role.roleActions" />
                    <syswf:param name="title" value="Role Profiles"/>
                    <syswf:param name="RoleId" value="${role.roleId}"/>
                    <syswf:param name="RoleName" value="${role.name}"/>
					<syswf:param name="allowsLogin" value="${allowsLogin}"/>
                </syswf:component>
                
				<div class="UI Text Description"><c:out value="${role.description}" escapeXml="false" /></div>
                <table class="UI Table Properties">
                    <col class="LabelCol" />
                    <col/>
                    <tr>
                        <th><label class="UI Label Inline"><fmt:message key="role.label.allowsLogin" bundle="${roleMsg}" />:</label></th>
                        <td>
                        	<label class="UI Label Inline">
                            <c:choose>
                                <c:when test="${allowsLogin}">
                                    <span class="IconAlign"><fmt:message key="yes" bundle="${widgetMessages}"/></span>
                                </c:when>
                                <c:otherwise>
                                    <span class="IconAlign"><fmt:message key="no" bundle="${widgetMessages}"/></span>
                                </c:otherwise>
                            </c:choose>
                            </label>
                        </td>
                    </tr>
                    <c:if test="${not empty subRoles}">
                    <tr>
                        <th><label class="UI Label Inline"><fmt:message key="role.subRoles.nonsystem" bundle="${roleMsg}" />:</label></th>
                        <td>
                        	<label class="UI Label Inline">
                            	<span class="IconAlign"><c:out value="${subRoles}"/></span>
                            </label>
                        </td>
                    </tr>
                    </c:if>
                    
                </table>
				<c:if test="${visibleRole}">
					<syswf:block className="UI Block Common">
						<div class="Title">
							<h3>
								<span><fmt:message key="role.accessTitle" bundle="${roleMsg}" />
								</span>
							</h3>
						</div>
						<br/>
						<div>
							<fmt:message key="role.uirole.assign" bundle="${roleMsg}" />:&nbsp; <c:choose>
								<c:when test="${not empty uiroles}">
									<c:out value="${uiroles}"></c:out>
								</c:when>
								<c:otherwise>
									<fmt:message key="role.uirole.no.assign" bundle="${roleMsg}" />									
								</c:otherwise>
							</c:choose>
						</div><br />
						<div>
							<fmt:message key="uirole.accessTitle" bundle="${roleMsg}" />:&nbsp; <c:choose>
								<c:when test="${not empty tabgrant}">
									<c:out value="${tabgrant}"></c:out>
								</c:when>
								<c:otherwise>
									<fmt:message key="role.noAccess" bundle="${roleMsg}" />									
								</c:otherwise>
							</c:choose>
						</div>
					</syswf:block>					
				</c:if>
			</td>
		</tr>
	</tbody>
</table>

