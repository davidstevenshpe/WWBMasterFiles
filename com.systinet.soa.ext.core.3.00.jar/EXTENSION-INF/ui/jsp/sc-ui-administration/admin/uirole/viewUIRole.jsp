<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.role.RoleMessage" var="roleMsg" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="title" value="${uirole.name}" />
    <syswf:param name="subtitle" value="UI Role" />
    <syswf:param name="iconFormat" value="small" />
    <syswf:param name="subtitleClass" value="UI Icon Role" />
</syswf:component>

<table class="UI Layout">
	<tbody>
		<tr>
			<td class="UI Middle">
				<c:set var="rolesStr" value="${uirole.rolesAsString}"/>
				<div class="UI Text Description"><fmt:message key="browse.Title" bundle="${roleMsg}" />: &nbsp; <c:out value="${rolesStr}" escapeXml="false" /></div>
                <!-- 
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
                </table>-->
				
				<syswf:block className="UI Block Common">
					<div class="Title">
						<h3>
							<span><fmt:message key="uirole.accessTitle" bundle="${roleMsg}" />
							</span>
						</h3>
					</div>
					<br/>
					<div>
						<c:choose>
							<c:when test="${not empty tabgrant}">
								<c:out value="${tabgrant}"></c:out>
							</c:when>
							<c:otherwise>
								<fmt:message key="role.noAccess" bundle="${roleMsg}" />									
							</c:otherwise>
						</c:choose>
					</div>
				</syswf:block>					
			</td>
            <td class="UI Right">
                <syswf:component name="/core/layout/contextActions" prefix="uiroleContextActions">
                    <syswf:param name="customizationId" value="admin.uirole.uiroleActions" />
                    <syswf:param name="title" value="UI Role Profiles"/>
                    <syswf:param name="UIRoleId" value="${uirole.id}"/>
                    <syswf:param name="UIRoleName" value="${uirole.name}"/>
                    <syswf:param name="roles" value="${uirole.roles}"/>
                </syswf:component>
            </td>
		</tr>
	</tbody>
</table>

