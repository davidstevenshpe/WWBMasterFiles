<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />
<tr>
	<td>
		<label>
			<fmt:message key="ruleLayout.grants.label" bundle="${domain_Messages}" />
		</label>
	</td>
	<td>
		<span class="UI Icon Completed">
			<fmt:message key="ruleLayout.grants.action.create.label" bundle="${domain_Messages}" />
		</span>	
	</td>
</tr>
<tr>
	<td>
		<label>
			<fmt:message key="ruleLayout.artifactType.label" bundle="${domain_Messages}" />
		</label>
	</td>
	<td>
		<span class="IconAlign">${bean.artifactTypeAccessBean.artifactTypeName}</span>
	</td>
</tr>