<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:if test="${not empty globalSession['userName']}">
    <fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page"/>
</c:if>

<fmt:setBundle basename="com.hp.systinet.sc.ui.taxonomy.taxonomyBrowserMessages" var="taxMessages"/>

<syswf:component name="/core/layout/header" prefix="taxBrowser">
    <syswf:param name="title" value="${viewInstance.caption}"/>
    <syswf:param name="subtitle" value="${viewInstance.additionalTitle}"/>
    <syswf:param name="iconType" value="taxonomyArtifact"/>
    <syswf:param name="subtitleClass" value="Artifact"/>
</syswf:component>

<c:if test="${not empty currentTaxonomy}">
    <div class="UI Text Description">
      <syswf:out value="${currentTaxonomy.description}" context="Identity"/>
    </div>
</c:if>

<c:choose>
    <c:when test="${not empty datasource}">
        <syswf:block className="UI Block Green">
            <div class="Content">
                <div class="UI Layout Bookmarks">
                    <c:choose>
                        <c:when test="${not empty currentCategory}">
                            <fmt:message bundle="${taxMessages}" var="upToCategory" key="upToCategory">
                                <c:choose>
                                <c:when test="${not (categoryId eq currentCategory.parentId)}">
                                    <fmt:param >${parentCategory.name}</fmt:param>
                                </c:when>
                                <c:otherwise>
                                    <fmt:param>${currentTaxonomy.name}</fmt:param>
                                </c:otherwise>
                                </c:choose>
                            </fmt:message>
                            <syswf:control mode="anchor" wrapper="span" caption="${upToCategory}" targetTask="/common/categorization/categoryView" targetDepth="${sessionStack.currentDepth-1}">
                                <syswf:param name="tModelKey">${currentCategory.tModelKey}</syswf:param>
                                <c:if test="${not (categoryId eq currentCategory.parentId)}">
                                    <syswf:param name="categoryId">${currentCategory.parentId}</syswf:param>
                                </c:if>
                                <syswf:attribute name="class" value="Bookmark Category GoUp" />
                            </syswf:control>
                        </c:when>
                        <c:otherwise>
                            <fmt:message bundle="${taxMessages}" var="viewAllCategories" key="viewAllCategories" />
                            <syswf:control mode="anchor" wrapper="span" caption="${viewAllCategories}" targetTask="/common/categorization/categoryView" targetDepth="0">
                                <syswf:attribute name="class" value="Bookmark Category GoUp" />
                            </syswf:control>
                        </c:otherwise>
                    </c:choose>
                    <c:forEach items="${categoryCount}" var="category" varStatus="status">
                        <syswf:component name="/core/impl/taxonomy/categoryLink" prefix="catlink${status.index}" wrap="false">
                            <syswf:param name="categoryCount" value="${category}" />
                            <syswf:param name="class" value="Bookmark Category" />
                        </syswf:component>
                    </c:forEach>
                </div>
            </div>
        </syswf:block>
        
        <syswf:block className="UI Block Common">
            <div class="Title">
                <h3><span><fmt:message bundle="${taxMessages}" key="tableHeader" /></span></h3>
            </div>
            <div class="Content">
			    <syswf:component name="/core/table" prefix="header" wrap="false">
		            <syswf:param name="customizationId" value="${viewId}.taxonomy.table" />
		            <syswf:param name="datasource" value="${datasource}" />
		        </syswf:component>
	        </div>
        </syswf:block>
    </c:when>
    <c:otherwise>
        <syswf:component prefix="all" name="/core/taxonomy/all/allCategoriesView">
            <syswf:param name="maxCategories" value="10" />
             <c:if test="${not empty views}">
            	<syswf:param name="views" value="${views}" />
            </c:if>
        </syswf:component>
    </c:otherwise>
</c:choose>
