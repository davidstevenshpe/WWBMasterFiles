<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
    <c:when test="${not empty this.items}">
    	<ul>
        <c:forEach items="${this.items}" var="item" varStatus="status">
		    <li>
			    <c:choose>
					<c:when test="${not item.moreLink}">
						<a id="linkDoSurvey${status.count}" class="truncate-long-text" href="${baseUrl}/survey/doSurvey?surveyUuid=${item.surveyUuid}&artifactUuid=${item.uuid}" target="_blank"><c:out value="${item.name}"/></a>
					 </c:when>
					<c:otherwise>
						<a id="moreLinkDoSurvey" href="${baseUrl}/common/usertask/taskBrowser?selected=3">More...</a>
					</c:otherwise>
				</c:choose>
			</li>
        </c:forEach>
        </ul>
    </c:when>
    <c:otherwise>
        <c:out value="${noResults}" escapeXml="false"/>
    </c:otherwise>
</c:choose>