<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- TODO REVIEW (Svata, Apr 12, 2009): Desing: change syswf:control to properly register onXXX events --%>
<c:set var="newFunctionName" value="${affectedComponent}_descend_${this.functionName}" />

<c:choose>
    <c:when test="${this.category.hasChildren}">
        <syswf:control mode="script" action="${affectedComponent}$onShowChildrenOf"
            affects="${affectedComponent}" caption="${newFunctionName}">
            <syswf:param name="parent" value="${this.category}" />
            <syswf:param name="${tableId}_resetPaging" value="true" />
            <syswf:param name="${tableId}_resetFilter" value="true" />
        </syswf:control>
        <c:choose>
        	<c:when test="${not empty rowIndex}">
	        <a id="${newFunctionName}${rowIndex}Id" href="javascript:void(0)"><syswf:out value="${this.category.category.name}" context="HtmlBody"/></a>
	        <script type="text/javascript">
	        //<![CDATA[

	        	attachOn('${newFunctionName}${rowIndex}Id', 'click', ${newFunctionName});
	        
		    //]]>
	        </script>
        	</c:when>
        	<c:otherwise>
        	<a id="${newFunctionName}Id" href="javascript:void(0)"><syswf:out value="${this.category.category.name}" context="HtmlBody"/></a>
	        <script type="text/javascript">
	        //<![CDATA[

	        	attachOn('${newFunctionName}Id', 'click', ${newFunctionName});
	        
		    //]]>
	        </script>
        	</c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <syswf:out value="${this.category.category.name}" context="HtmlBody"/>
    </c:otherwise>
</c:choose>