<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:choose>
    <c:when test="${isRegistryUrl}">
       <c:if test ="${not empty artifact}">
            <c:choose>
                <c:when test="${isAdmin}">
                    <syswf:control id="viewRegistryServer" mode="anchor" caption="${artifact.name}" targetTask="/admin/server/view" >
                        <syswf:param name="serverUUID" value="${artifact._uuid}" />
                        <syswf:param name="domainId" value="${artifact._domainId}" />
                    </syswf:control>
                </c:when>
                <c:otherwise>
                    <c:out value="${artifact.name}"/>
                </c:otherwise>
            </c:choose>
       </c:if>
    </c:when>
    <c:otherwise>
        <c:out value="${resourceAddress}"/>
    </c:otherwise>
</c:choose>

