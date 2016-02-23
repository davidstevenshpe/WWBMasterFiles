<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${systemGroup == false}">
<syswf:control id="myLink" mode="anchor" caption="${groupName}" targetTask="/common/group/view">
	<syswf:param name="groupName" value="${groupName}"/>
</syswf:control>
</c:if>
<c:if test="${systemGroup == true}">
	<c:out value="${groupName}"></c:out>
</c:if>
 