<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<syswf:component name="/core/layout/header" prefix="h">
</syswf:component>

<syswf:component name="/core/layout/dropdowns" prefix="c">
    <syswf:param name="customizationId" value="${this.contentCustomizationId}"/>
    <syswf:param name="workingDomain" value="${this.workingDomainId}"/>
    <syswf:param name="contractAdministrator" value="${this.contractAdministrator}"/>
    <syswf:param name="hideSingleTab" value="true"/>
</syswf:component>
