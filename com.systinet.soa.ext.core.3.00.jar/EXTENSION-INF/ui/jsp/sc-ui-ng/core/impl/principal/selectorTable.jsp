<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf" %>

<syswf:component name="/core/table" prefix="principal1">
   <syswf:param name="customizationId" value="${tableCustomizationId}"/>
   <syswf:param name="datasource" value="${tableDataSource}"/>
   <syswf:param name="selectionBag" value="${tableSelectionBag}" />
   <syswf:param name="overrideselectionModel" value="${overrideselectionModel}" />
</syswf:component>