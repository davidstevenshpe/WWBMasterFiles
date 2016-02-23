<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.config.basic.BasicSettingsMessages" var="basicSettings_Messages" />

<table class="UI Layout">
	<tbody>
		<tr id="pagetitle" class="EA-Blue-Bar">
			<td class="UI Middle">
				<div class="UI PageIdentity">
					<h3 class="EA-top-header">
						<fmt:message key="configuration.header" bundle="${basicSettings_Messages}" />
					</h3>
				</div>			
			</td>
		</tr>	
		<tr>
			<td>
                <syswf:component prefix="tabs" name="/core/layout/tabs">
                    <syswf:param name="isDisable" value="${isDisable}"/>
                    <syswf:param name="customizationId" value="admin.config.viewTabs"/>
                </syswf:component>
            </td>
        </tr>
    </tbody>
</table>