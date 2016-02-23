<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />
</c:if>

<c:choose>
    <c:when test="${isWebServiceWithWsdl == null}">
        <%-- do not show the section at all --%>
    </c:when>
    <c:otherwise>
            <c:if test="${bacServiceStatusContextInfo != null}">
                <div id='<c:out value="${prefix}_bacstatus"/>'>
                <syswf:component name="/integration/bac/servicestatus/cell" wrap="false" prefix="bacstatus">
                    <syswf:param name="documentDescription" value="${documentDescription}" />
                    <syswf:param name="bacServiceStatusContextInfo" value="${bacServiceStatusContextInfo}" />
                </syswf:component>
                </div>
            </c:if>
    </c:otherwise>
</c:choose>