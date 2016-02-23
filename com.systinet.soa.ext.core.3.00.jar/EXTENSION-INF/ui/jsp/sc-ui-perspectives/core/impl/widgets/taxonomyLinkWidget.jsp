<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="functionName" value="${affectedComponent}_showTaxonomy_${this.taxonomy.modelKey}" />
<c:set var="functionName" value="${fn:replace(functionName,':','_')}" />
<c:set var="functionName" value="${fn:replace(functionName,'-','_')}" />
<c:set var="functionName" value="${fn:replace(functionName,'.','_')}" />

<c:choose>
    <c:when test="${mode == 'none'}">
        <c:out value="${this.taxonomy.name}"/>
    </c:when>
    <c:otherwise>
        <syswf:control id="taxonomyLink${this.taxonomy.modelKey}" mode="script" action="${affectedComponent}$onShowSelectedTaxonomy"
            affects="${affectedComponent}" caption="${functionName}">
            <syswf:param name="taxonomy" value="${this.taxonomy}" />
            <syswf:param name="${tableId}_resetPaging" value="true" />
            <syswf:param name="${tableId}_resetFilter" value="true" />
        </syswf:control>

        <a id="${functionName}Id" href="javascript:void(0);"><c:out value="${this.taxonomy.name}"/></a>
        <script type="text/javascript">
        //<![CDATA[

           attachOn('${functionName}Id', 'click', ${functionName});
        
        //]]>
        </script>
    </c:otherwise>
</c:choose>