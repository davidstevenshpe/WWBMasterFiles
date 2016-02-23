<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:component name="/core/layout/columns" prefix="${reportId}" wrap="false">
    <syswf:param name="customizationId" value="${reportCustomizationId}" />
    <syswf:param name="kind" value="reports" />
</syswf:component>
