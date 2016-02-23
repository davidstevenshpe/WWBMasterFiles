<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<%-- 
Renders a keyword as a link to advanced search.
Accepts following parameters:
   class - a CSS class applied to the link
   tag - the string representing the keyword value
--%>

<syswf:control mode="anchor" caption="${tag}" targetTask="/${viewId}/advancedSearch">
    <syswf:attribute name="class">${class}</syswf:attribute>      
    <syswf:param name="advancedOptionsExpanded" value="true"/>
    <syswf:param name="search.keywords" value="${tag}"/>
</syswf:control>