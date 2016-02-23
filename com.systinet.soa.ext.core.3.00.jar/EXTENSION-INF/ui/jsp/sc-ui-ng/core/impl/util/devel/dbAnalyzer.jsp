<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${analyzerAvailable}">
    <tr>
        <th class="UI Label Inline">
            DB query analyzer (Susan):
        </th>
        <td>
            <c:choose>
                <c:when test="${analyzerEnabled}">
                    <syswf:control mode="button" action="analyzer.stop" caption="Stop" targetComponent="${prefix}"/>
                </c:when>
                <c:otherwise>
                    <syswf:control mode="button" action="analyzer.start" caption="Start" targetComponent="${prefix}"/>
                </c:otherwise>
            </c:choose>
        </td>
    </tr>
</c:if>
