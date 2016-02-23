<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:if test="${group.external == false and retired == 'false'}">
<syswf:control id="editGroupLink" mode="anchor" caption="" targetTask="/admin/group/edit">
	<syswf:param name="groupName" value="${groupName}"/>
	<syswf:attribute name="class" value="context-button Edit" />
	<syswf:attribute name="title" value="Edit" />
</syswf:control>
</c:if>

