<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<c:choose>
    <c:when test="${isAdmin}">
       <syswf:control mode="anchor" caption="${serverName}" targetTask="/admin/server/view">
         <syswf:param name="serverUUID" value="${serverUUID}"/>
       </syswf:control>
    </c:when>
    <c:otherwise>
        <syswf:control mode="anchor" caption="${serverName}" targetTask="/common/viewArtifact">
             <syswf:param name="uuid" value="${serverUUID}"/>
        </syswf:control>
    </c:otherwise>
</c:choose>