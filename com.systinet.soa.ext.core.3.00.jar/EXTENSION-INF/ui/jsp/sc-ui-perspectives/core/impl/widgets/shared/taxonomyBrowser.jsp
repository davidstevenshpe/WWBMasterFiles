<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages" />

<%-- choose whether to display single selected taxonomy tree or list of all taxonomies --%>
<c:if test="${not empty annotation}">
	<div>
		<label class="UI Label Inline">
			<span class="Comment">${annotation}</span>
		</label>
	</div>
</c:if>

<c:if test="${not this.showAll}">

    <div class="UI PathTracker">
    <c:if test="${empty hiddenShowAllTaxonomies}">
    	<c:set var="hiddenShowAllTaxonomies" value="false"/>
    </c:if>
    <c:if test="${not hiddenShowAllTaxonomies}">
	    <%-- link to all taxonomies --%>
	    <c:set var="showTaxonomyList" value="${prefix}showTaxonomyList"/>
		    <syswf:control id="${showTaxonomyList}" mode="script" affects="${prefix}"
		        action="onShowAllTaxonomies" caption="${showTaxonomyList}">
                <syswf:param name="${tableId}_resetPaging" value="true" />
                <syswf:param name="${tableId}_resetFilter" value="true" />
            </syswf:control>
	    
	    <c:set var="showTaxonomyListId" value="${prefix}showTaxonomyListId"/>
	    <a href="javascript:void(0)" id="${showTaxonomyListId}" class="UI Icon Root">
	        <span><fmt:message key="changeTaxonomy" bundle="${widgetMessages}" /></span>
	    </a> 
	    <script type="text/javascript">
//<![CDATA[

	        attachOn('${showTaxonomyListId}', 'click', ${showTaxonomyList})
	    
//]]>
</script>
    </c:if>
    
    <%-- link taxonomy root --%>
    <span class="UI PathSeparator">&nbsp;</span>
    <syswf:control id="showTaxonomy" mode="script" affects="."
        action="onShowChildrenOf" caption="${prefix}showTaxonomyRoot">
        <syswf:param name="${tableId}_resetPaging" value="true" />
        <syswf:param name="${tableId}_resetFilter" value="true" />
    </syswf:control>
    <a href="javascript:void(0)" id="${prefix}tax" class="UI Icon Branch"><syswf:out value="${this.categoryDatasource.taxonomy.name}" context="HtmlBody"/></a>
    <script type="text/javascript">
    //<![CDATA[

        attachOn('${prefix}tax', 'click', ${prefix}showTaxonomyRoot)
    
    //]]>
    </script>
    
    <%-- path to parent --%>
    <c:forEach items="${this.pathToParent}"
        var="categoryHolder" varStatus="status"
    >
        <span class="UI PathSeparator">&nbsp;</span>

        <c:choose>
            <c:when test="${categoryHolder.hasChildren}">
                <c:set var="classes" value="UI Icon Branch" />
            </c:when>
            <c:otherwise>
                <c:set var="classes" value="UI Icon Leaf" />
            </c:otherwise>
        </c:choose>
        
        <c:set var="functionName" value="${prefix}showTaxonomyBranch${status.index}"/>
        <syswf:control id="${functionName}" mode="script" affects="${prefix}"
            action="onShowChildrenOf" caption="${functionName}">
            <syswf:param name="parent" value="${categoryHolder}"/>
            <syswf:param name="${tableId}_resetPaging" value="true" />
            <syswf:param name="${tableId}_resetFilter" value="true" />
        </syswf:control>
        <c:set var="anchorId" value="${prefix}showChildren${status.index}a"/>
        <a id="${anchorId}" href="javascript:void(0)" class="${classes}">
            <span><syswf:out value="${categoryHolder.category.name}" context="HtmlBody"/></span>
        </a>
        <script type="text/javascript">
        //<![CDATA[

            attachOn('${anchorId}','click',${functionName})
        
        //]]>
        </script>
    </c:forEach> 
    
    </div>
</c:if>

<c:choose>
    <c:when test="${this.showAll}">
        <syswf:component name="/core/table" prefix="allTaxonomies">
            <syswf:param name="customizationId" value="shared.widget.taxonomyTable" />
            <syswf:param name="dontCustomize" value="true" />
            <syswf:param name="affectedComponent" value="${prefix}" />
            <syswf:param name="datasource" value="${this.taxonomiesDatasource}" />
            <syswf:param name="parentWindowId" value="${windowContentId}" />
            <syswf:param name="tableId" value="${tableId}" />
        </syswf:component>
    </c:when>
    <c:otherwise>
        <syswf:component name="/core/table" prefix="taxonomy">
            <syswf:param name="customizationId" value="shared.widget.categoryTable" />
            <syswf:param name="dontCustomize" value="true" />
            <syswf:param name="datasource" value="${this.categoryDatasource}" />
            <syswf:param name="selectionBag" value="${this.categorySelectionBag}" />
            <syswf:param name="affectedComponent" value="${prefix}" />
            <syswf:param name="parentWindowId" value="${windowContentId}" />
            <syswf:param name="tableId" value="${tableId}" />
            <c:if test="${singleSelection}">
                <syswf:param name="overrideselectionModel" value="one"/>
            </c:if>
        </syswf:component>
    </c:otherwise>
</c:choose>

<syswf:control mode="script" action="onCancel" caption="${cancelFunc}" affects="..">
    <syswf:param name="${tableId}_resetPaging" value="true" />
    <syswf:param name="${tableId}_resetFilter" value="true" />
</syswf:control>