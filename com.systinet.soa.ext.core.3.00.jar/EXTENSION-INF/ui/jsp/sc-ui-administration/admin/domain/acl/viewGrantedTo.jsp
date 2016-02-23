<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle	basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />

<c:forEach items="${grantedTo}" var="granted" varStatus="cnt">
	<table>
		<tr>
			<td>
				<syswf:component prefix="${prefix}_${prefixId}_roleLink_${cnt.count}" name="/core/impl/util/principalLinkRenderer">
					<syswf:param name="principal" value="${granted.first}" />
				</syswf:component>
			</td>
			<td>
			<c:if test="${granted.second}">
				&nbsp;<fmt:message key="defaultAcl.fromAnyDomain" bundle="${domain_Messages}" />
			</c:if>
			</td>
		</tr>
	</table>
</c:forEach>