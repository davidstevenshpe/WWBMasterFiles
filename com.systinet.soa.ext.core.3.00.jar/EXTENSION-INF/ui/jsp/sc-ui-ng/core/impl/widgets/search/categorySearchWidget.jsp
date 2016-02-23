<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setBundle basename="com.hp.systinet.sc.ui.impl.widgets.WidgetMessages" var="widgetMessages"/>
<fmt:message key="addPackage" var="addPackage" bundle="${widgetMessages}" />

<c:if test="${not empty globalSession['userName']}">
   <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>
<c:forEach items="${this.webConditions}" var="condition" varStatus="status">
    <c:set var="inputId" value="${prefix}_combo${status.index}" />
    <syswf:control id="${prefix}remove${status.index}" mode="script" caption="${prefix}remove${status.index}" action="onRemove" affects="..">
        <syswf:param name="condition" value="${condition}" />
    </syswf:control>
<c:set var="content">
	<c:choose>
    	<c:when test="${this.hierarchical || this.multiple}">
    		
     			<c:forEach items="${this.categories}" var="category" varStatus="stat">
	     			<c:set var="itemValue">
	            	<c:choose>
	            		<c:when test="${category.error}">
	            			<fmt:message var="categoryNotFound" key="category.categoryNotFound" bundle="${widgetMessages}">
								<fmt:param><c:out value="'${category.displayValue}'"/></fmt:param>
							</fmt:message>
	                  		<span title="${categoryNotFound}" class="x-form-invalid-msg UI Invalid"><c:out value="${category.displayValue}"/></span>
	            		</c:when>
	
	            		<c:otherwise>
	            			<c:out value="${category.displayValue}" />
	            		</c:otherwise>
	            	</c:choose>
	                    <syswf:control id="remove${category.category.val}" mode="anchor" action="remove" caption="Delete" wrapper="span">
	                        <syswf:param name="categoryVal" value="${category.category.val}"/>
	                        <syswf:attribute name="class" value="UI Icon Delete Context"/>
	                    </syswf:control>
	            </c:set>
	            <c:out value="${itemValue}" escapeXml="false"/>
     		</c:forEach>
            <syswf:component name="/core/impl/widget/util/taxonomyBrowserButton" prefix="addbut${status.index}" wrap="false">
                <syswf:param name="selectedCategories" value="${this.categories}"></syswf:param>
                <syswf:param name="taxonomyBrowserListener" value="${this}"></syswf:param>
                <syswf:param name="hiddenShowAllTaxonomies" value="true" />
                <syswf:param name="singleSelection" value="${not this.multiple}" />

                <syswf:param name="buttonText" value="${addPackage}" />
                <syswf:param name="iconType" value="plus-circle"/>
                <syswf:param name="preSelectedTaxonomy" value="${this.taxonomyRow}"/>
            </syswf:component>
    	</c:when>
    	<c:otherwise>
        <syswf:selectOne name="widgetInput${status.index}" displayAsRow="true" mode="menu" 
            value="${condition}" optionValues="${this.valuesList}" optionCaptions="${this.namesList}" property="value"
            id="${inputId}" />
            <script type="text/javascript">
//<![CDATA[

    
        Ext.onReady(function() {
            var search_artifact_type = new Ext.HP.ComboBox({
                id: '${inputId}',
                transform: '${inputId}',
                forceSelection: true,
                typeAhead: true,
                disableKeyFilter: false,
                editable: false,
                width: 200
            });
        });

    
//]]>
</script>
    	</c:otherwise>
	</c:choose>
</c:set>
    <syswf:component name="/core/impl/widget/search/widgetWrapper" prefix="${inputId}Wrapped">
        <syswf:param name="content" value="${content}"/>
        <syswf:param name="webCondition" value="${condition}"/>
        <syswf:param name="inputId" value="${inputId}"/>
        <syswf:param name="visible" value="${visible}"/>
        <syswf:param name="status" value="${status}"/>
        <syswf:param name="firstRemovable" value="${this.model.firstRemovable}" />
        <syswf:param name="removeFce" value="${prefix}remove${status.index}"/>
    </syswf:component>
</c:forEach>