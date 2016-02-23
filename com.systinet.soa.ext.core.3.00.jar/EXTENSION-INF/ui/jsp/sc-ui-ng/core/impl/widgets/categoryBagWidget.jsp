<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--@elvariable id="title" type="String"--%>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.edit.EditMessages" var="editMessages"/>
<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<c:if test="${not empty this.categories || this.widgetMode eq 'edit'}">
<c:set var="titleVar">
    <c:choose>
        <c:when test="${empty title}">
            <fmt:message key="categoryBag.title" bundle="${widgetMessages}"/>
        </c:when>
        <c:otherwise>
            <c:out value="${title}"/>
        </c:otherwise>
    </c:choose>
</c:set>

<syswf:block className="UI Block Common">
<c:if test="${empty doNotWrap}">
<div class="Title">
    <h3>
        <span><c:out value="${titleVar}"/></span>
    </h3>
</div>
</c:if>
<div class="Content">
<table class="UI Table Properties">
    <colgroup>
        <col class="MidLabelCol"/>
        <col class="ShortSpacerCol" />
        <col />
    </colgroup>
    <tbody>
    <c:forEach items="${this.categories}" var="item" varStatus="cstat">
        <tr>
            <th><label class="UI Label Inline" title="<c:out value="${item.taxonomyDescription}" />"><c:out value="${item.taxonomyName}" />: </label></th>
            <td></td>
            <td class="Vertical-Mid">
            	<c:set var="existingError" value="false"/>
                <c:forEach items="${item.values}" var="category" varStatus="stat">
                    <%-- settings as variable to ensure there is no space before comma --%>
                    <c:set var="itemValue">
                    	<c:choose>
                    		<c:when test="${category.error}">
                    			<c:set var="existingError" value="true" />
                    			
                    			<fmt:message var="categoryNotFound" key="categoryBag.categoryNotFound" bundle="${widgetMessages}">
									<fmt:param><c:out value="'${category.displayValue}'"/></fmt:param>
									<fmt:param><c:out value="'${item.taxonomyName}'"/></fmt:param>
								</fmt:message>								
                    			<span title="${categoryNotFound}" class="x-form-invalid-msg UI Invalid"><c:out value="${category.displayValue}"/></span>
                    		</c:when>
                    		<c:otherwise>
                    			<c:out value="${category.displayValue}" />
                    		</c:otherwise>
                    	</c:choose>
                    	
                        <c:if test="${this.widgetMode eq 'edit'}">
                            <syswf:control id="remove${item.taxonomyName}${category.category.val}" mode="anchor" action="remove" caption="Delete" wrapper="span">
                                <syswf:param name="taxonomyUri" value="${item.taxonomyUri}"/>
                                <syswf:param name="categoryVal" value="${category.category.val}"/>
                                <syswf:attribute name="class" value="UI Icon Delete Context"/>
                            </syswf:control>
                        </c:if>
                    </c:set>
                    
                    <c:set var="separator">
                        <c:choose>
                            <c:when test="${category.showParents}"><br/></c:when>
                            <c:when test="${this.widgetMode eq 'edit'}">&nbsp;&nbsp;</c:when>
                            <c:otherwise><c:if test="${not stat.last}">,</c:if></c:otherwise>
                        </c:choose>
                    </c:set>

                    <c:out value="${itemValue}" escapeXml="false"/>${separator}
                </c:forEach>
                <c:if test="${(this.widgetMode eq 'edit') and (not existingError)}">
                	<span>
	                    <syswf:component name="/core/impl/widget/util/taxonomyBrowserButton" prefix="addbut${cstat.index}" wrap="false">
	                        <syswf:param name="selectedCategories" value="${this.selectedCategories}"></syswf:param>
	                        <syswf:param name="taxonomyBrowserListener" value="${this}"></syswf:param>
	                        <syswf:param name="hiddenShowAllTaxonomies" value="true" />
	                        <syswf:param name="buttonText" value="" />
	                        <syswf:param name="iconType" value="edit"/> <%-- change icon to edit icon --%>
	                        <syswf:param name="preSelectedTaxonomy" value="${item.taxonomyRow}"/>
	                    </syswf:component>
	                </span>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    <c:if test="${this.widgetMode eq 'edit'}">
    <c:forEach items="${this.emptyCategories}" var="item" varStatus="stat">
        <tr>
            <th><label class="UI Label Inline"><c:out value="${item.value.taxonomyName}" />: </label></th>
            <td></td>
            <td>
                <syswf:component name="/core/impl/widget/util/taxonomyBrowserButton" prefix="button${stat.index}">
                    <syswf:param name="selectedCategories" value="${this.selectedCategories}"></syswf:param>
                    <syswf:param name="taxonomyBrowserListener" value="${this}"></syswf:param>
                    
                    <syswf:param name="buttonText" value="Click here to set" />
                    <syswf:param name="preSelectedTaxonomy" value="${item.value.taxonomyRow}"/>
                </syswf:component>
            </td>
        </tr>
    </c:forEach>
    </c:if>
    </tbody>
</table>
</div>
<div class="Title">
<c:if test="${this.widgetMode eq 'edit'}">

<syswf:component name="/core/impl/widget/util/taxonomyBrowserButton" prefix="button">
    <syswf:param name="selectedCategories" value="${this.selectedCategories}" />
    <syswf:param name="taxonomyBrowserListener" value="${this}" />
</syswf:component>

</c:if>
</div>
</syswf:block>
</c:if>