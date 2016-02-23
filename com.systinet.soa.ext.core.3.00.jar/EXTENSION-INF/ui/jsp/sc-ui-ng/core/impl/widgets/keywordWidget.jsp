<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<c:if test="${mode eq 'view'}">
    <c:forEach items="${this.keywords}" var="keyword" varStatus="status"><c:if test="${status.index > 0}">, </c:if>
    <syswf:component name="/core/keywords/searchLinkRenderer" prefix="keyword${status.index}" wrap="false">
        <syswf:param name="tag" value="${keyword}" />
    </syswf:component></c:forEach>
</c:if>

<c:if test="${mode eq 'edit'}">
    <%--
    <syswf:component name="/core/impl/widget/keywordsSuggestedSearch" prefix="suggestedSearchInput">
        <syswf:param name="webCondition" value="${this.keyword}"/>
        <syswf:param name="cssOfInput" value="Full" />
    </syswf:component>
    --%>
    
    <syswf:component name="/core/search/keywordsSuggestedSearch" prefix="suggestedSearch" >
        <syswf:param name="keywordsCustomizationId" value="shared.keywords.suggestedSearch"/>
        <syswf:param name="keywordsValueHolder" value="${this.keyword}"/>
        <syswf:param name="cssOfInput" value="Full" />    
        <syswf:param name="inputId" value="${inputId}" />
        <syswf:param name="keywordsShowHing" value="${true}"/>
    </syswf:component>
</c:if>