<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>
<fmt:setBundle basename="com.hp.systinet.sc.ui.taxonomy.taxonomyBrowserMessages" var="taxMessages"/>

<c:choose>
    <c:when test="${running}">
        <br/>
        <br/>
        <br/>
        <br/>
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${empty categoryCounts}">
                <p><fmt:message bundle="${taxMessages}" key="noItemsMessage" /></p>
            </c:when>
            <c:otherwise>
                <table class="UI Layout">
                <col />
                <col />
                <col />
                <tr>
                <td>
                <c:forEach items="${categoryCounts}" var="taxonomy" varStatus="status">
                        <c:if test="${status.index > 0 && status.index % colcount == 0}">
                        </td>
                        <td>
                        </c:if>
                            <ul class="UI Hierarchy"><li class="Root">
                                <syswf:component name="/core/impl/taxonomy/taxonomyLink" prefix="taxlink${status.index}" wrap="false">
                                    <syswf:param name="taxonomy" value="${taxonomy.key}" />
                                </syswf:component>
                            <c:if test="${not empty taxonomy.value.categoryCount}">
                            <ul class="UI Hierarchy">
                                    <c:forEach items="${taxonomy.value.categoryCount}" var="category" varStatus="status2">
                                    <li class="Branch">
                                        <syswf:component name="/core/impl/taxonomy/categoryLink" prefix="catlink${status.index}n${status2.index}" wrap="false">
                                            <syswf:param name="categoryCount" value="${category}" />
                                        </syswf:component>
                                    </li>
                                    </c:forEach>
                                    <c:if test="${taxonomy.value.limited}">
                                        <li>
                                        <syswf:component name="/core/impl/taxonomy/taxonomyLink" prefix="morelink${status.index}" wrap="false">
                                            <syswf:param name="taxonomy" value="${taxonomy.key}" />
                                            <syswf:param name="caption">
                                                <fmt:message bundle="${taxMessages}" key="renderSubCategories_show_more" />
                                            </syswf:param>
                                        </syswf:component>
                                        </li>
                                    </c:if>
                            </ul>
                            </c:if>
                            </li>
                            </ul>
                </c:forEach>
                </td>
                </tr>
                </table>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>
