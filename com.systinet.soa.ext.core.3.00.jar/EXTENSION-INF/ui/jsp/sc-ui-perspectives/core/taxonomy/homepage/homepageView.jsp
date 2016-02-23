<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>
<fmt:setBundle basename="com.hp.systinet.sc.ui.taxonomy.taxonomyBrowserMessages" var="taxMessages"/>

<syswf:block className="UI Block Common">
    <div class="Title">
        <h3><fmt:message bundle="${taxMessages}" key="categoriesHeader"/></h3>
    </div>
    <div class="Content">

        <c:choose>
            <c:when test="${running}">
                
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${empty artifactTypes}">
                        <c:set var="artifactTypes" value="businessServiceArtifact" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="artifactTypes" value="${artifactTypes}" />
                    </c:otherwise>
                </c:choose>

                <c:choose>
                    <c:when test="${empty categoryCounts}">
                        <p><fmt:message bundle="${taxMessages}" key="noItemsMessage" /></p>
                    </c:when>
                    <c:otherwise>
                        <table class="UI Table Properties">
                        <colgroup>
                            <col class="MidLabelCol"/>
                            <col class="ShortSpacerCol" />
                            <col />
                        </colgroup>
                        <c:forEach items="${categoryCounts}" var="taxonomy" varStatus="status">
                            <tr>
                                <th>
                                    <syswf:component name="/core/impl/taxonomy/taxonomyLink" prefix="taxlink${status.index}" wrap="false">
                                        <syswf:param name="taxonomy" value="${taxonomy.key}" />
                                    </syswf:component>:
                                </th>
                                <td></td>
                                <td>
                                    <c:set var="cc" value="${taxonomy.value}"/>
                                    <c:forEach items="${cc.categoryCount}" var="category" varStatus="status2">
                                        <syswf:component name="/core/impl/taxonomy/categoryLink" prefix="catlink${status.index}n${status2.index}" wrap="false">
                                            <syswf:param name="categoryCount" value="${category}" />
                                        </syswf:component><c:if test="${not status2.last}">, </c:if>
                                    </c:forEach>
                                    <c:if test="${cc.limited}">...</c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </table>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="Footer">
        <fmt:message bundle="${taxMessages}" var="viewAllLabel" key="viewAllCategories" />
        <syswf:control mode="anchor" targetTask="/${activeTab}/categorization/categoryView" caption="${viewAllLabel}">
        	<c:if test="${not empty views}">
        		<syswf:param name="views">${views}</syswf:param>
        	</c:if>
        </syswf:control>
    </div>
</syswf:block>

