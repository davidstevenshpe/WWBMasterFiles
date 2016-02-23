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


<syswf:component name="/core/search/keywordsSuggestedSearch" prefix="${prefix}keywordsSearch">
    <syswf:param name="keywordsCustomizationId" value="shared.keywords.suggestedSearch"/>
    <syswf:param name="keywordsValueHolder" value="${valueHolder}" />
    <syswf:param name="width" value="350" />
    <syswf:param name="keywordsShowHint" value="${true}"/>
</syswf:component>
