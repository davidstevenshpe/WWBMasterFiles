<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.schema.schemaMessages" var="schemaMessages"/>

<fmt:message var="viewSchemaIndexLabel" key="schemaElement.schemaIndex" bundle="${schemaMessages}"/>
<fmt:message var="couldNotFoundMsg" key="couldNotFound" bundle="${schemaMessages}"/>

<c:if  test="${empty localNameAlias}">
    <c:set var="localNameAlias" value="${element.localName}" />
</c:if>

<div style="float:right;font-style:italic"></div>

<div style="float: right; font-style: italic;">
    <a onclick="${goToFunction}({elementViewType: 'schema', elementUuid: '', elementLocalName: '', elementNamespace: '${namespace}'});" href="javascript:void(0);" ><c:out value="${viewSchemaIndexLabel}"/></a>
</div>

<h1 class="RootElementTitle">
    <c:if test="${not empty localNameAlias}">
        <span title="Root element type name"><syswf:out value="${localNameAlias}" context="HtmlBody"/></span>:
    </c:if>
    <c:if test="${not empty localName}">
        <span title="Root element name"><syswf:out value="${localName}" context="HtmlBody"/></span>
    </c:if>
</h1>

<div class="TypeNS" title="Type namespace"><syswf:out value="${namespace}" context="HtmlBody"/></div>


<c:choose>
	<c:when test="${empty element}" >
		<c:out value="${couldNotFoundMsg}" escapeXml="true" />	
	</c:when>
	
	<c:otherwise>
		<p style="font-style: italic;" class="TypeDocumentation">
			<syswf:out value="${element.documentation}" context="HtmlBody"/>
		</p>
		
		<syswf:component name="/core/schema/elementStructure" prefix="schemaElement">
		    <syswf:param name="localNameAlias" value="${localNameAlias}" />
		    <syswf:param name="element" value="${element}" />
		    <syswf:param name="goToFunction" value="${goToFunction}" />
		    <syswf:param name="referencedItemResolver" value="${referencedItemResolver}" />
		    <syswf:param name="typeNestingLevel" value="${0}" />
		    <syswf:param name="maximumNestingLevel" value="${complexityLevel}" />
		</syswf:component>	
	</c:otherwise>
	
</c:choose>	





    
    
    

