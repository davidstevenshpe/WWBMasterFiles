<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />
<fmt:message key="defaultAcl.browse.header.${ruleType}" var="ruleHeader" bundle="${domain_Messages}" />
<fmt:message key="defaultAcl.browse.note.${ruleType}" var="note" bundle="${domain_Messages}" />

<syswf:block className="UI Block Common">
    <div class="Content">
    	<table class="UI Table Layout">
    		<tr>
				<td>
					<div class="Title">
						<h3><span><c:out value="${ruleHeader}"/></span></h3>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<label class="UI Icon Info"><c:out value="${note}"/></label>
				</td>
			</tr>
			<tr>
				<td>
					<syswf:component name="/core/table" prefix="browse${ruleType}Rule" wrap="true">
					    <syswf:param name="customizationId" value="admin.domain.acl.table${ruleType}Rule" />
					    <syswf:param name="datasource" value="${rulesDataSource}"/>
					</syswf:component>
				</td>
			</tr>
    	</table>
    </div>
</syswf:block>