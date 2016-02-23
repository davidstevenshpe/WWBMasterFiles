<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="labels" />

<fmt:message bundle="${widgetMessages}" var="windowTitle" key="keyword.editTags" />
<fmt:message bundle="${labels}" var="selectLabel" key="Save" />

<div class="EA-right-panel">
	<fmt:message key="keyword.keywords" bundle="${widgetMessages}" />
    <div>
        <c:choose>
            <c:when test="${empty this.keywords}">
                <i><fmt:message key="keyword.empty" bundle="${widgetMessages}" /></i>
            </c:when>
            <c:otherwise>
                <c:forEach items="${this.keywords}" var="keyword" varStatus="status"><c:if test="${status.index > 0}"><fmt:message key="keywordsSeparator" bundle="${widgetMessages}" /> </c:if>
                    <syswf:component name="/core/keywords/searchLinkRenderer" prefix="keyword${status.index}" wrap="false">
                        <syswf:param name="tag" value="${keyword.keyword}" />
                    </syswf:component></c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
    
    <c:if test="${permissions.write}">
        <div class="UI Footer">
            <a class="UI Icon Edit" href="javascript:void(0)" id="EditKeywords"><span><fmt:message key="Edit" bundle="${labels}" /></span></a>

            <syswf:component name="/core/keywords/keywordsSelector" prefix="keywordsSelector">
                <syswf:param name="jsOpenFunction" value="${prefix}selectKeywordsWindowFce" />
                <syswf:param name="keywordsSelectorListener" value="${this.keywordsHolder}" />
                <syswf:param name="selectedKeywords" value="${this.keywords}" />
                <syswf:param name="selectLabel" value="${selectLabel}" />
                <syswf:param name="windowTitle" value="${windowTitle}" />
            </syswf:component>

            <script type="text/javascript">
//<![CDATA[

                Ext.onReady(function() {
                        Ext.get('EditKeywords').on('click', ${prefix}selectKeywordsWindowFce);
                });
            
//]]>
</script>
        </div>
    </c:if>
</div>
