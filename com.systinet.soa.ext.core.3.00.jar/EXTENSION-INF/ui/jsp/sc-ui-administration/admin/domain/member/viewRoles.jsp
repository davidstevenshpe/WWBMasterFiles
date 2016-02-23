<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle	basename="com.hp.systinet.sc.ui.admin.domain.DomainMessages" var="domain_Messages" />
<table >
	<tr>
		<td>
			<c:forEach items="${roles}" var="role" varStatus="cnt">				
				<syswf:component prefix="${prefix}_${prefixId}_roleLink_${cnt.count}" name="/core/impl/util/principalLinkRenderer">
					<syswf:param name="principal" value="${role.first}" />
				</syswf:component>
			</c:forEach>
		</td>		
	</tr>
</table>
	
