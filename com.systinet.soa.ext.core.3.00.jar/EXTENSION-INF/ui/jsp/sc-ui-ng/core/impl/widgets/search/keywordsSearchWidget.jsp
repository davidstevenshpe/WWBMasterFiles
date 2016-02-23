<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<c:if test="${not empty this.webCondition and (not defaultVisible || (defaultVisible and visible))}" >

    <syswf:control id="${prefix}remove" mode="script" caption="${prefix}remove" action="onRemove" affects="..">
    </syswf:control>    
    
    <c:if test="${empty class}">
        <c:set var="class" value="x-form-text x-form-field" />
    </c:if>
    
    
    <c:set var="content">
         <syswf:component name="/core/search/keywordsSuggestedSearch" prefix="suggestedSearch" >
            <syswf:param name="keywordsCustomizationId" value="shared.keywords.suggestedSearch"/>
            <syswf:param name="keywordsValueHolder" value="${this.webCondition}"/>
            <syswf:param name="cssOfInput" value="${cssOfInput}" />    
            <syswf:param name="styleOfInput" value="${style}" />
            <syswf:param name="classOfInput" value="${class}" />
            <syswf:param name="width" value="200" />
            <syswf:param name="afterInputContent" value="content" />
            <syswf:param name="inputId" value="${prefix}SuggestedSearchInput"/>
            <syswf:param name="suggestDatasource" value="${datasource}"/>
            <c:if test="${condition.valueError}">
                <syswf:param name="style" value="background-color:#FFCCCC;"/>
            </c:if>
            <syswf:param name="class" value="x-form-text"/>
            <syswf:param name="availableArtifactTypes" value="${availableArtifactTypes}"/>
            <syswf:param name="keywordsAddListener" value="${keywordsAddListener}"/>
        </syswf:component>
    </c:set>
    
    <syswf:component name="/core/impl/widget/search/widgetWrapper" prefix="${inputId}Wrapped">
        <syswf:param name="content" value="${content}"/>
        <syswf:param name="inputId" value="${prefix}SuggestedSearchInput"/>
        <syswf:param name="visible" value="${visible}"/>
        <syswf:param name="removeFce" value="${prefix}remove"/>
    </syswf:component>
    
</c:if>