<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<c:forEach items="${keywordsList}" var="keyword" varStatus="status"><c:if test="${status.index > 0}">, </c:if>
<syswf:component name="/core/keywords/searchLinkRenderer" prefix="keyword${status.index}" wrap="false">
    <syswf:param name="tag" value="${keyword}" />
</syswf:component></c:forEach>