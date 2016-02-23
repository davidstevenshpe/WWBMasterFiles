<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>


<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<c:set var="functionName" value="${prefix}add" />

<c:set var="superparentPrefix" value="${parentPrefixes[2]}"/>

<syswf:control mode="script" affects="../../.." action="${superparentPrefix}$addKeyword" caption="${functionName}" id="add${functionName}">
    <syswf:param name="keyword" value="${tag}"/>
</syswf:control>

<a href="javascript:void(0);" class="${class}" id="a${functionName}">
    <span><c:out value="${tag}"/></span>
</a>

<script type="text/javascript">
//<![CDATA[

    attachOn('a${functionName}', 'click', ${functionName});

//]]>
</script>