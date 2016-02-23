<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty globalSession['userName']}">       
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.util.uimessages" var="ui_Messages" />

<fmt:message key="Back" var="Back" bundle="${ui_Messages}"/>

<table class="UI Layout">
	<tbody>
		<tr>
			<td class="UI Middle">
				<div class="UI PageIdentity">
					<h1>
						<fmt:message key="web.noPermission_NoPermission" bundle="${ui_Messages}" />
					</h1>
				</div>
				<c:if test="${not empty noPermissionMessage}">
					<syswf:block className="UI SystemMessage Error">
						<div class="MessageContainer">
							<syswf:out context="Identity" value="${noPermissionMessage}"/>
						</div>
					</syswf:block> 
				</c:if>
			</td>
		</tr>
	</tbody>
</table>