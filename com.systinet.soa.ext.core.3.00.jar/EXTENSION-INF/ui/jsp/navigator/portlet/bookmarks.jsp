<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.hp.systinet.navigator.ui.navigator" var="messages"/>

<fmt:message key="navigator.portlet.bookmarks.more" var="moreText" bundle="${messages}"/>
<fmt:message key="navigator.portlet.bookmarks.less" var="lessText" bundle="${messages}"/>
<fmt:message key="navigator.portlet.bookmarks.take_tour" var="take_tour" bundle="${messages}"/>
<fmt:message key="navigator.portlet.bookmarks.bookmarks" var="bookmarks" bundle="${messages}"/>

<c:choose>
    <c:when test="${(snaphostsSize > 0) and (more)}">
        <div class="shrCatalogChildren">
            <c:forEach var="snapshot" items="${snaphosts}">
                <div class="shrCatalogItem">
                    <table style="margin: 5px 5px 5px 0px;" border="0px" width="100%">
                        <tr>
                            <td bgcolor="#3259AA" height="200" align="center" valign="middle"
                                style="text-align: center;">
                                <c:set var="navigatorLink">
                                    <syswf:control caption="${snapshot.snapshotIdMetaBean.metaBean.name}"
                                                   mode="href"
                                                   targetTask="/navigator" wrapper="false">
                                        <syswf:param name="bookmarkId" value="${snapshot.snapshotIdMetaBean.id}"/>
                                    </syswf:control>
                                </c:set>
                                <a href="${navigatorLink}">
                                    <div width="100%">
                                        <img src="${deploymentUrl}/../remote/navigator/bookmarkImage?id=${snapshot.snapshotIdMetaBean.id}"
                                             alt="${snapshot.snapshotIdMetaBean.metaBean.name}, ${snapshot.formatedLastModificationTime}"
                                             title="${snapshot.snapshotIdMetaBean.metaBean.name}, ${snapshot.formatedLastModificationTime}"
                                             border="0"/>
                                    </div>
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <syswf:control caption="${snapshot.snapshotIdMetaBean.metaBean.name}" mode="anchor"
                                               targetTask="/navigator" wrapper="false">
                                    <syswf:param name="bookmarkId" value="${snapshot.snapshotIdMetaBean.id}"/>
                                </syswf:control>
                                <c:out value=", ${snapshot.formatedLastModificationTime}"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:when test="${(snaphostsSize > 0) and (not more)}">
        <div class="shrCatalogChildren">
            <div class="shrCatalogItem">
                <table style="margin: 5px 5px 5px 0px;" border="0px" width="100%">
                    <tr>
                        <td bgcolor="#3259AA" height="200" align="center" valign="middle"
                            style="text-align: center;">
                            <c:set var="navigatorLink">
                                <syswf:control caption="${snaphosts[0].snapshotIdMetaBean.metaBean.name}"
                                               mode="href"
                                               targetTask="/navigator" wrapper="false">
                                    <syswf:param name="bookmarkId" value="${snaphosts[0].snapshotIdMetaBean.id}"/>
                                </syswf:control>
                            </c:set>
                            <a href="${navigatorLink}">
                                <div width="100%">
                                    <img src="${deploymentUrl}/../remote/navigator/bookmarkImage?id=${snaphosts[0].snapshotIdMetaBean.id}"
                                         alt="${snaphosts[0].snapshotIdMetaBean.metaBean.name}, ${snaphosts[0].formatedLastModificationTime}"
                                         title="${snaphosts[0].snapshotIdMetaBean.metaBean.name}, ${snaphosts[0].formatedLastModificationTime}"
                                         border="0"/>
                                </div>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <syswf:control caption="${snaphosts[0].snapshotIdMetaBean.metaBean.name}" mode="anchor"
                                           targetTask="/navigator" wrapper="false">
                                <syswf:param name="bookmarkId" value="${snaphosts[0].snapshotIdMetaBean.id}"/>
                            </syswf:control>
                            <c:out value=", ${snaphosts[0].formatedLastModificationTime}"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="shrCatalogChildren">
            <div class="shrCatalogItem">
                <img src="${deploymentUrl}/navigator/bookmarksIcon.png" title="${bookmarks}" alt="${bookmarks}"
                     border="0" align="left" style="zoom:1;margin-right: 7px; position: relative"/>
                <fmt:message key="navigator.portlet.bookmarks.no-data.part1" bundle="${messages}"/>
                <br/>
                <fmt:message key="navigator.portlet.bookmarks.no-data.part2" bundle="${messages}"/>
                <div class="clear"></div>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<div class="shrWidgetContentActionsBottom">
    <c:choose>
        <c:when test="${(snaphostsSize > 1) and (more)}">
            <syswf:control caption="${lessText}" mode="anchor" action="less" affects="."/>
        </c:when>
        <c:when test="${(snaphostsSize > 1) and (not more)}">
            <syswf:control caption="${moreText}" mode="anchor" action="more" affects="."/>
        </c:when>
    </c:choose>
</div>