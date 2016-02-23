<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

    <syswf:component name="/core/table" prefix="${tabId}">
       <syswf:param name="customizationId" value="shared.providerSelector.${tabId}"/>
       <syswf:param name="datasource" value="${datasource}"/>
       <syswf:param name="selectionBag" value="${selectionBag}" />
    </syswf:component>
