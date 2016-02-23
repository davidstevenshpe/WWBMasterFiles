<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${globalSession['userDefaultLanguage']}" scope="page" />
<fmt:setBundle basename="com.hp.systinet.sc.ui.composite.compositeMessages" var="compositeMessages"/>

<syswf:control mode="ajax" caption="${loadParentPathsFunctionName}" action="showMoreParents"/>

<div class="BreadcrumbsCloud">
    <c:choose>
        <c:when test="${not empty this.parentPaths || not empty this.cutParentPaths}">        
            <c:forEach items="${this.parentPaths}" var="parentPath" varStatus="outerStatus">
                <div class="BreadcrumbsGroup">               
                    <c:forEach items="${parentPath}" var="pathElement" varStatus="innerStatus">
                        <syswf:control id="${prefix}_${outerStatus.index}_${innerStatus.index}" mode="anchor" caption="${pathElement.name}" targetTask="/artifact/${pathElement.uuid}">
                            <syswf:param name="artifactTabId" value="treeView"/>
                            <syswf:param name="compositeBrowser.parentPath" value="${pathElement.pathPrefix}"/>
                        </syswf:control>
                        &gt;
                    </c:forEach>
                    <c:out value="${artifact.name}"/>
                </div>
            </c:forEach>
            <c:forEach items="${this.cutParentPaths}" var="parentPath" varStatus="outerStatus">
                <div class="BreadcrumbsGroup">                   
                    <c:forEach items="${parentPath}" var="pathElement" varStatus="innerStatus">                
                        <c:if test="${innerStatus.first}">
                           ... &gt;
                        </c:if>                    
                        <syswf:control id="${prefix}_cut_${outerStatus.index}_${innerStatus.index}" mode="anchor" caption="${pathElement.name}" targetTask="/artifact/${pathElement.uuid}">
                            <syswf:param name="artifactTabId" value="treeView"/>
                            <syswf:param name="compositeBrowser.parentPath" value="${pathElement.pathPrefix}"/>
                        </syswf:control>
                        &gt;
                    </c:forEach>
                    <c:out value="${artifact.name}"/>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="BreadcrumbsGroup">
                <c:out value="${artifact.name}"/>
            </div>
        </c:otherwise>
    </c:choose>
</div>