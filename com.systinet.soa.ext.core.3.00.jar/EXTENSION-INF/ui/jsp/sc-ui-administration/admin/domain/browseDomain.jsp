<%@ taglib prefix="syswf" uri="http://systinet.com/jsp/syswf"%>

<syswf:component name="/core/layout/header" prefix="header" wrap="false">
    <syswf:param name="iconFormat" value="small" />
</syswf:component>

<syswf:component name="/core/table" prefix="browseDomain" wrap="true">
    <syswf:param name="customizationId" value="admin.domain.table" />
    <syswf:param name="datasource" value="${domainsDataSource}"/>	    
</syswf:component>
