<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--
    keywodrdsCustomizationId - 
    keywordsValueHolder -
    keywordsShowHint (default false)
    and all params from suggestedSearch.jsp (except combo and keywordsContent)
 --%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>


<syswf:component name="/core/search/suggestedSearch" prefix="suggestedSearch" wrap="false" >
    <syswf:param name="customizationId" value="${keywordsCustomizationId}"/>
    <syswf:param name="value" value="${keywordsValueHolder}"/>
    <syswf:param name="classOfInput" value="x-form-text x-form-field" />
    <syswf:param name="combo" value="keywords" />    
    <syswf:param name="keywordsContent" value="${prefix}keyword_options_content"/>
    <syswf:paramSet value="${suggestedSearchParams}" /> 
</syswf:component>
<c:if test="${keywordsShowHint}">
    <sub><fmt:message key="keyword.edit.hint" bundle="${widgetMessages}" /></sub>
</c:if>

<div class="x-hidden flyout-menu UI Dropdown" id="${prefix}keyword_options_content" style="max-width:320px">
    <div class="DropdownTitle">
        <span style="font-size:small"><fmt:message key="keyword.topKeywords" bundle="${widgetMessages}"/></span>
    </div>
    <div class="DropdownContent">
        <syswf:component name="/core/keywords/tagCloud" prefix="tagCloud">
            <syswf:param name="customizationId" value="shared.tagCloud"/>
            <syswf:param name="linkRenderer" value="/core/impl/widget/search/keywordsSearchWidgetRenderer"/>
            <syswf:param name="availableArtifactTypes" value="${availableArtifactTypes}"/>
        </syswf:component>
    </div>
</div>