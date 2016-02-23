<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${enablePolicyManagement}">
	<syswf:component name="/core/contextActions/editArtifact" prefix="adminEditArtifact">
		<syswf:param name="artifact" value="${artifact}"></syswf:param>
        <syswf:param name="viewId" value="admin"/>
	</syswf:component>
</c:if>

