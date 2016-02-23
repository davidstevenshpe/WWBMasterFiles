<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--
Display a feed with following stage:
  - Feed loading, progress bar displayed + cached version of the feed if available
  - Feed loading error - error message displayed
  - Feed loaded - display feed items, count info, feed homepage link

Parameters:
   feedInfo: instance of class com.hp.systinet.sc.ui.struct.FeedInfo
   
Actions support:
   refreshFeed: force to reload feed, which can be called from parent component to refresh the feed.
--%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="bundle"/>


<syswf:block className="UI Block Common">
<div class="Title">
    <h3><span>${feedInfo.title}</span></h3>
</div>

<syswf:control mode="script" formName="ContentForm" caption="reload${prefix}" affects="."/>

<c:if test="${feed.loading}">
    <div id="divreload${prefix}">
            <%-- do AJAX call --%>
        <script type="text/javascript">
//<![CDATA[

            manageInterval('reload${prefix}');
        
//]]>
</script>
      <span class="UI Icon Working">
            <fmt:message key="feed.loading" bundle="${bundle}"/>
      </span>
    </div>
</c:if>
<div class="Content">
<c:choose>
    <c:when test="${not empty feed.feedError}">
        <div class="UI SystemMessage Error">
            <c:out value="${feed.feedError}" escapeXml="false"/>
        </div>
    </c:when>
    <c:when test="${empty feed.entries and not feed.loading}">
        <div class="UI SystemMessage Info">
            <fmt:message key="feed.noentry" bundle="${bundle}"/>
        </div>
    </c:when>
    <c:when test="${not empty feed.entries}">
        <c:set var="totalCount" value="0"/>
		<c:set var="shownCount" value="0"/>
		    <ul class="FeedEntries">
		        <c:forEach var="feedItem" items="${feed.entries}" varStatus="feedItemStatus">
		            <c:set var="totalCount" value="${totalCount + 1}"/>
		            <c:if test="${feedItemStatus.index < feedInfo.displayedCount}">
                        <c:choose>
                            <c:when test="${not empty feedItem.link}"><li><a href="${feedItem.link}">${feedItem.title}</a></li></c:when>
                            <c:otherwise><li>${feedItem.title}</li></c:otherwise>
                        </c:choose>
		                <c:set var="shownCount" value="${shownCount + 1}"/>
		            </c:if>
		        </c:forEach>
		    </ul>
		    <div class="FeedMeta">
				<fmt:message key="feed.summary" bundle="${bundle}">
		            <fmt:param value="${shownCount}"/>
		            <fmt:param value="${totalCount}"/>
		        </fmt:message>
	        </div>
    </c:when>
</c:choose>

</div>
</syswf:block>
