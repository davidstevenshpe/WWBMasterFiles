<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${contentInfo.hasContent}">

    <syswf:component prefix="data" name="/core/impl/table/staticTableData">
        <syswf:param name="datasource" value="${datasourceInstance}"/>
        <syswf:param name="order" value="${order}"/>
        <syswf:param name="table" value="${table}"/>
        <syswf:param name="selectionBag" value="${selectionBag}"/>
        <syswf:param name="paginator" value="${paginator}"/>
        <syswf:param name="tableId" value="${tableId}"/>
        <syswf:param name="hasFilter" value="${hasFilter}"/>
        <syswf:param name="contentInfo" value="${contentInfo}"/>
    </syswf:component>

</c:if>

<c:if test="${not empty actions}">
    <syswf:component prefix="toolbar" name="/core/impl/table/staticActions">
        <syswf:param name="actions" value="${actions}"/>
        <syswf:param name="tableId" value="${tableId}"/>
        <syswf:param name="selectionBag" value="${selectionBag}"/>
        <syswf:param name="contentInfo" value="${contentInfo}"/>
    </syswf:component>
</c:if>
