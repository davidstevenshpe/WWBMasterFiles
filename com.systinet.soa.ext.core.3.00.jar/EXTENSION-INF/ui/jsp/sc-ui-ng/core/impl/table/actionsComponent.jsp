<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- render cotrols part --%>
<syswf:component name="/core/impl/table/actionsControls" prefix="controls" wrap="false">
    <syswf:param name="actionHolders" value="${actionHolders}" />
    <syswf:param name="datasource" value="${datasource}"/>
    <syswf:param name="tableColumns" value="${tableColumns}"/>
    <syswf:param name="rowPreview" value="${rowPreview}"/>
</syswf:component>

<%-- render toolbar buttons part --%>

<script type="text/javascript">
//<![CDATA[


    <c:set var="contentRendered" value="${false}"/>
    
    var ${tableId}Toolbar = [ 
        <c:forEach var="item" items="${actionHolders}" varStatus="status">
            <c:choose>
                <c:when test="${item.type == 'ruler'}">
                    <c:if test="${contentRendered}">,</c:if>
                    '-'
                    <c:set var="contentRendered" value="${true}"/>
                </c:when>
                <c:when test="${item.visible}">
                    <c:set var="itemContent">
                        <syswf:component name="/core/impl/table/actionsItem" prefix="item${status.index}" wrap="false">
                           <syswf:param name="item" value="${item}" />
                        </syswf:component>
                    </c:set>
                    <c:if test="${not empty itemContent}" >
                        <c:if test="${contentRendered}">,</c:if>
                        ${itemContent}
                        <c:set var="contentRendered" value="${true}"/>
                    </c:if>
                </c:when>
            </c:choose>
        </c:forEach>
    ];

//]]>
</script>