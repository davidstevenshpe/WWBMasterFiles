<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<syswf:block className="UI Block Common">
    <div class="Title">
        <h3>${title}</h3>
    </div>
    <div class="Content">
        <syswf:component name="/core/keywords/tagCloud" prefix="leftColumn.tagCloud.contents">
            <syswf:param name="customizationId" value="${customizationId}"/>
            <c:if test="${not empty views}">
            	<syswf:param name="views" value="${views}" />
            </c:if>
            <syswf:param name="linkRenderer" value="/core/keywords/searchLinkRenderer"/>
        </syswf:component>
    </div>
</syswf:block>