<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--@elvariable id="caption" type="java.lang.String"--%>
<%--@elvariable id="processId" type="java.lang.Object"--%>
<%--@elvariable id="processUuid" type="java.lang.Object"--%>
<%--@elvariable id="bean" type="com.hp.systinet.lifecycle.ui.common.renderer.ProcessLinkRenderer.ProcessLinkRendererBean"--%>
<c:choose>
    <c:when test="${bean.showLink and (not empty processUuid or not empty processId)}">
        <syswf:control id="processLink" mode="anchor" caption="${caption}"
                       targetTask="/admin/lifecycle/process/processView">
            <c:choose>
                <c:when test="${not empty processUuid}">
                    <syswf:param name="processUuid" value="${processUuid}"/>
                </c:when>
                <c:otherwise>
                    <syswf:param name="processId" value="${processId}"/>
                </c:otherwise>
            </c:choose>
        </syswf:control>
    </c:when>
    <c:otherwise>
        <c:out value="${caption}"/>
    </c:otherwise>
</c:choose>

