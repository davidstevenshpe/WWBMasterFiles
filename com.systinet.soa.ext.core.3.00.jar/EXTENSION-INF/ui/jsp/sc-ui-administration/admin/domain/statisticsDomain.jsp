<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />

<syswf:block className="UI Block Common">
	<div class="Title"><h3><fmt:message key="viewDomain.statistics.header" bundle="${domain_Messages}" /></h3></div>
	<div class="Content">
		<table class="UI Table Properties">
			<col class="LabelCol"/>
			<col/>
			<tbody>
				<tr>
					<th class="UI Label Inline"><fmt:message key="viewDomain.statistics.numofartifact.label" bundle="${domain_Messages}" />:</th>
					<td>
						<span class="IconAlign">${statisticsBean.numOfArtifacts} <fmt:message key="viewDomain.statistics.artifacts.label" bundle="${domain_Messages}" /></span>
					</td>
				</tr>
				<tr>
					<th class="UI Label Inline"><fmt:message key="viewDomain.statistics.structure.label" bundle="${domain_Messages}"/>:</th>
					<td><span class="IconAlign"><syswf:out value="${types}" context="HtmlBody"/></span></td>
				</tr>			
				<!--tr>
					<th class="UI Label Inline"><fmt:message key="viewDomain.statistics.topprovider.label" bundle="${domain_Messages}" />:</th>
					<td><span class="IconAlign"><syswf:out value="${topProviders}" context="HtmlBody"/></span></td>
				</tr-->
				<!-- <tr>
					<th class="UI Label Inline"><fmt:message key="viewDomain.statistics.numofuser.label" bundle="${domain_Messages}" />:</th>
					<td><span class="IconAlign">${statisticsBean.numOfUsers} <fmt:message key="viewDomain.statistics.users.label" bundle="${domain_Messages}" /></span></td>
				</tr>
				-->
				<tr>
					<th class="UI Label Inline"><fmt:message key="viewDomain.statistics.numofgroup.label" bundle="${domain_Messages}" />:</th>
					<td><span class="IconAlign">${statisticsBean.numOfGroups} <fmt:message key="viewDomain.statistics.groups.label" bundle="${domain_Messages}" /></span></td>
				</tr>
			</tbody>			
		</table>		
	</div>
</syswf:block> 