<%--
Parameters:

jsOpenFunction* = name of a function that opens the window, has to be bound to an element onClick method
keywordsSelectorListener* = implementation of KeywordsSelectorListener
windowTitle = title of the opened window, if null, default title is used
selectLabel = label of the button for selection (confirmation)

* - these parameters are mandatory  
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.uisccomponentsmessages" var="messages" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>

<c:if test="${empty windowTitle}">
	<fmt:message bundle="${messages}" var="windowTitle" key="keywordsSelector.defaultTitle" />
</c:if>

<c:if test="${empty selectLabel}">
    <fmt:message bundle="${messages}" var="selectLabel" key="Select" />
</c:if>


<syswf:control mode="script" caption="${prefix}selectKeywords" action="selectKeywords"  affects="."/>
<syswf:control mode="script" caption="${prefix}cancelKeywords" action="cancelKeywords"  affects="."/>

<syswf:component name="/core/window" prefix="internal">
    <syswf:param name="winId">${prefix}Internal</syswf:param>
    <syswf:param name="winTitle"><c:out value="${windowTitle}"/></syswf:param>
    <syswf:param name="winComponent" value="/core/keywords/keywordsSelectorInternal"/>
    <syswf:param name="winOpenFunctionName" value="${jsOpenFunction}" />
    <syswf:param name="winOkAction" value="${prefix}selectKeywords" />
    <syswf:param name="winOkLabel"><c:out value="${selectLabel}" /></syswf:param>
    <syswf:param name="winCancelAction" value="${prefix}cancelKeywords" />
    <syswf:param name="valueHolder" value="${searchExpressionWrapper}" />
</syswf:component>




    

    