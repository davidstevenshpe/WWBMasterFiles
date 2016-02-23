<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:forEach var="group" items="${internalNavigation.groups}" varStatus="groupStatus">
	<c:forEach var="item" items="${group.elements}">	
		<syswf:component name="${item.componentName}" prefix="${item.id}">
				<syswf:param name="wrap" value="false"/>
				<syswf:paramSet value="${item.paramsMap}"/>
		</syswf:component>
	</c:forEach>
</c:forEach>