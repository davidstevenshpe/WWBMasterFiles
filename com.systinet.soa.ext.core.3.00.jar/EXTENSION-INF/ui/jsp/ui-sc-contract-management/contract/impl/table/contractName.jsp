<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<syswf:component name="${this.plainLinkDescriptor.component}" prefix="del">
    <syswf:paramSet value="${passDownParameters}"/>
    <c:if test="${not empty caption}">
        <syswf:param name="caption" value="${consumptionName}"/>
    </c:if>
</syswf:component>
