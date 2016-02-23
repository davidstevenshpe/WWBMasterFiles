<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<%--@elvariable id="node" type="com.hp.systinet.sc.catalog.ArtifactTree.Node"--%>
<%--@elvariable id="funcGetChecked" type="java.lang.String"--%>
<%--@elvariable id="singleHolder" type="com.hp.systinet.sc.ui.util.ArtifactTreeComponent.SelectOne"--%>
<%--@elvariable id="preselected" type="java.lang.Boolean"--%>
<%--@elvariable id="preselectedSdmNames" type="java.util.List"--%>

{
    text : '<syswf:addSlashes>${node.label.string}</syswf:addSlashes>',
    <c:if test="${not empty singleHolder}">
    href : '<syswf:addSlashes><syswf:control mode="href" action="select" /></syswf:addSlashes>',
    </c:if>
    <c:if test="${not empty funcGetChecked}">
    checked : ${preselected},
    id : '${node.descriptor.sdmName}',
    </c:if> 
    <c:choose>
        <c:when test="${not empty node.children}">
            cls : <syswf:jsonValue value="folder" />
            ,children: [
                <c:forEach items="${node.children}" var="child" varStatus="status">
                    <syswf:component name="/core/impl/util/artifactTreeNode" prefix="node${status.index}" wrap="false">
                        <syswf:param name="node" value="${child}" />
                        <syswf:param name="singleHolder" value="${singleHolder}" />
                        <syswf:param name="funcGetChecked" value="${funcGetChecked}" />
                        <syswf:param name="preselectedSdmNames" value="${preselectedSdmNames}"/>                        
                    </syswf:component>
                    <c:if test="${not status.last}">,</c:if>
                </c:forEach>
            ]
        </c:when>
        <c:otherwise>
            leaf : <syswf:jsonValue value="true" />
        </c:otherwise>
    </c:choose>
}
