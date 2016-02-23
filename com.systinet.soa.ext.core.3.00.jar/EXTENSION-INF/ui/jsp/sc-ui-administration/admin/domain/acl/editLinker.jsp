<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<c:if test="${editDisable eq 'false'}">
<div class="UI Icon Edit">
	<syswf:control id="domainLink" mode="anchor" caption="edit" targetTask="/admin/domain/acl/edit">
		<syswf:param name="ruleType">${ruleType}</syswf:param>
		<syswf:param name="group">${group}</syswf:param>
		<syswf:param name="modea">edit</syswf:param>
		<syswf:param name="domainId">${domainId}</syswf:param>
	</syswf:control>
</div>
</c:if>