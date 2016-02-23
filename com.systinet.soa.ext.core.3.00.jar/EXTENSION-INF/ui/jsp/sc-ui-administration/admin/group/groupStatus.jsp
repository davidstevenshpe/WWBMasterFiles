<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.admin.group.GroupMessages" var="groups_Messages" />
	
<c:if test="${groupStatus == 'retiredGroup'}"><fmt:message key="group.status.Retire" bundle="${groups_Messages}" /></c:if>
<c:if test="${groupStatus == 'activeGroup'}"><fmt:message key="group.status.Active" bundle="${groups_Messages}" /></c:if>
