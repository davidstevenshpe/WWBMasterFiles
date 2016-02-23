<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:control mode="script" caption="${controlName}" targetTask="/admin/domain/acl/create">
	<syswf:param name="ruleType">${ruleType}</syswf:param>
	<syswf:param name="modea">create</syswf:param>
	<syswf:param name="domainId">${domainId}</syswf:param>
</syswf:control>