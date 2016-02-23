<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:component name="/core/table" prefix="scTable">
    <syswf:param name="customizationId" value="shared.customization.categories.selectCategoriesTable" />
    <syswf:param name="datasource" value="${taxonomyDatasource}" />
    <syswf:param name="selectionBag" value="${selectionBag}" />
</syswf:component>