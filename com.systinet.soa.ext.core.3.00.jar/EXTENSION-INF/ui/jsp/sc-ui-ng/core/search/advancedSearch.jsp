<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:component name="/core/layout/columns" prefix="${prefix}_advancedSearch" params="${searchInitializationParams}">
    <syswf:param name="customizationId" value="${customizationId}" />
    <syswf:param name="searchDefinition" value="${searchDefinition}" />
    <syswf:param name="kind" value="browse"/>
</syswf:component>