<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.license.LicenseMessages" var="license_Messages"/>

<c:choose>
	<c:when test="${not hasAdminPermission}">
		<fmt:setBundle basename="com.hp.systinet.platform.rebranding" var="rebranding_Messages" />
		<fmt:message key="rebranding.productName" var="productName" bundle="${rebranding_Messages}" />
		<syswf:component name="/admin/common/noPermission" prefix="noPermission">
			<c:choose>
				<c:when test="${licenseInvalid}">
					<syswf:param name="noPermissionMessage">
						<fmt:message key="license_no_permission_invalid"
							bundle="${license_Messages}">
							<fmt:param value="${productName}" />
						</fmt:message>
					</syswf:param>
				</c:when>
				<c:otherwise>
					<syswf:param name="noPermissionMessage">
						<fmt:message key="license_no_permission"
							bundle="${license_Messages}" />
					</syswf:param>
				</c:otherwise>
			</c:choose>
		</syswf:component>
	</c:when>
	<c:otherwise>
		<syswf:component name="/core/layout/header" prefix="header"
			wrap="false">
			<syswf:param name="iconFormat" value="small" />
		</syswf:component>
		<table class="UI Layout">
			<tbody>
				<tr>
					<td class="UI Middle">	
						<syswf:block className="UI Block Common">
							<syswf:component name="/core/table" prefix="licensedUsersTable"
								wrap="true">
								<syswf:param name="customizationId"
									value="admin.config.license.tableLicensedUser" />
								<syswf:param name="datasource" value="${licensedUsersDataSource}" />
								<syswf:param name="addLicensedUsersHolder"
									value="${addLicensedUsersHolder}" />
								<syswf:param name="kind" value="browse" />
							</syswf:component>
						</syswf:block>
						<syswf:block className="UI Block Green">
				            <div class="UI Form Controls">
				                <fmt:message key="backButton_label" var="backButton" bundle="${license_Messages}"/>
				                <syswf:control mode="button" caption="${backButton}" hint="${backButton}" targetDepth="${sessionStack.currentDepth -1}">
				                    <syswf:attribute name="class" value="btn btn-gray" />
				                </syswf:control>
				            </div>
				        </syswf:block>
					</td>
				</tr>
			</tbody>
		</table>
	</c:otherwise>
</c:choose>