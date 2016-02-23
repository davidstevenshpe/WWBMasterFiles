<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<fmt:setBundle basename="com.hp.systinet.report.ui.policy.PolicyReportMessages" var="pr_Messages" />
<fmt:setBundle basename="com.hp.systinet.report.ui.l10n.ReportMessages" var="report_Message"/>
<table class="UI Layout">
	<tbody>
		<tr>
			<td class="UI Middle">
				<div class="Title">
					<h3>
						<fmt:message key="policyreport.sourceselector.header" bundle="${pr_Messages}" />
					</h3>
				</div>					
				<i><fmt:message key="policyreport.sourceselector.info" bundle="${pr_Messages}" /></i>
			</td>
		</tr>	
		<tr>
			<td>
                <syswf:component prefix="tabs" name="/core/layout/tabs" ajax="true">
                    <syswf:param name="customizationId" value="reports.policy.sourceSelectorTabs"/>
                    <syswf:param name="tabId" value="${activeTabId}" />
                    <syswf:param name="model" value="${model}" />
                </syswf:component>
            </td>
        </tr>
        
    </tbody>
</table>


          