<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:control mode="script" action="save" caption="${prefix}save" affects="." />

<syswf:component name="/core/impl/listEditorTable" prefix="tab">
    <syswf:param name="table" value="${table}" />
    <syswf:param name="datasource" value="${dataSource}" />
    <syswf:param name="positionSaveFunc" value="${prefix}save" />
    <syswf:param name="selectionListener" value="${selectionListener}" />
    <syswf:param name="affectedComponent" value="${affectedComponent}" />
</syswf:component>