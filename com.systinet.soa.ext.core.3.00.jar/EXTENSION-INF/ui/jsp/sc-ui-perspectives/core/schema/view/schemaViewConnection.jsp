<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<tr>
    <c:if test="${position > 0 or not last}">
        <c:choose>
            <c:when test="${position > 0}">
                <td class="XSDVerticalLineTopFill">
                    <img align="absmiddle" class="XSDGraphImg" src="${imgLocation}/transparent-dot.png" width="20" height="20"/>
                </td>
            </c:when>
            <c:otherwise>
                <td class="XSDVerticalLineTopEmpty">
                    <img align="absmiddle" class="XSDGraphImg" src="${imgLocation}/transparent-dot.png" width="20" height="20"/>
                </td>
            </c:otherwise>
        </c:choose>
    </c:if>
    ${content}
</tr>
<tr>
    <c:if test="${position > 0 or not last}">
        <c:choose>
            <c:when test="${not last}">
                <td class="XSDVerticalLineBottomFill">
                    <img align="absmiddle" class="XSDGraphImg" src="${imgLocation}/transparent-dot.png" width="20" height="20"/>
                </td>
            </c:when>
            <c:otherwise>
                <td class="XSDVerticalLineBottomEmpty">
                    <img align="absmiddle" class="XSDGraphImg" src="${imgLocation}/transparent-dot.png" width="20" height="20"/>
                </td>
            </c:otherwise>
        </c:choose>
    </c:if>
</tr>
