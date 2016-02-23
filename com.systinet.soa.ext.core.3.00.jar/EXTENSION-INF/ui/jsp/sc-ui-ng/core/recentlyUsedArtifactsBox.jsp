<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />
</c:if>
<c:set var="counter" value="${0}"/>
<c:choose>
    <c:when test="${not empty this.links}">
    	<ul>
        <c:forEach items="${this.links}" var="link" varStatus="status">
            <c:if test="${not link.deleted and counter<maxItems}">
                <li>
                    <syswf:control mode="anchor" targetTask="${link.url}" hint="${link.artifactLabel}" caption="${link.name}" targetDepth="0"
                                   id="${status.index}_name">
                        <c:if test="${not empty link.params}">
                            <syswf:paramSet value="${link.params}" />
                        </c:if>
                        <syswf:attribute name="class" value="truncate-long-text" />
                    </syswf:control>
                </li>
                <c:set var="counter" value="${counter+1}"/>
            </c:if>
        </c:forEach>
        </ul>
    </c:when>
    <c:otherwise>
        Here is the list of catalog items you have visited in the past. Since you haven't visited any such item yet this list is now empty.
    </c:otherwise>
</c:choose>