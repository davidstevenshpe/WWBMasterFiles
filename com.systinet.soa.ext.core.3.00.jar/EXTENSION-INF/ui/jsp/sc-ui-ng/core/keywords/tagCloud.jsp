<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<c:forEach items="${this.tags}" var="entry" varStatus="status">
    
    <c:choose>
        <c:when test="${this.percentileSize eq 0}">      
            <%-- every tag is used the same number of times --%>
            <syswf:component name="${linkRenderer}" prefix="${status.index}" wrap="false">
                <syswf:param name="class" value="KeywordC"/>
                <syswf:param name="tag" value="${entry.keyword}"/>
            </syswf:component>        
        </c:when>
        <c:otherwise>
        
            <c:set var="percentile" value="${(entry.count - this.minimumTagUsageCount) / this.percentileSize}"/>
            <c:set var="roundedPercentile" value="${percentile - percentile % 1}" />            
            
            <c:choose>
                <c:when test="${roundedPercentile eq 0}">
                    <c:set var="classSuffix" value="F"/>
                </c:when>
                <c:when test="${roundedPercentile eq 1}">
                    <c:set var="classSuffix" value="E"/>
                </c:when>
                <c:when test="${roundedPercentile eq 2}">
                    <c:set var="classSuffix" value="D"/>
                </c:when>
                <c:when test="${roundedPercentile eq 3}">
                    <c:set var="classSuffix" value="C"/>
                </c:when>
                <c:when test="${roundedPercentile eq 4}">
                    <c:set var="classSuffix" value="B"/>
                </c:when>
                <c:when test="${roundedPercentile eq 5}">
                    <c:set var="classSuffix" value="A"/>
                </c:when>
                <c:otherwise>
                    <%-- roundedPercentile is eq 6 --%>
                    <c:set var="classSuffix" value="A"/>
                </c:otherwise>
            </c:choose>

            <syswf:component name="${linkRenderer}" prefix="${status.index}" wrap="false">
                <syswf:param name="class" value="Keyword ${classSuffix}"/>
                <syswf:param name="tag" value="${entry.keyword}"/>
            </syswf:component>
        </c:otherwise>
    </c:choose>  

</c:forEach>